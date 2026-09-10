import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';

/// Persists [UserProfile] locally. Backend-agnostic: swap the storage
/// dependency for a remote data source later without touching call sites.
class UserProfileRepository {
  final LocalStorageService _storage;
  static const _key = 'profile';

  UserProfileRepository(this._storage);

  Future<UserProfile?> getProfile(String userId) async {
    final raw = _storage.profileBox.get(_key);
    if (raw == null) return null;
    return UserProfile.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _storage.profileBox.put(_key, profile.toJson());
  }

  Future<bool> hasCompletedOnboarding() async => hasCompletedOnboardingSync();

  /// Hive reads are synchronous under the hood; exposed directly so the
  /// router's redirect logic can check this without an async gap that would
  /// otherwise cause a one-frame bounce back to /onboarding.
  bool hasCompletedOnboardingSync() {
    return _storage.profileBox.get('onboarding_complete') as bool? ?? false;
  }

  Future<void> markOnboardingComplete() async {
    await _storage.profileBox.put('onboarding_complete', true);
  }
}
