import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../controllers/goal_providers.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalAsync = ref.watch(activeGoalProvider);
    final consistencyAsync = ref.watch(consistencyProvider);
    final nutritionAsync = ref.watch(dailyNutritionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: goalAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(children: [LoadingShimmer(height: 100), SizedBox(height: 16), LoadingShimmer(height: 100)]),
        ),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (goal) {
          if (goal == null) {
            return const EmptyState(icon: Icons.flag_outlined, title: 'No goals set', message: 'Complete onboarding to set your goals.');
          }
          final weeklyCompleted = consistencyAsync.valueOrNull?.completedByDay.where((d) => d).length ?? 0;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            children: [
              if (goal.currentWeightKg != null && goal.targetWeightKg != null)
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WEIGHT GOAL', style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Metric(label: 'Current', value: '${goal.currentWeightKg!.toStringAsFixed(1)} kg'),
                          _Metric(label: 'Target', value: '${goal.targetWeightKg!.toStringAsFixed(1)} kg'),
                          _Metric(
                              label: 'Remaining',
                              value: '${(goal.currentWeightKg! - goal.targetWeightKg!).abs().toStringAsFixed(1)} kg'),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('WEEKLY WORKOUT GOAL', style: AppTypography.caption),
                        Text('$weeklyCompleted / ${goal.weeklyWorkoutTarget}', style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: goal.weeklyWorkoutTarget == 0 ? 0 : (weeklyCompleted / goal.weeklyWorkoutTarget).clamp(0, 1),
                        minHeight: 8,
                        backgroundColor: AppColors.surface2,
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              nutritionAsync.when(
                loading: () => const LoadingShimmer(height: 100),
                error: (e, st) => const SizedBox.shrink(),
                data: (nutrition) => AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('DAILY CALORIE GOAL', style: AppTypography.caption),
                          Text('${nutrition.consumedCalories.round()} / ${goal.dailyCalorieTarget}',
                              style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: nutrition.calorieProgress.clamp(0, 1),
                          minHeight: 8,
                          backgroundColor: AppColors.surface2,
                          valueColor: const AlwaysStoppedAnimation(AppColors.calories),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PROTEIN GOAL', style: AppTypography.caption),
                          Text('${nutrition.consumedProteinG.round()}g / ${goal.dailyProteinTarget}g',
                              style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: goal.dailyProteinTarget == 0
                              ? 0
                              : (nutrition.consumedProteinG / goal.dailyProteinTarget).clamp(0, 1),
                          minHeight: 8,
                          backgroundColor: AppColors.surface2,
                          valueColor: const AlwaysStoppedAnimation(AppColors.protein),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.headingSm),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
