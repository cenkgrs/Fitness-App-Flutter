import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class MacroProgress extends StatelessWidget {
  final String label;
  final double consumed;
  final double goal;
  final Color color;
  final String unit;

  const MacroProgress({
    super.key,
    required this.label,
    required this.consumed,
    required this.goal,
    required this.color,
    this.unit = 'g',
  });

  @override
  Widget build(BuildContext context) {
    final progress = goal == 0 ? 0.0 : (consumed / goal).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.caption),
            Text(
              '${consumed.round()}/${goal.round()}$unit',
              style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.surface2,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
