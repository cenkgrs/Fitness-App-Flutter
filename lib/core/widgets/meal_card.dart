import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';
import '../theme/app_icons.dart';

class MealCard extends StatelessWidget {
  final MealType type;
  final Meal? meal;
  final VoidCallback onAddFood;
  final void Function(MealEntry entry)? onRemoveEntry;

  const MealCard({
    super.key,
    required this.type,
    required this.meal,
    required this.onAddFood,
    this.onRemoveEntry,
  });

  String _title(AppLocalizations l10n) => switch (type) {
        MealType.breakfast => l10n.mealTypeBreakfast,
        MealType.lunch => l10n.mealTypeLunch,
        MealType.dinner => l10n.mealTypeDinner,
        MealType.snack => l10n.mealTypeSnack,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasEntries = meal != null && meal!.entries.isNotEmpty;
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
            child: Row(
              children: [
                Expanded(child: Text(_title(l10n), style: AppTypography.headingSm)),
                Text(
                  hasEntries ? '${meal!.totalCalories.round()} kcal' : '',
                  style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          if (!hasEntries)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(l10n.mealCardNoItems, style: AppTypography.bodyMd.copyWith(color: AppColors.textTertiary)),
            )
          else
            ...meal!.entries.map(
              (e) => Dismissible(
                key: ValueKey(e.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => onRemoveEntry?.call(e),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  color: AppColors.error,
                  child: const Icon(AppIcons.trash, color: AppColors.textPrimary),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.name, style: AppTypography.bodyLg, maxLines: 1, overflow: TextOverflow.ellipsis),
                            if (e.quantityGrams > 0)
                              Text('${e.quantityGrams.round()} g', style: AppTypography.caption),
                          ],
                        ),
                      ),
                      Text('${e.calories.round()} kcal', style: AppTypography.bodyMd),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          InkWell(
            onTap: onAddFood,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppRadius.lg)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              child: Row(
                children: [
                  const Icon(AppIcons.plus, size: 16, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(l10n.mealCardAddFood, style: AppTypography.bodyMd.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
