import 'package:uuid/uuid.dart';
import '../../../shared/models/models.dart';

/// Builds a starter [WorkoutProgram] from onboarding answers using a fixed
/// exercise library and day-split templates. Deliberately simple/rule-based
/// — the AI abstraction (see [lib/shared/ai/ai_workout_coach.dart]) is
/// where a smarter, model-driven generator would plug in later.
class WorkoutProgramGenerator {
  const WorkoutProgramGenerator();

  static const _uuid = Uuid();

  WorkoutProgram generate(UserProfile profile) {
    final split = _splitForDays(profile.workoutDaysPerWeek);
    final days = <WorkoutDay>[];
    for (var i = 0; i < 7; i++) {
      final dayOfWeek = i + 1;
      if (i < split.length) {
        days.add(_buildTrainingDay(dayOfWeek, split[i], profile));
      } else {
        days.add(WorkoutDay(
          id: _uuid.v4(),
          name: i == 6 ? 'Active Recovery' : 'Rest & Recovery',
          dayOfWeek: dayOfWeek,
          exercises: const [],
          isRestDay: true,
          estimatedDuration: Duration.zero,
        ));
      }
    }
    return WorkoutProgram(
      id: _uuid.v4(),
      userId: profile.userId,
      name: profile.workoutDaysPerWeek <= 3 ? 'Full Body Program' : 'Upper/Lower Split',
      days: days,
      createdAt: DateTime.now(),
    );
  }

  List<String> _splitForDays(int days) {
    switch (days) {
      case 2:
        return ['Full Body A', 'Full Body B'];
      case 3:
        return ['Full Body A', 'Full Body B', 'Full Body C'];
      case 4:
        return ['Upper Body Power', 'Lower Body Focus', 'Push Day', 'Pull Day'];
      case 5:
        return ['Push Day', 'Pull Day', 'Legs & Core', 'Upper Body Hypertrophy', 'Full Body'];
      default:
        return ['Push Day', 'Pull Day', 'Legs & Core', 'Upper Body', 'Lower Body', 'Full Body'];
    }
  }

  WorkoutDay _buildTrainingDay(int dayOfWeek, String name, UserProfile profile) {
    final exercises = _exercisesFor(name, profile);
    return WorkoutDay(
      id: _uuid.v4(),
      name: name,
      dayOfWeek: dayOfWeek,
      exercises: exercises,
      estimatedDuration: Duration(minutes: profile.workoutDurationMinutes),
    );
  }

  List<Exercise> _exercisesFor(String dayName, UserProfile profile) {
    final beginnerSets = profile.fitnessLevel == FitnessLevel.beginner ? 3 : 4;
    final targetReps = profile.primaryGoal == PrimaryGoal.buildMuscle ? 8 : 10;

    List<ExerciseSet> sets(double weight, {int? reps}) => List.generate(
          beginnerSets,
          (i) => ExerciseSet(setNumber: i + 1, targetReps: reps ?? targetReps, targetWeightKg: weight),
        );

    Exercise ex(String name, MuscleGroup group, double weight, {int? reps, List<Equipment>? eq}) => Exercise(
          id: _uuid.v4(),
          name: name,
          muscleGroup: group,
          equipment: eq ?? const [Equipment.barbell],
          instructions: 'Maintain controlled form and full range of motion.',
          sets: sets(weight, reps: reps),
          restDuration: const Duration(seconds: 90),
        );

    switch (dayName) {
      case 'Push Day':
      case 'Upper Body Power':
      case 'Upper Body Hypertrophy':
        return [
          ex('Bench Press (Barbell)', MuscleGroup.chest, 60),
          ex('Incline Dumbbell Press', MuscleGroup.chest, 22, eq: const [Equipment.dumbbell, Equipment.bench]),
          ex('Overhead Press', MuscleGroup.shoulders, 35),
          ex('Triceps Pushdown', MuscleGroup.triceps, 25, eq: const [Equipment.cable]),
          ex('Lateral Raise', MuscleGroup.shoulders, 8, eq: const [Equipment.dumbbell]),
        ];
      case 'Pull Day':
        return [
          ex('Deadlift', MuscleGroup.back, 80),
          ex('Pull-Up', MuscleGroup.back, 0, eq: const [Equipment.bodyweight]),
          ex('Barbell Row', MuscleGroup.back, 50),
          ex('Face Pull', MuscleGroup.shoulders, 15, eq: const [Equipment.cable]),
          ex('Bicep Curl', MuscleGroup.biceps, 12, eq: const [Equipment.dumbbell]),
        ];
      case 'Legs & Core':
      case 'Lower Body Focus':
        return [
          ex('Back Squat', MuscleGroup.legs, 70),
          ex('Romanian Deadlift', MuscleGroup.legs, 55),
          ex('Leg Press', MuscleGroup.legs, 100, eq: const [Equipment.machine]),
          ex('Walking Lunge', MuscleGroup.glutes, 16, eq: const [Equipment.dumbbell]),
          ex('Plank', MuscleGroup.core, 0, reps: 45, eq: const [Equipment.bodyweight]),
        ];
      default:
        return [
          ex('Goblet Squat', MuscleGroup.legs, 18, eq: const [Equipment.dumbbell]),
          ex('Push-Up', MuscleGroup.chest, 0, eq: const [Equipment.bodyweight]),
          ex('Dumbbell Row', MuscleGroup.back, 20, eq: const [Equipment.dumbbell]),
          ex('Overhead Press', MuscleGroup.shoulders, 25, eq: const [Equipment.dumbbell]),
          ex('Plank', MuscleGroup.core, 0, reps: 45, eq: const [Equipment.bodyweight]),
        ];
    }
  }
}
