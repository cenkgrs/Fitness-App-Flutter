import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/features/workouts/domain/personal_record_detector.dart';
import 'package:repwise/shared/models/models.dart';

void main() {
  WorkoutSet completedSet({
    required String id,
    required String exerciseId,
    required double weight,
  }) {
    return WorkoutSet(
      id: id,
      exerciseId: exerciseId,
      setNumber: 1,
      targetWeightKg: weight,
      targetReps: 8,
      actualWeightKg: weight,
      actualReps: 8,
      isCompleted: true,
    );
  }

  WorkoutSession session(String id, List<WorkoutSet> sets) {
    return WorkoutSession(
      id: id,
      userId: 'u1',
      workoutDayId: 'day1',
      workoutDayName: 'Push Day',
      status: WorkoutSessionStatus.completed,
      startedAt: DateTime(2026, 1, 1),
      completedAt: DateTime(2026, 1, 1),
      sets: sets,
    );
  }

  test('only the first set at a repeated weight is a PR, not every identical set', () {
    // Reported bug: lifting 80kg three times in one session marked all
    // three as "NEW PR!" instead of just the first.
    final current = session('s1', [
      completedSet(id: 'a', exerciseId: 'ex1', weight: 80),
      completedSet(id: 'b', exerciseId: 'ex1', weight: 80),
      completedSet(id: 'c', exerciseId: 'ex1', weight: 80),
    ]);

    final prIds = detectPersonalRecordSetIds(priorSessions: const [], currentSession: current);

    expect(prIds, ['a']);
  });

  test('a lower set after a higher set in the same session is not a PR', () {
    // Reported bug: hitting 100kg then a later, lighter 80kg set on the
    // same exercise still showed the 80kg set as a PR.
    final current = session('s1', [
      completedSet(id: 'a', exerciseId: 'ex1', weight: 100),
      completedSet(id: 'b', exerciseId: 'ex1', weight: 80),
    ]);

    final prIds = detectPersonalRecordSetIds(priorSessions: const [], currentSession: current);

    expect(prIds, ['a']);
  });

  test('only sets that beat prior session history count as PRs', () {
    final prior = session('s0', [completedSet(id: 'x', exerciseId: 'ex1', weight: 90)]);
    final current = session('s1', [
      completedSet(id: 'a', exerciseId: 'ex1', weight: 80), // below history, not a PR
      completedSet(id: 'b', exerciseId: 'ex1', weight: 95), // beats history, is a PR
    ]);

    final prIds = detectPersonalRecordSetIds(priorSessions: [prior], currentSession: current);

    expect(prIds, ['b']);
  });

  test('an ascending ramp in the same session only flags the heaviest set', () {
    // Reported: first-ever session on an exercise, sets go 40kg then 60kg —
    // both exceeded the (zero) prior best individually, so both were
    // flagged. Only the heaviest (60kg) should count.
    final current = session('s1', [
      completedSet(id: 'a', exerciseId: 'ex1', weight: 40),
      completedSet(id: 'b', exerciseId: 'ex1', weight: 60),
    ]);

    final prIds = detectPersonalRecordSetIds(priorSessions: const [], currentSession: current);

    expect(prIds, ['b']);
  });

  test('each exercise tracks its own PR bar independently', () {
    final current = session('s1', [
      completedSet(id: 'a', exerciseId: 'bench', weight: 60),
      completedSet(id: 'b', exerciseId: 'squat', weight: 100),
    ]);

    final prIds = detectPersonalRecordSetIds(priorSessions: const [], currentSession: current);

    expect(prIds.toSet(), {'a', 'b'});
  });

  test('incomplete sets are never counted as PRs', () {
    final incomplete = WorkoutSet(
      id: 'a',
      exerciseId: 'ex1',
      setNumber: 1,
      targetWeightKg: 100,
      targetReps: 8,
      actualWeightKg: 100,
      actualReps: 0,
      isCompleted: false,
    );
    final current = session('s1', [incomplete]);

    final prIds = detectPersonalRecordSetIds(priorSessions: const [], currentSession: current);

    expect(prIds, isEmpty);
  });
}
