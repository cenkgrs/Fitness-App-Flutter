import 'package:flutter/material.dart';
import '../../shared/models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

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

  String get _title => switch (type) {
        MealType.breakfast => 'Breakfast',
        MealType.lunch => 'Lunch',
        MealType.dinner => 'Dinner',
        MealType.snack => 'Snacks',
      };

  @override
  Widget build(BuildContext context) {
    final hasEntries = meal != null && meal!.entries.isNotEmpty;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_title, style: AppTypography.headingSm),
              Text(
                hasEntries ? '${meal!.totalCalories.round()} kcal' : '—',
                style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (!hasEntries)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.surfaceBorder, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('No items logged yet', style: AppTypography.caption),
            )
          else
            ...meal!.entries.map(
              (e) => Dismissible(
                key: ValueKey(e.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => onRemoveEntry?.call(e),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  color: AppColors.error,
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${e.name} (${e.quantityGrams.round()}g)',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary)),
                      ),
                      Text('${e.calories.round()} kcal', style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: onAddFood,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Food'),
          ),
        ],
      ),
    );
  }
}
