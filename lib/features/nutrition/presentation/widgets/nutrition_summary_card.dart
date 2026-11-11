import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';

/// Calories against the daily goal plus the three macros — shared by the
/// home and nutrition screens so both read the day the same way.
class NutritionSummaryCard extends StatelessWidget {
  final DailyNutrition nutrition;
  final VoidCallback? onTap;
  const NutritionSummaryCard({super.key, required this.nutrition, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final consumed = nutrition.consumedCalories.round();
    final remaining = nutrition.remainingCalories.round();
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(NumberFormat.decimalPattern().format(consumed), style: AppTypography.displayMd),
              const SizedBox(width: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('/ ${NumberFormat.decimalPattern().format(nutrition.calorieGoal)} kcal',
                    style: AppTypography.bodyMd),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  l10n.homeCaloriesLeft(remaining < 0 ? 0 : remaining),
                  style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ProgressBar(progress: nutrition.calorieProgress.toDouble(), color: AppColors.calories, height: 8),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: MacroProgress(
                  label: l10n.macroProtein,
                  consumed: nutrition.consumedProteinG,
                  goal: nutrition.proteinGoal.toDouble(),
                  color: AppColors.protein,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: MacroProgress(
                  label: l10n.macroCarbs,
                  consumed: nutrition.consumedCarbsG,
                  goal: nutrition.carbsGoal.toDouble(),
                  color: AppColors.carbs,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: MacroProgress(
                  label: l10n.macroFat,
                  consumed: nutrition.consumedFatG,
                  goal: nutrition.fatGoal.toDouble(),
                  color: AppColors.fat,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Rounded linear bar used for calorie, macro and goal progress.
class ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;
  const ProgressBar({super.key, required this.progress, required this.color, this.height = 6});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: AppColors.surface2,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
