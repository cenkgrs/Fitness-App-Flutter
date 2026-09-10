import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/providers/remote_sync.dart';
import '../../../../shared/models/models.dart';
import '../../data/local_auth_repository.dart';
import '../../data/supabase_auth_repository.dart';
import '../../domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (SupabaseConfig.isConfigured) {
    return SupabaseAuthRepository(Supabase.instance.client);
  }
  return LocalAuthRepository(ref.watch(localStorageServiceProvider));
});

/// Streams the current authenticated user (or null when signed out).
/// Screens/router watch this to decide auth vs. main-app navigation.
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

/// Best-effort profile/settings sync from Supabase whenever the
/// authenticated user changes — covers every sign-in path uniformly,
/// including the OAuth redirect flow (which completes asynchronously via
/// [authStateProvider], not through a method return value this controller
/// can hook directly). Watched once from `RepwiseApp.build()` to stay alive
/// for the app's lifetime; `main.dart` separately awaits the same sync
/// before `runApp` for an already-persisted session, so a returning user
/// never sees a one-frame flash of empty/default data.
final authSyncProvider = Provider<void>((ref) {
  String? lastSyncedUserId;
  ref.listen<AsyncValue<AppUser?>>(authStateProvider, (previous, next) {
    final user = next.valueOrNull;
    if (user == null) {
      lastSyncedUserId = null;
      return;
    }
    if (user.id == lastSyncedUserId || !SupabaseConfig.isConfigured) return;
    lastSyncedUserId = user.id;
    syncProfileAndSettingsFromRemote(
      client: Supabase.instance.client,
      storage: ref.read(localStorageServiceProvider),
      userId: user.id,
    );
  });
});

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithEmail(email: email, password: password));
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signUpWithEmail(email: email, password: password));
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithGoogle());
    _resetIfAwaitingOAuthRedirect();
  }

  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signInWithApple());
    _resetIfAwaitingOAuthRedirect();
  }

  /// The Supabase OAuth flow hands off to an external browser/native sheet
  /// and completes asynchronously via authStateProvider — it doesn't return
  /// a user synchronously, so [SupabaseAuthRepository] surfaces that as a
  /// StateError. That's an expected transitional state, not a real failure,
  /// so it shouldn't show as an error banner to the user.
  void _resetIfAwaitingOAuthRedirect() {
    final error = state.error;
    if (error is StateError && error.message.contains('awaiting redirect')) {
      state = const AsyncData(null);
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signOut());
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(AuthController.new);
