import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/user_profile_repository.dart';

/// Persists [UserProfile] locally.
class LocalUserProfileRepository implements UserProfileRepository {
  final LocalStorageService _storage;
  static const _key = 'profile';

  LocalUserProfileRepository(this._storage);

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final raw = _storage.profileBox.get(_key);
    if (raw == null) return null;
    return UserProfile.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await _storage.profileBox.put(_key, profile.toJson());
  }

  @override
  Future<bool> hasCompletedOnboarding() async => hasCompletedOnboardingSync();

  @override
  bool hasCompletedOnboardingSync() {
    return _storage.profileBox.get('onboarding_complete') as bool? ?? false;
  }

  @override
  Future<void> markOnboardingComplete() async {
    await _storage.profileBox.put('onboarding_complete', true);
  }
}
