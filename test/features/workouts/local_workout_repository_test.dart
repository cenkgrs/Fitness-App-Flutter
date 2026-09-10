import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:repwise/features/workouts/data/local_workout_repository.dart';
import 'package:repwise/shared/models/models.dart';
import 'package:repwise/shared/services/local_storage_service.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('repwise_workout_repo_test');
    Hive.init(tempDir.path);
    await Future.wait([
      Hive.openBox('repwise_programs'),
      Hive.openBox('repwise_sessions'),
    ]);
  });

  tearDownAll(() async {
    await Hive.close();
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  UserProfile buildProfile() => UserProfile(
        userId: 'u1',
        name: 'Test',
        age: 28,
        heightCm: 180,
        weightKg: 80,
        gender: Gender.male,
        fitnessLevel: FitnessLevel.intermediate,
        primaryGoal: PrimaryGoal.buildMuscle,
        targetWeightKg: 78,
        workoutDaysPerWeek: 4,
        workoutDurationMinutes: 45,
        workoutLocation: WorkoutLocation.gym,
        availableEquipment: const [Equipment.barbell, Equipment.dumbbell],
        activityLevel: ActivityLevel.moderatelyActive,
        nutritionPreference: NutritionPreference.standard,
      );

  test('a generated program round-trips through real Hive storage intact', () async {
    // Regression test: Hive deserializes nested maps/lists as
    // Map<dynamic, dynamic>, not Map<String, dynamic>. Model fromJson code
    // that does `field as Map<String, dynamic>` on nested structures (days
    // -> exercises -> sets) throws a type cast error the moment it reads
    // back real Hive data — plain in-memory toJson()/fromJson() round trips
    // never exercise this because Dart map literals are already typed.
    final repo = LocalWorkoutRepository(LocalStorageService());
    final profile = buildProfile();

    final generated = await repo.getOrCreateProgram(profile);
    expect(generated.days, isNotEmpty);

    final reloaded = await repo.getOrCreateProgram(profile);

    expect(reloaded.id, generated.id);
    expect(reloaded.days.length, generated.days.length);
    final trainingDay = reloaded.days.firstWhere((d) => !d.isRestDay);
    expect(trainingDay.exercises, isNotEmpty);
    expect(trainingDay.exercises.first.sets, isNotEmpty);
  });

  test('a saved workout session round-trips through real Hive storage intact', () async {
    final repo = LocalWorkoutRepository(LocalStorageService());
    final session = WorkoutSession(
      id: 's1',
      userId: 'u1',
      workoutDayId: 'day1',
      workoutDayName: 'Push Day',
      status: WorkoutSessionStatus.completed,
      startedAt: DateTime(2026, 1, 1),
      completedAt: DateTime(2026, 1, 1, 1),
      sets: const [
        WorkoutSet(
          id: 'set1',
          exerciseId: 'ex1',
          setNumber: 1,
          targetWeightKg: 60,
          targetReps: 8,
          actualWeightKg: 60,
          actualReps: 8,
          isCompleted: true,
        ),
      ],
      personalRecordSetIds: const ['set1'],
    );

    await repo.saveSession(session);
    final reloaded = await repo.getSession('s1');

    expect(reloaded, isNotNull);
    expect(reloaded!.sets.length, 1);
    expect(reloaded.sets.first.actualWeightKg, 60);
    expect(reloaded.personalRecordSetIds, ['set1']);
  });
}
