import '../../../shared/models/models.dart';

/// Determines which sets in a just-finished [currentSession] are personal
/// records, given the user's prior session history.
///
/// A set is a PR if its weight strictly exceeds the best weight ever lifted
/// for that exercise *up to and including that point in time* — which
/// means earlier PR-setting sets within the same session must raise the
/// bar for later sets in that same session, not just prior sessions.
/// Comparing every set only against history (ignoring sets already
/// processed in the current session) marks every set at a given weight as
/// a "new" PR and lets a lower later set outrank an earlier higher one.
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

  final prSetIds = <String>[];
  for (final set in currentSession.sets.where((s) => s.isCompleted)) {
    final best = bestByExercise[set.exerciseId] ?? 0;
    if (set.actualWeightKg > best) {
      prSetIds.add(set.id);
      bestByExercise[set.exerciseId] = set.actualWeightKg;
    }
  }
  return prSetIds;
}
