import '../../../shared/models/models.dart';

enum WorkoutRunnerPhase { exercising, resting, finished }

/// Immutable state for the active-workout state machine. Kept UI- and
/// Timer-agnostic so the transition logic in [WorkoutRunnerNotifier] can be
/// unit tested without a real clock.
class WorkoutRunnerState {
  final WorkoutDay day;
  final WorkoutSession session;
  final int exerciseIndex;
  final int setIndex; // index into the *current* exercise's planned sets
  final double draftWeightKg;
  final int draftReps;
  final WorkoutRunnerPhase phase;
  final Duration restRemaining;
  final Duration restTotal;
  final Duration elapsed;
  final bool isPaused;

  const WorkoutRunnerState({
    required this.day,
    required this.session,
    required this.exerciseIndex,
    required this.setIndex,
    required this.draftWeightKg,
    required this.draftReps,
    required this.phase,
    required this.restRemaining,
    required this.restTotal,
    required this.elapsed,
    this.isPaused = false,
  });

  Exercise get currentExercise => day.exercises[exerciseIndex];

  ExerciseSet? get currentPlannedSet {
    final sets = currentExercise.sets;
    if (setIndex >= sets.length) return null;
    return sets[setIndex];
  }

  bool get isLastExercise => exerciseIndex >= day.exercises.length - 1;
  bool get isLastSetOfExercise => setIndex >= currentExercise.sets.length - 1;

  int get totalPlannedSets => day.exercises.fold(0, (sum, e) => sum + e.sets.length);

  WorkoutRunnerState copyWith({
    WorkoutSession? session,
    int? exerciseIndex,
    int? setIndex,
    double? draftWeightKg,
    int? draftReps,
    WorkoutRunnerPhase? phase,
    Duration? restRemaining,
    Duration? restTotal,
    Duration? elapsed,
    bool? isPaused,
  }) {
    return WorkoutRunnerState(
      day: day,
      session: session ?? this.session,
      exerciseIndex: exerciseIndex ?? this.exerciseIndex,
      setIndex: setIndex ?? this.setIndex,
      draftWeightKg: draftWeightKg ?? this.draftWeightKg,
      draftReps: draftReps ?? this.draftReps,
      phase: phase ?? this.phase,
      restRemaining: restRemaining ?? this.restRemaining,
      restTotal: restTotal ?? this.restTotal,
      elapsed: elapsed ?? this.elapsed,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  factory WorkoutRunnerState.initial(WorkoutDay day, WorkoutSession session) {
    final firstSet = day.exercises.isNotEmpty && day.exercises.first.sets.isNotEmpty
        ? day.exercises.first.sets.first
        : null;
    return WorkoutRunnerState(
      day: day,
      session: session,
      exerciseIndex: 0,
      setIndex: 0,
      draftWeightKg: firstSet?.targetWeightKg ?? 0,
      draftReps: firstSet?.targetReps ?? 0,
      phase: WorkoutRunnerPhase.exercising,
      restRemaining: Duration.zero,
      restTotal: Duration.zero,
      elapsed: Duration.zero,
    );
  }
}
