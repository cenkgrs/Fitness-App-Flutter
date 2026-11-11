import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/nutrition_providers.dart';
import '../../../../core/theme/app_icons.dart';
import '../widgets/nutrition_summary_card.dart';

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final date = ref.watch(selectedNutritionDateProvider);
    final nutritionAsync = ref.watch(dailyNutritionProvider);
    final isToday = _isSameDay(date, DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(AppIcons.caretLeft),
              onPressed: () => ref.read(selectedNutritionDateProvider.notifier).state =
                  date.subtract(const Duration(days: 1)),
            ),
            Text(isToday ? l10n.nutritionToday : DateFormat('d MMM').format(date)),
            IconButton(
              icon: const Icon(AppIcons.caretRight),
              onPressed: isToday
                  ? null
                  : () => ref.read(selectedNutritionDateProvider.notifier).state =
                      date.add(const Duration(days: 1)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/nutrition/log/${MealType.snack.name}'),
        child: const Icon(AppIcons.plus),
      ),
      body: nutritionAsync.when(
        loading: () => ListView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          children: const [
            LoadingShimmer(height: 140),
            SizedBox(height: 16),
            LoadingShimmer(height: 100),
            SizedBox(height: 16),
            LoadingShimmer(height: 100),
          ],
        ),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (nutrition) {
          final mealFor = {
            for (final type in MealType.values)
              type: nutrition.meals.where((m) => m.type == type).firstOrNull
          };

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => ref.invalidate(dailyNutritionProvider),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              children: [
                NutritionSummaryCard(nutrition: nutrition),
                const SizedBox(height: AppSpacing.md),
                const _WaterCard(),
                const SizedBox(height: AppSpacing.xl),
                for (final type in MealType.values) ...[
                  MealCard(
                    type: type,
                    meal: mealFor[type],
                    onAddFood: () => context.push('/nutrition/log/${type.name}'),
                    onRemoveEntry: (entry) {
                      final meal = mealFor[type];
                      if (meal != null) {
                        ref.read(nutritionRepositoryProvider).removeEntry(meal.id, entry.id).then((_) {
                          ref.invalidate(dailyNutritionProvider);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class _WaterCard extends ConsumerWidget {
  const _WaterCard();

  Future<void> _addWater(WidgetRef ref, int ml) async {
    final userId = ref.read(authStateProvider).valueOrNull?.id ?? 'local';
    final date = ref.read(selectedNutritionDateProvider);
    await ref.read(nutritionRepositoryProvider).addWater(userId, date, ml);
    ref.invalidate(dailyWaterProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final waterAsync = ref.watch(dailyWaterProvider);
    final consumed = waterAsync.valueOrNull ?? 0;
    final progress = (consumed / waterGoalMl).clamp(0.0, 1.0);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(AppIcons.drop, color: AppColors.water, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Text(l10n.waterCardTitle, style: AppTypography.headingSm),
                ],
              ),
              Text(
                l10n.waterCardAmount(consumed, waterGoalMl),
                style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ProgressBar(progress: progress, color: AppColors.water),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (final ml in const [250, 500])
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ActionChip(
                    avatar: const Icon(AppIcons.plus, size: 14, color: AppColors.textPrimary),
                    label: Text('$ml ml'),
                    onPressed: () => _addWater(ref, ml),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
