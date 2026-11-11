import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';
import '../../features/workouts/presentation/workout_names.dart';
import '../theme/app_icons.dart';

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
            const Icon(AppIcons.moon, color: AppColors.textTertiary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(workoutDayName(AppLocalizations.of(context)!, day.name),
                  style: AppTypography.bodyMd.copyWith(color: AppColors.textSecondary)),
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
                Text(workoutDayName(AppLocalizations.of(context)!, day.name), style: AppTypography.headingSm),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  AppLocalizations.of(context)!
                      .workoutCardSummary(day.estimatedDuration.inMinutes, day.exercises.length),
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(AppIcons.checkCircleFill, color: AppColors.success)
          else if (isToday)
            const Icon(AppIcons.playCircleFill, color: AppColors.primary, size: 32)
          else
            const Icon(AppIcons.caretRight, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}
