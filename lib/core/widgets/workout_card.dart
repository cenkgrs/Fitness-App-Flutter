import 'package:flutter/material.dart';
import '../../shared/models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutDay day;
  final bool isCompleted;
  final bool isToday;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.day,
    this.isCompleted = false,
    this.isToday = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (day.isRestDay) {
      return AppCard(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Row(
          children: [
            const Icon(Icons.self_improvement, color: AppColors.textTertiary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(day.name, style: AppTypography.bodyMd.copyWith(color: AppColors.textSecondary)),
            ),
          ],
        ),
      );
    }
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day.name, style: AppTypography.headingSm),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${day.estimatedDuration.inMinutes} min • ${day.exercises.length} exercises',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check_circle, color: AppColors.success)
          else if (isToday)
            const Icon(Icons.play_circle_fill, color: AppColors.primary, size: 32)
          else
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}
