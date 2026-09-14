import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/local_settings_repository.dart';
import '../../data/supabase_settings_repository.dart';
import '../../domain/settings_repository.dart';
import '../../../../shared/utils/weight_formatter.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final local = LocalSettingsRepository(ref.watch(localStorageServiceProvider));
  final userId = ref.watch(authStateProvider).valueOrNull?.id;
  if (SupabaseConfig.isConfigured && userId != null) {
    return SupabaseSettingsRepository(Supabase.instance.client, local, userId);
  }
  return local;
});

class SettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.read(settingsRepositoryProvider).getSettings();

  void _update(AppSettings Function(AppSettings) updater) {
    state = updater(state);
    ref.read(settingsRepositoryProvider).saveSettings(state);
  }

  void setWeightUnit(WeightUnit unit) => _update((s) => s.copyWith(weightUnit: unit));
  void setDistanceUnit(DistanceUnit unit) => _update((s) => s.copyWith(distanceUnit: unit));
  void setDefaultRestTime(Duration duration) => _update((s) => s.copyWith(defaultRestTime: duration));
  void setAutoStartNextSet(bool value) => _update((s) => s.copyWith(autoStartNextSet: value));
  void setSoundEnabled(bool value) => _update((s) => s.copyWith(soundEnabled: value));
  void setHapticsEnabled(bool value) => _update((s) => s.copyWith(hapticsEnabled: value));
  void setCountdownBeepEnabled(bool value) => _update((s) => s.copyWith(countdownBeepEnabled: value));
  void setNotificationsEnabled(bool value) => _update((s) => s.copyWith(notificationsEnabled: value));
  void setLanguageCode(String code) => _update((s) => s.copyWith(languageCode: code));
  void setUseAutoNutritionCalculation(bool value) =>
      _update((s) => s.copyWith(useAutoNutritionCalculation: value));
  void setFoodSearchCountry(String country) =>
      _update((s) => s.copyWith(foodSearchCountry: country));
}

final settingsControllerProvider = NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

final weightFormatterProvider = Provider<WeightFormatter>((ref) {
  return WeightFormatter(ref.watch(settingsControllerProvider).weightUnit);
});
