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

  Future<AppUser> continueAsGuest();

  Future<void> signOut();
}
