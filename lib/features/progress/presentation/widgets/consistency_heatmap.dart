import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../shared/models/workout_session.dart';

/// GitHub-contribution-style heatmap of completed workout days over the
/// trailing ~12 weeks, computed directly from [WorkoutSession] history.
class ConsistencyHeatmap extends StatelessWidget {
  final List<WorkoutSession> sessions;
  const ConsistencyHeatmap({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    final completedDays = sessions.where((s) => s.isCompleted).map((s) {
      final d = s.completedAt ?? s.startedAt;
      return DateTime(d.year, d.month, d.day);
    }).toSet();

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final startDay = todayOnly.subtract(const Duration(days: 83)); // 12 weeks
    final firstMonday = startDay.subtract(Duration(days: startDay.weekday - 1));

    final weeks = <List<DateTime>>[];
    var cursor = firstMonday;
    while (!cursor.isAfter(todayOnly)) {
      weeks.add(List.generate(7, (i) => cursor.add(Duration(days: i))));
      cursor = cursor.add(const Duration(days: 7));
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Consistency', style: AppTypography.headingSm),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: weeks.map((week) {
                return Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Column(
                    children: week.map((day) {
                      final done = completedDays.contains(day);
                      final isFuture = day.isAfter(todayOnly);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: isFuture
                                ? Colors.transparent
                                : (done ? AppColors.success : AppColors.surface2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
