import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../features/profile/data/local_user_profile_repository.dart';
import '../../features/profile/data/supabase_user_profile_repository.dart';
import '../../features/settings/data/local_settings_repository.dart';
import '../../shared/models/models.dart';
import '../../shared/services/local_storage_service.dart';

/// Pulls the signed-in user's `profiles` (incl. onboarding flag) and
/// `app_settings` rows from Supabase into the local Hive cache, so a
/// returning user on a device that's never seen this account before (a
/// reinstall, or signing into an existing account on a device that's new
/// to it) gets their real data instead of empty defaults or a re-run
/// onboarding flow. Called from `main.dart` at cold start (if a session is
/// already persisted) and from `AuthController` right after a successful
/// sign-in.
///
/// Best-effort: network failures are swallowed — the local cache just
/// stays at its current values until the next successful sync, rather than
/// blocking app startup or a sign-in on a flaky connection.
Future<void> syncProfileAndSettingsFromRemote({
  required sb.SupabaseClient client,
  required LocalStorageService storage,
  required String userId,
}) async {
  final localProfile = LocalUserProfileRepository(storage);
  try {
    final profileRepo = SupabaseUserProfileRepository(client, localProfile);
    await profileRepo.getProfile(userId); // mirrors into Hive as a side effect
    if (await profileRepo.hasCompletedOnboarding(userId)) {
      await localProfile.markOnboardingComplete(userId);
    }
  } catch (_) {
    // Offline, or no profile row yet (shouldn't happen given the
    // on_auth_user_created trigger, but don't block startup either way).
  }

  try {
    final rows = await client.from('app_settings').select().eq('user_id', userId).limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isNotEmpty) {
      final row = list.first;
      final settings = AppSettings(
        weightUnit: enumFromString(WeightUnit.values, row['weight_unit'] as String?, WeightUnit.kg),
        distanceUnit: enumFromString(DistanceUnit.values, row['distance_unit'] as String?, DistanceUnit.km),
        defaultRestTime: Duration(seconds: row['default_rest_time_seconds'] as int? ?? 90),
        autoStartNextSet: row['auto_start_next_set'] as bool? ?? false,
        soundEnabled: row['sound_enabled'] as bool? ?? true,
        hapticsEnabled: row['haptics_enabled'] as bool? ?? true,
        countdownBeepEnabled: row['countdown_beep_enabled'] as bool? ?? true,
        notificationsEnabled: row['notifications_enabled'] as bool? ?? true,
        languageCode: row['language_code'] as String? ?? 'system',
        useAutoNutritionCalculation: row['use_auto_nutrition_calculation'] as bool? ?? true,
        foodSearchCountry: row['food_search_country'] as String? ?? '',
      );
      await LocalSettingsRepository(storage).saveSettings(settings);
    }
  } catch (_) {
    // Same — offline, or no settings row saved yet.
  }
}
