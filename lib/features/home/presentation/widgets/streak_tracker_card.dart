import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/services/consistency_service.dart';

class StreakTrackerCard extends StatelessWidget {
  final WeeklyConsistency consistency;
  const StreakTrackerCard({super.key, required this.consistency});

  static const _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday - 1;
    return AppCard(
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
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isToday
                              ? AppColors.primary
                              : (done ? AppColors.primary : AppColors.surfaceBorder),
                          width: isToday ? 1.5 : 1,
                          style: isToday ? BorderStyle.solid : BorderStyle.solid,
                        ),
                      ),
                      child: done
                          ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary)
                          : Text('—', style: AppTypography.caption),
                    ),
                    const SizedBox(height: 4),
                    Text(_labels[i], style: AppTypography.caption),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 18)),
              Text('${consistency.currentStreak}d', style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }
}
