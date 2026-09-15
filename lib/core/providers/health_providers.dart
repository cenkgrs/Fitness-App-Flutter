import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/services/health_service.dart';

/// Null if Health Connect/HealthKit isn't available, not permitted, or the
/// platform doesn't support it — the Home screen card hides itself in that
/// case rather than showing a broken/empty state.
final dailyHealthStatsProvider = FutureProvider<DailyHealthStats?>((ref) {
  return HealthService.getTodayStats();
});
