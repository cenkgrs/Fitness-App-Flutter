import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/models/models.dart';
import '../domain/auth_repository.dart';

/// Real backend implementation of [AuthRepository], backed by Supabase Auth.
/// Matches [AuthRepository] exactly so no other call site (AuthController,
/// screens, router redirect) needs to change.
///
/// Google sign-in (and Apple off iOS) uses Supabase's OAuth browser flow
/// (`signInWithOAuth`), which requires the provider to be enabled in the
/// Supabase dashboard (Authentication > Providers) and a redirect URL
/// registered there plus the matching deep link configured natively
/// (Android intent-filter / iOS URL scheme) before it will complete.
/// On iOS, Apple sign-in uses the native sheet and hands the identity token
/// to Supabase (`signInWithIdToken`), which only needs the bundle ID listed
/// under the Apple provider's Client IDs in the dashboard.
class SupabaseAuthRepository implements AuthRepository {
  final sb.SupabaseClient _client;

  // Must match: the Android intent-filter in
  // android/app/src/main/AndroidManifest.xml, CFBundleURLTypes in
  // ios/Runner/Info.plist, and be added to Supabase
  // Dashboard > Authentication > URL Configuration > Redirect URLs.
  static const _oauthRedirectUrl = 'com.silveroaktech.thrive://login-callback';

  SupabaseAuthRepository(this._client);

  static bool get _isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  AppUser? _mapUser(sb.User? user) {
    if (user == null) return null;
    final metadata = user.userMetadata ?? const {};
    return AppUser(
      id: user.id,
      email: user.email,
      displayName: metadata['full_name'] as String? ?? metadata['name'] as String?,
      photoUrl: metadata['avatar_url'] as String?,
      authProvider: user.appMetadata['provider'] as String? ?? 'email',
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return _client.auth.onAuthStateChange.map((event) {
      // On iOS the OAuth page opens in an in-app Safari sheet, which stays
      // on screen after the deep link hands the session back to the app.
      if (event.event == sb.AuthChangeEvent.signedIn && _isIOS) {
        closeInAppWebView();
      }
      return _mapUser(event.session?.user);
    });
  }

  @override
  Future<AppUser?> currentUser() async => _mapUser(_client.auth.currentUser);

  @override
  Future<AppUser> signInWithEmail({required String email, required String password}) async {
    final res = await _client.auth.signInWithPassword(email: email, password: password);
    final user = _mapUser(res.user);
    if (user == null) throw StateError('Sign-in succeeded but returned no user.');
    return user;
  }

  @override
  Future<AppUser> signUpWithEmail({required String email, required String password}) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: _oauthRedirectUrl,
    );
    final user = _mapUser(res.user);
    if (user == null) throw StateError('Sign-up succeeded but returned no user.');
    if (res.session == null) throw const EmailConfirmationRequired();
    return user;
  }

  Future<void> _startOAuth(sb.OAuthProvider provider) async {
    try {
      await _client.auth.signInWithOAuth(provider, redirectTo: _oauthRedirectUrl);
    } on PlatformException catch (e) {
      // iOS reports "Error while launching" when the in-app Safari sheet
      // never finishes loading a page — which is exactly what happens when
      // the provider session is already signed in and redirects straight
      // back to the app. The sign-in still completes via the deep link, and
      // a real load failure is shown by Safari's own error page.
      if (!_isIOS || !(e.message ?? '').startsWith('Error while launching')) rethrow;
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await _startOAuth(sb.OAuthProvider.google);
    // signInWithOAuth redirects out to the browser/native flow; the actual
    // session arrives asynchronously via authStateChanges(). Callers should
    // watch authStateProvider rather than this method's return value.
    final user = _mapUser(_client.auth.currentUser);
    if (user == null) throw StateError('OAuth flow started; awaiting redirect.');
    return user;
  }

  @override
  Future<AppUser> signInWithApple() async {
    if (!_isIOS) {
      await _startOAuth(sb.OAuthProvider.apple);
      final user = _mapUser(_client.auth.currentUser);
      if (user == null) throw StateError('OAuth flow started; awaiting redirect.');
      return user;
    }

    // Apple gets the SHA-256 of the nonce, Supabase the raw value, so the
    // id token can't be replayed outside this sign-in attempt.
    final rawNonce = _generateNonce();
    final AuthorizationCredentialAppleID credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
        nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) throw StateError('Sign-in cancelled.');
      rethrow;
    }
    final idToken = credential.identityToken;
    if (idToken == null) throw StateError('Apple sign-in returned no identity token.');

    final res = await _client.auth.signInWithIdToken(
      provider: sb.OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );

    // Apple only shares the user's name on the very first authorization and
    // never puts it in the id token, so store it while we have it.
    final fullName = [credential.givenName, credential.familyName]
        .whereType<String>()
        .join(' ')
        .trim();
    if (fullName.isNotEmpty) {
      final updated = await _client.auth.updateUser(sb.UserAttributes(data: {'full_name': fullName}));
      final user = _mapUser(updated.user);
      if (user != null) return user;
    }

    final user = _mapUser(res.user);
    if (user == null) throw StateError('Sign-in succeeded but returned no user.');
    return user;
  }

  static String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPasswordForEmail(String email) async {
    // Reuses the same registered redirect URL as OAuth — Supabase
    // distinguishes the flow from the recovery token in the link itself,
    // not from which redirect URL was used to request it.
    await _client.auth.resetPasswordForEmail(email, redirectTo: _oauthRedirectUrl);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(sb.UserAttributes(password: newPassword));
  }

  @override
  Stream<bool> passwordRecoveryEvents() {
    return _client.auth.onAuthStateChange
        .where((event) => event.event == sb.AuthChangeEvent.passwordRecovery)
        .map((_) => true);
  }

  @override
  Future<void> deleteAccount() async {
    final res = await _client.functions.invoke('delete-account');
    final error = (res.data as Map?)?['error'];
    if (error != null) throw StateError(error.toString());
    await _client.auth.signOut();
  }
}
