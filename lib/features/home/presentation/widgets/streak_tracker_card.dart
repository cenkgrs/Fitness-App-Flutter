import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/services/consistency_service.dart';
import '../../../../core/theme/app_icons.dart';

/// This week, Monday first: a filled dot for each day trained, a ring on
/// today, plus the running streak.
class StreakTrackerCard extends StatelessWidget {
  final WeeklyConsistency consistency;
  const StreakTrackerCard({super.key, required this.consistency});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = l10n.weekdayInitials.split(',');
    final todayIndex = DateTime.now().weekday - 1;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                final done = consistency.completedByDay[i];
                final isToday = i == todayIndex;
                return Column(
                  children: [
                    Text(
                      labels.length == 7 ? labels[i] : '',
                      style: AppTypography.caption.copyWith(
                        color: isToday ? AppColors.textPrimary : AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done ? AppColors.primary : AppColors.surface2,
                        border: isToday && !done
                            ? Border.all(color: AppColors.textPrimary, width: 1.5)
                            : null,
                      ),
                      child: done
                          ? const Icon(AppIcons.checkBold, size: 13, color: AppColors.onPrimary)
                          : null,
                    ),
                  ],
                );
              }),
            ),
          ),
          Container(
            width: 1,
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            color: AppColors.surfaceBorder,
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppIcons.fireFill,
                    size: 18,
                    color: consistency.currentStreak > 0 ? AppColors.primary : AppColors.textTertiary,
                  ),
                  const SizedBox(width: 2),
                  Text('${consistency.currentStreak}', style: AppTypography.headingMd),
                ],
              ),
              Text(l10n.streakLabel, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}
