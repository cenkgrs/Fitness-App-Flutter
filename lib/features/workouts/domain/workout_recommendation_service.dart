import '../../../shared/models/models.dart';
import '../../../core/constants/app_constants.dart';

/// Suggests the next session's target weight/reps for an exercise based on
/// prior performance ("progressive overload"). Rule-based today; the same
/// interface can be backed by [AIWorkoutCoach.recommendNextWeight] later
/// without changing callers.
class WorkoutRecommendationService {
  const WorkoutRecommendationService();

  /// Given the most recent completed sets for an exercise (target vs.
  /// actual), suggests the next target weight/reps.
  ///
  /// Rule: if the lifter beat every planned rep target last time, bump the
  /// weight by [AppConstants.defaultWeightIncrementKg] and reset to the
  /// baseline rep target. Otherwise repeat the same weight/reps.
  ExerciseSet recommendNext({
    required List<WorkoutSet> previousSets,
    required ExerciseSet baselineTarget,
  }) {
    if (previousSets.isEmpty) return baselineTarget;

    final beatTarget = previousSets.every((s) => s.actualReps >= s.targetReps && s.isCompleted);
    if (beatTarget) {
      return baselineTarget.copyWith(
        targetWeightKg: previousSets.first.actualWeightKg + AppConstants.defaultWeightIncrementKg,
        targetReps: baselineTarget.targetReps,
      );
    }
    final bestSet = previousSets.reduce((a, b) => a.actualWeightKg >= b.actualWeightKg ? a : b);
    return baselineTarget.copyWith(
      targetWeightKg: bestSet.actualWeightKg,
      targetReps: bestSet.actualReps,
    );
  }
}
