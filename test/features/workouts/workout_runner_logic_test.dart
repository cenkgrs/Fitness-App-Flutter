import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/features/workouts/domain/workout_runner_logic.dart';
import 'package:repwise/features/workouts/domain/workout_runner_state.dart';
import 'package:repwise/shared/models/models.dart';

void main() {
  WorkoutDay buildDay() {
    return WorkoutDay(
      id: 'day1',
      name: 'Push Day',
      dayOfWeek: 1,
      estimatedDuration: const Duration(minutes: 45),
      exercises: [
        Exercise(
          id: 'ex1',
          name: 'Bench Press',
          muscleGroup: MuscleGroup.chest,
          equipment: const [Equipment.barbell],
          instructions: '',
          restDuration: const Duration(seconds: 90),
          sets: const [
            ExerciseSet(setNumber: 1, targetReps: 8, targetWeightKg: 60),
            ExerciseSet(setNumber: 2, targetReps: 8, targetWeightKg: 60),
          ],
        ),
        Exercise(
          id: 'ex2',
          name: 'Incline Dumbbell Press',
          muscleGroup: MuscleGroup.chest,
          equipment: const [Equipment.dumbbell],
          instructions: '',
          restDuration: const Duration(seconds: 60),
          sets: const [
            ExerciseSet(setNumber: 1, targetReps: 10, targetWeightKg: 22),
          ],
        ),
      ],
    );
  }

  WorkoutRunnerState initialState() {
    final day = buildDay();
    final session = WorkoutSession(
      id: 'session1',
      userId: 'u1',
      workoutDayId: day.id,
      workoutDayName: day.name,
      status: WorkoutSessionStatus.inProgress,
      startedAt: DateTime(2026, 1, 1),
      sets: const [],
    );
    return WorkoutRunnerState.initial(day, session);
  }

  test('initial state starts on exercise 0, set 0, exercising phase', () {
    final state = initialState();
    expect(state.exerciseIndex, 0);
    expect(state.setIndex, 0);
    expect(state.phase, WorkoutRunnerPhase.exercising);
    expect(state.draftWeightKg, 60);
    expect(state.draftReps, 8);
  });

  test('completing a set logs it and starts rest when more sets remain in the exercise', () {
    final state = initialState();
    final next = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);

    expect(next.session.sets.length, 1);
    expect(next.session.sets.first.isCompleted, true);
    expect(next.phase, WorkoutRunnerPhase.resting);
    expect(next.setIndex, 1);
    expect(next.exerciseIndex, 0);
    expect(next.restRemaining, const Duration(seconds: 90));
  });

  test('completing the last set of an exercise advances to the next exercise', () {
    var state = initialState();
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);
    state = WorkoutRunnerLogic.skipRest(state);
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 62.5, actualReps: 7);

    expect(state.exerciseIndex, 1);
    expect(state.setIndex, 0);
    expect(state.currentExercise.id, 'ex2');
    expect(state.draftWeightKg, 22);
    expect(state.phase, WorkoutRunnerPhase.resting);
  });

  test('completing the final set of the final exercise finishes the session', () {
    var state = initialState();
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);
    state = WorkoutRunnerLogic.skipRest(state);
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);
    state = WorkoutRunnerLogic.skipRest(state);
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 22, actualReps: 10);

    expect(state.phase, WorkoutRunnerPhase.finished);
    expect(state.session.status, WorkoutSessionStatus.completed);
    expect(state.session.completedAt, isNotNull);
    expect(state.session.sets.length, 3);
  });

  test('tick counts down rest and auto-transitions to exercising at zero', () {
    var state = initialState();
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);
    expect(state.phase, WorkoutRunnerPhase.resting);

    state = WorkoutRunnerLogic.tick(state, const Duration(seconds: 89));
    expect(state.phase, WorkoutRunnerPhase.resting);
    expect(state.restRemaining, const Duration(seconds: 1));

    state = WorkoutRunnerLogic.tick(state, const Duration(seconds: 1));
    expect(state.phase, WorkoutRunnerPhase.exercising);
    expect(state.restRemaining, Duration.zero);
  });

  test('tick accumulates elapsed time during the exercising phase', () {
    final state = initialState();
    final next = WorkoutRunnerLogic.tick(state, const Duration(seconds: 5));
    expect(next.elapsed, const Duration(seconds: 5));
    expect(next.phase, WorkoutRunnerPhase.exercising);
  });

  test('paused state does not advance elapsed time', () {
    var state = initialState();
    state = WorkoutRunnerLogic.togglePause(state);
    final next = WorkoutRunnerLogic.tick(state, const Duration(seconds: 10));
    expect(next.elapsed, Duration.zero);
  });

  test('skipRest is a no-op outside the resting phase', () {
    final state = initialState();
    final next = WorkoutRunnerLogic.skipRest(state);
    expect(next.phase, WorkoutRunnerPhase.exercising);
    expect(next, same(state));
  });

  test('adjustRest never goes negative', () {
    var state = initialState();
    state = WorkoutRunnerLogic.completeSet(state, actualWeight: 60, actualReps: 8);
    state = WorkoutRunnerLogic.adjustRest(state, const Duration(seconds: -200));
    expect(state.restRemaining, Duration.zero);
  });

  test('skipExercise jumps straight to the next exercise without logging a set', () {
    final state = initialState();
    final next = WorkoutRunnerLogic.skipExercise(state);
    expect(next.exerciseIndex, 1);
    expect(next.session.sets, isEmpty);
    expect(next.phase, WorkoutRunnerPhase.exercising);
  });

  test('skipExercise on the last exercise finishes the session', () {
    var state = initialState();
    state = WorkoutRunnerLogic.skipExercise(state); // now on ex2 (last)
    state = WorkoutRunnerLogic.skipExercise(state); // skip last exercise too
    expect(state.phase, WorkoutRunnerPhase.finished);
    expect(state.session.status, WorkoutSessionStatus.completed);
  });

  test('addExtraSet appends a set to the current exercise using the last set as baseline', () {
    final state = initialState();
    final next = WorkoutRunnerLogic.addExtraSet(state);
    expect(next.currentExercise.sets.length, 3);
    expect(next.currentExercise.sets.last.targetWeightKg, 60);
    expect(next.currentExercise.sets.last.targetReps, 8);
  });
}
