import '../../../shared/models/models.dart';

/// Abstraction over authentication. The local/mock implementation lets the
/// app run fully offline; swap in a Firebase/Supabase implementation later
/// without touching call sites (AuthController, screens).
abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();

  Future<AppUser?> currentUser();

  Future<AppUser> signInWithEmail({required String email, required String password});

  Future<AppUser> signUpWithEmail({required String email, required String password});

  Future<AppUser> signInWithGoogle();

  Future<AppUser> signInWithApple();

  Future<void> signOut();

  Future<void> resetPasswordForEmail(String email);

  Future<void> updatePassword(String newPassword);

  /// Emits `true` whenever the auth backend signals the current session was
  /// established via a password-recovery link (as opposed to a normal
  /// sign-in), so the router can force the user to the reset-password screen.
  Stream<bool> passwordRecoveryEvents();

  /// Permanently deletes the current user's account and all their data.
  Future<void> deleteAccount();
}
