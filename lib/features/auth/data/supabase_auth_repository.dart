import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/auth_repository.dart';

/// Real backend implementation of [AuthRepository], backed by Supabase Auth.
/// Matches [AuthRepository] exactly so no other call site (AuthController,
/// screens, router redirect) needs to change.
///
/// Google/Apple sign-in use Supabase's OAuth browser flow
/// (`signInWithOAuth`), which requires the provider to be enabled in the
/// Supabase dashboard (Authentication > Providers) and a redirect URL
/// registered there plus the matching deep link configured natively
/// (Android intent-filter / iOS URL scheme) before it will complete.
class SupabaseAuthRepository implements AuthRepository {
  final sb.SupabaseClient _client;

  // Must match: the Android intent-filter in
  // android/app/src/main/AndroidManifest.xml, and be added to Supabase
  // Dashboard > Authentication > URL Configuration > Redirect URLs.
  static const _oauthRedirectUrl = 'com.silveroaktech.thrive://login-callback';

  SupabaseAuthRepository(this._client);

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
    return _client.auth.onAuthStateChange.map((event) => _mapUser(event.session?.user));
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
    final res = await _client.auth.signUp(email: email, password: password);
    final user = _mapUser(res.user);
    if (user == null) throw StateError('Sign-up succeeded but returned no user.');
    return user;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(sb.OAuthProvider.google, redirectTo: _oauthRedirectUrl);
    // signInWithOAuth redirects out to the browser/native flow; the actual
    // session arrives asynchronously via authStateChanges(). Callers should
    // watch authStateProvider rather than this method's return value.
    final user = _mapUser(_client.auth.currentUser);
    if (user == null) throw StateError('OAuth flow started; awaiting redirect.');
    return user;
  }

  @override
  Future<AppUser> signInWithApple() async {
    await _client.auth.signInWithOAuth(sb.OAuthProvider.apple, redirectTo: _oauthRedirectUrl);
    final user = _mapUser(_client.auth.currentUser);
    if (user == null) throw StateError('OAuth flow started; awaiting redirect.');
    return user;
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
