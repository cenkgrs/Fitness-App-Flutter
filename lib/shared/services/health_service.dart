import 'package:health/health.dart';

class DailyHealthStats {
  final int steps;
  final double activeCaloriesBurned;
  const DailyHealthStats({required this.steps, required this.activeCaloriesBurned});
}

/// Thin wrapper around the `health` plugin (Health Connect on Android,
/// HealthKit on iOS). Every call is defensive — Health Connect may not be
/// installed, permissions may be denied, or the platform channel may simply
/// not exist on a given device/emulator — none of that should ever surface
/// as a crash, just "no data available" to the caller.
class HealthService {
  static final _health = Health();
  static const _types = [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED];
  static const _permissions = [HealthDataAccess.READ, HealthDataAccess.READ];

  static Future<bool> requestPermissions() async {
    try {
      _health.configure();
      final granted = await _health.hasPermissions(_types, permissions: _permissions) ?? false;
      if (granted) return true;
      return await _health.requestAuthorization(_types, permissions: _permissions);
    } catch (_) {
      return false;
    }
  }

  /// Null if permissions aren't granted or health data isn't available on
  /// this device — callers should treat that as "hide the card", not error.
  static Future<DailyHealthStats?> getTodayStats() async {
    try {
      _health.configure();
      final hasPermission = await _health.hasPermissions(_types, permissions: _permissions) ?? false;
      if (!hasPermission) return null;

      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);

      final steps = await _health.getTotalStepsInInterval(midnight, now) ?? 0;

      final calorieData = await _health.getHealthDataFromTypes(
        types: const [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: midnight,
        endTime: now,
      );
      final calories = calorieData.fold<double>(0, (sum, point) {
        final value = point.value;
        return sum + (value is NumericHealthValue ? value.numericValue.toDouble() : 0);
      });

      return DailyHealthStats(steps: steps, activeCaloriesBurned: calories);
    } catch (_) {
      return null;
    }
  }
}
