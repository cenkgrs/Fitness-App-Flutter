import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/features/workouts/domain/workout_program_generator.dart';
import 'package:repwise/shared/models/models.dart';

void main() {
  const generator = WorkoutProgramGenerator();

  UserProfile buildProfile({required int daysPerWeek}) {
    return UserProfile(
      userId: 'u1',
      name: 'Test',
      age: 25,
      heightCm: 175,
      weightKg: 75,
      gender: Gender.male,
      fitnessLevel: FitnessLevel.intermediate,
      primaryGoal: PrimaryGoal.buildMuscle,
      targetWeightKg: 75,
      workoutDaysPerWeek: daysPerWeek,
      workoutDurationMinutes: 45,
      workoutLocation: WorkoutLocation.gym,
      availableEquipment: const [],
      activityLevel: ActivityLevel.moderatelyActive,
      nutritionPreference: NutritionPreference.standard,
    );
  }

  test('program always has exactly 7 days', () {
    final program = generator.generate(buildProfile(daysPerWeek: 4));
    expect(program.days.length, 7);
  });

  test('training day count matches workoutDaysPerWeek', () {
    for (final days in [2, 3, 4, 5, 6]) {
      final program = generator.generate(buildProfile(daysPerWeek: days));
      final trainingDays = program.days.where((d) => !d.isRestDay).length;
      expect(trainingDays, days, reason: 'expected $days training days');
    }
  });

  test('every training day has at least one exercise with sets', () {
    final program = generator.generate(buildProfile(daysPerWeek: 4));
    for (final day in program.days.where((d) => !d.isRestDay)) {
      expect(day.exercises, isNotEmpty);
      for (final exercise in day.exercises) {
        expect(exercise.sets, isNotEmpty);
      }
    }
  });

  test('rest days carry no exercises', () {
    final program = generator.generate(buildProfile(daysPerWeek: 3));
    for (final day in program.days.where((d) => d.isRestDay)) {
      expect(day.exercises, isEmpty);
    }
  });
}
