import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../profile/presentation/controllers/profile_providers.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../widgets/streak_tracker_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(userProfileProvider);
    final user = ref.watch(authStateProvider).valueOrNull;
    final nutritionAsync = ref.watch(dailyNutritionProvider);
    final todayWorkoutAsync = ref.watch(todaysWorkoutDayProvider);
    final consistencyAsync = ref.watch(consistencyProvider);
    final goalAsync = ref.watch(activeGoalProvider);
    final formatter = ref.watch(weightFormatterProvider);

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.homeGreetingMorning
        : (hour < 18 ? l10n.homeGreetingAfternoon : l10n.homeGreetingEvening);
    final name = profileAsync.valueOrNull?.name.isNotEmpty == true
        ? profileAsync.valueOrNull!.name
        : (user?.displayName ?? l10n.homeDefaultAthleteName);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$greeting, $name', style: AppTypography.headingMd),
                  Text(l10n.homeReadySubtitle, style: AppTypography.caption),
                ],
              ),
            ),
            const CircleAvatar(radius: 22, backgroundColor: AppColors.surface2, child: Icon(Icons.person)),
          ],
        ),
        toolbarHeight: 72,
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(dailyNutritionProvider);
          ref.invalidate(consistencyProvider);
          ref.invalidate(todaysWorkoutDayProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          children: [
            consistencyAsync.when(
              loading: () => const LoadingShimmer(height: 88),
              error: (e, st) => const SizedBox.shrink(),
              data: (c) => StreakTrackerCard(consistency: c),
            ),
            const SizedBox(height: AppSpacing.xl),
            nutritionAsync.when(
              loading: () => const LoadingShimmer(height: 160),
              error: (e, st) => const SizedBox.shrink(),
              data: (nutrition) => AppCard(
                child: Row(
                  children: [
                    ProgressRing(
                      size: 100,
                      strokeWidth: 8,
                      centerValue: nutrition.consumedCalories.round().toString(),
                      centerLabel: l10n.homeCaloriesLeft(nutrition.remainingCalories.round()),
                      rings: [
                        RingData(progress: nutrition.calorieProgress, color: AppColors.calories),
                        RingData(
                            progress: nutrition.proteinGoal == 0
                                ? 0
                                : nutrition.consumedProteinG / nutrition.proteinGoal,
                            color: AppColors.protein),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        children: [
                          MacroProgress(
                              label: l10n.macroProtein,
                              consumed: nutrition.consumedProteinG,
                              goal: nutrition.proteinGoal.toDouble(),
                              color: AppColors.protein),
                          const SizedBox(height: AppSpacing.sm),
                          MacroProgress(
                              label: l10n.macroCarbs,
                              consumed: nutrition.consumedCarbsG,
                              goal: nutrition.carbsGoal.toDouble(),
                              color: AppColors.carbs),
                          const SizedBox(height: AppSpacing.sm),
                          MacroProgress(
                              label: l10n.macroFat,
                              consumed: nutrition.consumedFatG,
                              goal: nutrition.fatGoal.toDouble(),
                              color: AppColors.fat),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.homeTodaysWorkoutLabel, style: AppTypography.caption),
            const SizedBox(height: AppSpacing.sm),
            todayWorkoutAsync.when(
              loading: () => const LoadingShimmer(height: 140),
              error: (e, st) => const SizedBox.shrink(),
              data: (day) {
                if (day == null || day.isRestDay) {
                  return AppCard(
                    child: Text(
                      day?.isRestDay == true ? l10n.homeRestDayMessage : l10n.homeNoWorkoutPlanned,
                      style: AppTypography.bodyMd,
                    ),
                  );
                }
                return AppCard(
                  accentColor: AppColors.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day.name, style: AppTypography.headingMd),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.homeWorkoutSummary(day.estimatedDuration.inMinutes, day.exercises.length),
                        style: AppTypography.caption,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: l10n.homeStartWorkout,
                        icon: Icons.play_arrow,
                        onPressed: () => context.push('/workout/active/${day.id}'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            goalAsync.when(
              loading: () => const LoadingShimmer(height: 90),
              error: (e, st) => const SizedBox.shrink(),
              data: (goal) {
                if (goal == null || goal.targetWeightKg == null || goal.currentWeightKg == null) {
                  return const SizedBox.shrink();
                }
                final remaining = (goal.currentWeightKg! - goal.targetWeightKg!).abs();
                final progress = ((goal.currentWeightKg! - goal.targetWeightKg!).abs() < 0.01)
                    ? 1.0
                    : 0.3; // placeholder until multiple weight entries exist
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.homeWeightGoalLabel, style: AppTypography.caption),
                          Text(
                            '${formatter.format(goal.currentWeightKg!)} → ${formatter.format(goal.targetWeightKg!)}',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0, 1),
                          minHeight: 6,
                          backgroundColor: AppColors.surface2,
                          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(l10n.homeWeightRemaining(remaining.toStringAsFixed(1)), style: AppTypography.caption),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.5,
              children: [
                _QuickAction(
                  icon: Icons.play_circle_fill,
                  label: l10n.homeStartWorkout,
                  onTap: () {
                    final day = todayWorkoutAsync.valueOrNull;
                    if (day != null && !day.isRestDay) {
                      context.push('/workout/active/${day.id}');
                    } else {
                      context.go('/workouts');
                    }
                  },
                ),
                _QuickAction(
                  icon: Icons.add_circle,
                  label: l10n.homeQuickActionAddMeal,
                  onTap: () => context.go('/nutrition'),
                ),
                _QuickAction(
                  icon: Icons.monitor_weight,
                  label: l10n.homeQuickActionLogWeight,
                  onTap: () => context.go('/progress'),
                ),
                _QuickAction(
                  icon: Icons.insights,
                  label: l10n.homeQuickActionViewProgress,
                  onTap: () => context.go('/progress'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            // Real gating (hide for subscribers) lands once RevenueCat is
            // wired in — see subscriptionStatusProvider.
            const Center(child: AdBanner()),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
