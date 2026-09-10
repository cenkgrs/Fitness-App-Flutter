import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/settings_repository.dart';
import 'local_settings_repository.dart';

/// Supabase-backed, with [LocalSettingsRepository] as the synchronous read
/// cache `SettingsController.build` needs — writes go to both.
class SupabaseSettingsRepository implements SettingsRepository {
  final sb.SupabaseClient _client;
  final LocalSettingsRepository _local;
  final String userId;

  SupabaseSettingsRepository(this._client, this._local, this.userId);

  @override
  AppSettings getSettings() => _local.getSettings();

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _client.from('app_settings').upsert({
      'user_id': userId,
      'weight_unit': settings.weightUnit.name,
      'distance_unit': settings.distanceUnit.name,
      'default_rest_time_seconds': settings.defaultRestTime.inSeconds,
      'auto_start_next_set': settings.autoStartNextSet,
      'sound_enabled': settings.soundEnabled,
      'haptics_enabled': settings.hapticsEnabled,
      'countdown_beep_enabled': settings.countdownBeepEnabled,
      'notifications_enabled': settings.notificationsEnabled,
      'language_code': settings.languageCode,
      'use_auto_nutrition_calculation': settings.useAutoNutritionCalculation,
      'food_search_country': settings.foodSearchCountry,
    });
    await _local.saveSettings(settings);
  }
}
