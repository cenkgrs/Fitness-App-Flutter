import '../../../shared/models/models.dart';

/// Determines which sets in a just-finished [currentSession] are personal
/// records, given the user's prior session history.
///
/// Only the single heaviest *completed* set per exercise in the session can
/// be a PR, and only if it beats every prior session's best for that
/// exercise. A typical session ramps up in weight per exercise (warm-up,
/// then working sets); flagging every ascending step as its own "PR" is
/// noisy and misleading — a personal record is the best result achieved,
/// not every intermediate rung on the way there.
List<String> detectPersonalRecordSetIds({
  required List<WorkoutSession> priorSessions,
  required WorkoutSession currentSession,
}) {
  final bestByExercise = <String, double>{};
  for (final session in priorSessions) {
    for (final set in session.sets.where((s) => s.isCompleted)) {
      final best = bestByExercise[set.exerciseId] ?? 0;
      if (set.actualWeightKg > best) bestByExercise[set.exerciseId] = set.actualWeightKg;
    }
  }

  final heaviestSetByExercise = <String, WorkoutSet>{};
  for (final set in currentSession.sets.where((s) => s.isCompleted)) {
    final current = heaviestSetByExercise[set.exerciseId];
    if (current == null || set.actualWeightKg > current.actualWeightKg) {
      heaviestSetByExercise[set.exerciseId] = set;
    }
  }

  return [
    for (final entry in heaviestSetByExercise.entries)
      if (entry.value.actualWeightKg > (bestByExercise[entry.key] ?? 0)) entry.value.id,
  ];
}
