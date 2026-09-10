import '../../../shared/models/models.dart';

/// Abstraction over [UserProfile] persistence — swap the local/Supabase
/// implementation without touching call sites (profile_providers.dart,
/// router redirect logic).
abstract class UserProfileRepository {
  Future<UserProfile?> getProfile(String userId);
  Future<void> saveProfile(UserProfile profile);

  Future<bool> hasCompletedOnboarding(String userId);

  /// Synchronous read used by the router's redirect logic, which cannot
  /// tolerate an async gap without a one-frame bounce back to /onboarding.
  bool hasCompletedOnboardingSync(String userId);

  Future<void> markOnboardingComplete(String userId);
}
