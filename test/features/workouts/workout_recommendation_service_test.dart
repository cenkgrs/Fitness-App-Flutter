import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/features/workouts/domain/workout_recommendation_service.dart';
import 'package:repwise/shared/models/models.dart';

void main() {
  const service = WorkoutRecommendationService();
  const baseline = ExerciseSet(setNumber: 1, targetReps: 8, targetWeightKg: 60);

  test('returns baseline target when there is no history', () {
    final result = service.recommendNext(previousSets: const [], baselineTarget: baseline);
    expect(result, baseline);
  });

  test('bumps weight when every set beat the rep target', () {
    final previousSets = [
      WorkoutSet(
        id: 's1',
        exerciseId: 'ex1',
        setNumber: 1,
        targetWeightKg: 60,
        targetReps: 8,
        actualWeightKg: 60,
        actualReps: 10,
        isCompleted: true,
      ),
      WorkoutSet(
        id: 's2',
        exerciseId: 'ex1',
        setNumber: 2,
        targetWeightKg: 60,
        targetReps: 8,
        actualWeightKg: 60,
        actualReps: 9,
        isCompleted: true,
      ),
    ];

    final result = service.recommendNext(previousSets: previousSets, baselineTarget: baseline);
    expect(result.targetWeightKg, 62.5);
    expect(result.targetReps, 8);
  });

  test('repeats the best previous weight/reps when the target was not met', () {
    final previousSets = [
      WorkoutSet(
        id: 's1',
        exerciseId: 'ex1',
        setNumber: 1,
        targetWeightKg: 60,
        targetReps: 8,
        actualWeightKg: 60,
        actualReps: 6,
        isCompleted: true,
      ),
      WorkoutSet(
        id: 's2',
        exerciseId: 'ex1',
        setNumber: 2,
        targetWeightKg: 60,
        targetReps: 8,
        actualWeightKg: 57.5,
        actualReps: 8,
        isCompleted: true,
      ),
    ];

    final result = service.recommendNext(previousSets: previousSets, baselineTarget: baseline);
    expect(result.targetWeightKg, 60);
    expect(result.targetReps, 6);
  });
}
