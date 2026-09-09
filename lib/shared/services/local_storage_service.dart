import 'package:hive_flutter/hive_flutter.dart';

/// Thin wrapper around Hive boxes storing plain JSON-serializable maps.
/// Kept deliberately generic (no typed adapters) so the storage layer can
/// be swapped for a remote backend (Firebase/Supabase) later without
/// touching repository call sites — see feature repositories, which depend
/// on this service rather than on Hive directly.
class LocalStorageService {
  static const _userBox = 'repwise_user';
  static const _profileBox = 'repwise_profile';
  static const _goalsBox = 'repwise_goals';
  static const _programsBox = 'repwise_programs';
  static const _sessionsBox = 'repwise_sessions';
  static const _mealsBox = 'repwise_meals';
  static const _weightBox = 'repwise_weight';
  static const _metricsBox = 'repwise_metrics';
  static const _settingsBox = 'repwise_settings';
  static const _foodsBox = 'repwise_foods';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(_userBox),
      Hive.openBox(_profileBox),
      Hive.openBox(_goalsBox),
      Hive.openBox(_programsBox),
      Hive.openBox(_sessionsBox),
      Hive.openBox(_mealsBox),
      Hive.openBox(_weightBox),
      Hive.openBox(_metricsBox),
      Hive.openBox(_settingsBox),
      Hive.openBox(_foodsBox),
    ]);
  }

  Box get userBox => Hive.box(_userBox);
  Box get profileBox => Hive.box(_profileBox);
  Box get goalsBox => Hive.box(_goalsBox);
  Box get programsBox => Hive.box(_programsBox);
  Box get sessionsBox => Hive.box(_sessionsBox);
  Box get mealsBox => Hive.box(_mealsBox);
  Box get weightBox => Hive.box(_weightBox);
  Box get metricsBox => Hive.box(_metricsBox);
  Box get settingsBox => Hive.box(_settingsBox);
  Box get foodsBox => Hive.box(_foodsBox);
}
