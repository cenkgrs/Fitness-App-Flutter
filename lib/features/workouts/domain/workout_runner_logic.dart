import 'package:uuid/uuid.dart';
import '../../../shared/models/models.dart';
import 'workout_runner_state.dart';

/// Pure state-transition functions for the active-workout state machine.
/// Deliberately free of Timer/BuildContext/Riverpod so the workout flow
/// (set completion, rest countdown, exercise navigation) is unit-testable.
class WorkoutRunnerLogic {
  const WorkoutRunnerLogic._();

  static const _uuid = Uuid();

  static WorkoutRunnerState completeSet(
    WorkoutRunnerState state, {
    required double actualWeight,
    required int actualReps,
    int? rpe,
  }) {
    final planned = state.currentPlannedSet;
    final loggedSet = WorkoutSet(
      id: _uuid.v4(),
      exerciseId: state.currentExercise.id,
      setNumber: (planned?.setNumber) ?? (state.setIndex + 1),
      targetWeightKg: planned?.targetWeightKg ?? actualWeight,
      targetReps: planned?.targetReps ?? actualReps,
      actualWeightKg: actualWeight,
      actualReps: actualReps,
      isCompleted: true,
      rpe: rpe,
      completedAt: DateTime.now(),
    );

    final updatedSession = state.session.copyWith(
      sets: [...state.session.sets, loggedSet],
    );

    final hasMoreSetsInExercise = state.setIndex < state.currentExercise.sets.length - 1;

    if (hasMoreSetsInExercise) {
      final nextSet = state.currentExercise.sets[state.setIndex + 1];
      final restDuration = state.currentExercise.restDuration;
      return state.copyWith(
        session: updatedSession,
        setIndex: state.setIndex + 1,
        draftWeightKg: nextSet.targetWeightKg,
        draftReps: nextSet.targetReps,
        phase: WorkoutRunnerPhase.resting,
        restRemaining: restDuration,
        restTotal: restDuration,
      );
    }

    if (!state.isLastExercise) {
      final nextExercise = state.day.exercises[state.exerciseIndex + 1];
      final firstSet = nextExercise.sets.isNotEmpty ? nextExercise.sets.first : null;
      final restDuration = state.currentExercise.restDuration;
      return state.copyWith(
        session: updatedSession,
        exerciseIndex: state.exerciseIndex + 1,
        setIndex: 0,
        draftWeightKg: firstSet?.targetWeightKg ?? 0,
        draftReps: firstSet?.targetReps ?? 0,
        phase: WorkoutRunnerPhase.resting,
        restRemaining: restDuration,
        restTotal: restDuration,
      );
    }

    return state.copyWith(
      session: updatedSession.copyWith(
        status: WorkoutSessionStatus.completed,
        completedAt: DateTime.now(),
      ),
      phase: WorkoutRunnerPhase.finished,
      restRemaining: Duration.zero,
    );
  }

  static WorkoutRunnerState tick(WorkoutRunnerState state, Duration delta) {
    if (state.isPaused || state.phase == WorkoutRunnerPhase.finished) {
      return state.copyWith(elapsed: state.elapsed + (state.isPaused ? Duration.zero : delta));
    }
    final elapsed = state.elapsed + delta;
    if (state.phase != WorkoutRunnerPhase.resting) {
      return state.copyWith(elapsed: elapsed);
    }
    final remaining = state.restRemaining - delta;
    if (remaining <= Duration.zero) {
      return state.copyWith(
        elapsed: elapsed,
        phase: WorkoutRunnerPhase.exercising,
        restRemaining: Duration.zero,
      );
    }
    return state.copyWith(elapsed: elapsed, restRemaining: remaining);
  }

  static WorkoutRunnerState skipRest(WorkoutRunnerState state) {
    if (state.phase != WorkoutRunnerPhase.resting) return state;
    return state.copyWith(phase: WorkoutRunnerPhase.exercising, restRemaining: Duration.zero);
  }

  static WorkoutRunnerState adjustRest(WorkoutRunnerState state, Duration delta) {
    final updated = state.restRemaining + delta;
    return state.copyWith(restRemaining: updated < Duration.zero ? Duration.zero : updated);
  }

  static WorkoutRunnerState togglePause(WorkoutRunnerState state) {
    return state.copyWith(isPaused: !state.isPaused);
  }

  static WorkoutRunnerState updateDraft(WorkoutRunnerState state, {double? weight, int? reps}) {
    return state.copyWith(draftWeightKg: weight, draftReps: reps);
  }

  /// Skips the remainder of the current exercise's sets and advances.
  static WorkoutRunnerState skipExercise(WorkoutRunnerState state) {
    if (state.isLastExercise) {
      return state.copyWith(
        session: state.session.copyWith(
          status: WorkoutSessionStatus.completed,
          completedAt: DateTime.now(),
        ),
        phase: WorkoutRunnerPhase.finished,
      );
    }
    final nextExercise = state.day.exercises[state.exerciseIndex + 1];
    final firstSet = nextExercise.sets.isNotEmpty ? nextExercise.sets.first : null;
    return state.copyWith(
      exerciseIndex: state.exerciseIndex + 1,
      setIndex: 0,
      draftWeightKg: firstSet?.targetWeightKg ?? 0,
      draftReps: firstSet?.targetReps ?? 0,
      phase: WorkoutRunnerPhase.exercising,
      restRemaining: Duration.zero,
    );
  }

  /// Appends an extra ad-hoc set to the current exercise (program-deviation
  /// allowance from the spec) by returning a state whose [WorkoutDay] has
  /// one more planned set for the exercise in progress.
  static WorkoutRunnerState addExtraSet(WorkoutRunnerState state) {
    final exercise = state.currentExercise;
    final lastSet = exercise.sets.isNotEmpty ? exercise.sets.last : null;
    final extraSet = ExerciseSet(
      setNumber: exercise.sets.length + 1,
      targetReps: lastSet?.targetReps ?? state.draftReps,
      targetWeightKg: lastSet?.targetWeightKg ?? state.draftWeightKg,
    );
    final updatedExercise = exercise.copyWith(sets: [...exercise.sets, extraSet]);
    final updatedExercises = [...state.day.exercises];
    updatedExercises[state.exerciseIndex] = updatedExercise;
    final updatedDay = WorkoutDay(
      id: state.day.id,
      name: state.day.name,
      dayOfWeek: state.day.dayOfWeek,
      exercises: updatedExercises,
      isRestDay: state.day.isRestDay,
      estimatedDuration: state.day.estimatedDuration,
    );
    return WorkoutRunnerState(
      day: updatedDay,
      session: state.session,
      exerciseIndex: state.exerciseIndex,
      setIndex: state.setIndex,
      draftWeightKg: state.draftWeightKg,
      draftReps: state.draftReps,
      phase: state.phase,
      restRemaining: state.restRemaining,
      restTotal: state.restTotal,
      elapsed: state.elapsed,
      isPaused: state.isPaused,
    );
  }
}
