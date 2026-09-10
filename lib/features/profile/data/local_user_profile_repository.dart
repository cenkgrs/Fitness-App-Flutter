import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/user_profile_repository.dart';

/// Persists [UserProfile] locally, keyed per user id so multiple accounts
/// signing in on the same device (or the same account across sign-outs)
/// don't see each other's onboarding/profile state.
class LocalUserProfileRepository implements UserProfileRepository {
  final LocalStorageService _storage;

  LocalUserProfileRepository(this._storage);

  String _profileKey(String userId) => 'profile:$userId';
  String _onboardingKey(String userId) => 'onboarding_complete:$userId';

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final raw = _storage.profileBox.get(_profileKey(userId));
    if (raw == null) return null;
    return UserProfile.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await _storage.profileBox.put(_profileKey(profile.userId), profile.toJson());
  }

  @override
  Future<bool> hasCompletedOnboarding(String userId) async => hasCompletedOnboardingSync(userId);

  @override
  bool hasCompletedOnboardingSync(String userId) {
    return _storage.profileBox.get(_onboardingKey(userId)) as bool? ?? false;
  }

  @override
  Future<void> markOnboardingComplete(String userId) async {
    await _storage.profileBox.put(_onboardingKey(userId), true);
  }
}
