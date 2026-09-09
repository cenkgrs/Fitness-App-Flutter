import '../models/workout_session.dart';

class WeeklyConsistency {
  /// Monday..Sunday completion flags for the current week.
  final List<bool> completedByDay;
  final int currentStreak;
  final int longestStreak;

  const WeeklyConsistency({
    required this.completedByDay,
    required this.currentStreak,
    required this.longestStreak,
  });
}

/// Derives streak/consistency data purely from completed [WorkoutSession]
/// history — never hard-coded. A "completed day" is any calendar day with
/// at least one session whose status is completed.
class ConsistencyService {
  const ConsistencyService();

  Set<DateTime> _completedDays(List<WorkoutSession> sessions) {
    return sessions.where((s) => s.isCompleted).map((s) {
      final d = s.completedAt ?? s.startedAt;
      return DateTime(d.year, d.month, d.day);
    }).toSet();
  }

  WeeklyConsistency compute(List<WorkoutSession> sessions, {DateTime? now}) {
    final today = _dateOnly(now ?? DateTime.now());
    final completedDays = _completedDays(sessions);

    final monday = today.subtract(Duration(days: today.weekday - 1));
    final week = List.generate(7, (i) => monday.add(Duration(days: i)));
    final completedByDay = week.map((d) => completedDays.contains(d)).toList();

    final currentStreak = _currentStreak(completedDays, today);
    final longestStreak = _longestStreak(completedDays);

    return WeeklyConsistency(
      completedByDay: completedByDay,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
    );
  }

  int _currentStreak(Set<DateTime> completedDays, DateTime today) {
    var streak = 0;
    var cursor = today;
    // If today isn't logged yet, streak counts back from yesterday.
    if (!completedDays.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    while (completedDays.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int _longestStreak(Set<DateTime> completedDays) {
    if (completedDays.isEmpty) return 0;
    final sorted = completedDays.toList()..sort();
    var longest = 1;
    var current = 1;
    for (var i = 1; i < sorted.length; i++) {
      final diff = sorted[i].difference(sorted[i - 1]).inDays;
      if (diff == 1) {
        current++;
        longest = current > longest ? current : longest;
      } else if (diff > 1) {
        current = 1;
      }
    }
    return longest;
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
