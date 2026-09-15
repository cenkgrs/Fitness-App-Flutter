import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/models.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../workouts/domain/personal_record_detector.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../../domain/achievement.dart';

/// Whether any completed session in [sessions] set a PR against everything
/// completed before it — same logic workout_runner_controller.dart uses
/// right after finishing a session, just applied retroactively across the
/// whole history instead of "session vs. everything before it, once".
bool _hasEverHitPr(List<WorkoutSession> sessions) {
  final completed = sessions.where((s) => s.isCompleted).toList()
    ..sort((a, b) => (a.completedAt ?? a.startedAt).compareTo(b.completedAt ?? b.startedAt));
  for (var i = 0; i < completed.length; i++) {
    final prIds = detectPersonalRecordSetIds(
      priorSessions: completed.sublist(0, i),
      currentSession: completed[i],
    );
    if (prIds.isNotEmpty) return true;
  }
  return false;
}

final achievementStatsProvider = FutureProvider<AchievementStats>((ref) async {
  final sessions = await ref.watch(workoutSessionsProvider.future);
  final consistency = await ref.watch(consistencyProvider.future);
  final weightEntries = await ref.watch(weightEntriesProvider.future);

  return AchievementStats(
    completedWorkouts: sessions.where((s) => s.isCompleted).length,
    hasEverHitPr: _hasEverHitPr(sessions),
    longestStreak: consistency.longestStreak,
    weightEntriesCount: weightEntries.length,
  );
});
