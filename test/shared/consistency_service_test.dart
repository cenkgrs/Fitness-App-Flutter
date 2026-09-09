import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/shared/models/enums.dart';
import 'package:repwise/shared/models/workout_session.dart';
import 'package:repwise/shared/services/consistency_service.dart';

void main() {
  const service = ConsistencyService();

  WorkoutSession completedSessionOn(DateTime date) => WorkoutSession(
        id: 'session-${date.toIso8601String()}',
        userId: 'u1',
        workoutDayId: 'day1',
        workoutDayName: 'Push Day',
        status: WorkoutSessionStatus.completed,
        startedAt: date,
        completedAt: date,
        sets: const [],
      );

  test('current streak counts back-to-back completed days including today', () {
    final today = DateTime(2026, 9, 9);
    final sessions = [
      completedSessionOn(today),
      completedSessionOn(today.subtract(const Duration(days: 1))),
      completedSessionOn(today.subtract(const Duration(days: 2))),
      completedSessionOn(today.subtract(const Duration(days: 4))), // gap at day 3
    ];

    final result = service.compute(sessions, now: today);
    expect(result.currentStreak, 3);
  });

  test('current streak counts back from yesterday when today has no session yet', () {
    final today = DateTime(2026, 9, 9);
    final sessions = [
      completedSessionOn(today.subtract(const Duration(days: 1))),
      completedSessionOn(today.subtract(const Duration(days: 2))),
    ];

    final result = service.compute(sessions, now: today);
    expect(result.currentStreak, 2);
  });

  test('current streak is zero with no recent sessions', () {
    final today = DateTime(2026, 9, 9);
    final sessions = [completedSessionOn(today.subtract(const Duration(days: 10)))];

    final result = service.compute(sessions, now: today);
    expect(result.currentStreak, 0);
  });

  test('longest streak finds the best historical run, not just the current one', () {
    final today = DateTime(2026, 9, 9);
    final sessions = [
      completedSessionOn(DateTime(2026, 8, 1)),
      completedSessionOn(DateTime(2026, 8, 2)),
      completedSessionOn(DateTime(2026, 8, 3)),
      completedSessionOn(DateTime(2026, 8, 4)),
      completedSessionOn(DateTime(2026, 8, 5)), // 5-day historical streak
      completedSessionOn(today), // isolated single day
    ];

    final result = service.compute(sessions, now: today);
    expect(result.longestStreak, 5);
    expect(result.currentStreak, 1);
  });

  test('completedByDay reflects the current Mon-Sun week only', () {
    final monday = DateTime(2026, 9, 7); // a Monday
    final sessions = [
      completedSessionOn(monday),
      completedSessionOn(monday.add(const Duration(days: 2))),
    ];

    final result = service.compute(sessions, now: monday.add(const Duration(days: 3)));
    expect(result.completedByDay[0], true); // Monday
    expect(result.completedByDay[2], true); // Wednesday
    expect(result.completedByDay[1], false); // Tuesday
  });

  test('non-completed sessions do not count toward consistency', () {
    final today = DateTime(2026, 9, 9);
    final inProgress = WorkoutSession(
      id: 's1',
      userId: 'u1',
      workoutDayId: 'day1',
      workoutDayName: 'Push Day',
      status: WorkoutSessionStatus.inProgress,
      startedAt: today,
      sets: const [],
    );

    final result = service.compute([inProgress], now: today);
    expect(result.currentStreak, 0);
  });
}
