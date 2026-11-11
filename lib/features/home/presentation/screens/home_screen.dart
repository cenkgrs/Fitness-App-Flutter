import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/providers/health_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/services/health_service.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../nutrition/presentation/widgets/nutrition_summary_card.dart';
import '../../../profile/presentation/controllers/profile_providers.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../../../workouts/presentation/workout_names.dart';
import '../widgets/streak_tracker_card.dart';
import '../../../../shared/utils/text_case.dart';
import '../../../../core/theme/app_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeObj = Localizations.localeOf(context);
    final locale = localeObj.toLanguageTag();
    final profileAsync = ref.watch(userProfileProvider);
    final user = ref.watch(authStateProvider).valueOrNull;
    final nutritionAsync = ref.watch(dailyNutritionProvider);
    final todayWorkoutAsync = ref.watch(todaysWorkoutDayProvider);
    final consistencyAsync = ref.watch(consistencyProvider);

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.homeGreetingMorning
        : (hour < 18 ? l10n.homeGreetingAfternoon : l10n.homeGreetingEvening);
    final name = profileAsync.valueOrNull?.name.isNotEmpty == true
        ? profileAsync.valueOrNull!.name
        : (user?.displayName ?? l10n.homeDefaultAthleteName);
    final today = DateFormat.MMMMEEEEd(locale).format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 76,
        titleSpacing: AppSpacing.screenMargin,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(upperForLocale(today, localeObj.languageCode), style: AppTypography.overline),
            const SizedBox(height: 2),
            Text('$greeting, $name', style: AppTypography.headingMd, overflow: TextOverflow.ellipsis),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.chatCircleText),
            tooltip: l10n.aiChatTitle,
            onPressed: () => context.push('/coach'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.screenMargin, left: AppSpacing.xs),
            child: _Avatar(name: name),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface1,
        onRefresh: () async {
          ref.invalidate(dailyNutritionProvider);
          ref.invalidate(consistencyProvider);
          ref.invalidate(todaysWorkoutDayProvider);
          ref.invalidate(weightEntriesProvider);
          ref.invalidate(dailyHealthStatsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenMargin,
            AppSpacing.sm,
            AppSpacing.screenMargin,
            AppSpacing.xxl,
          ),
          children: [
            consistencyAsync.when(
              loading: () => const LoadingShimmer(height: 76),
              error: (e, st) => const SizedBox.shrink(),
              data: (c) => StreakTrackerCard(consistency: c),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.homeTodaysWorkoutLabel, style: AppTypography.overline),
            const SizedBox(height: AppSpacing.sm),
            todayWorkoutAsync.when(
              loading: () => const LoadingShimmer(height: 140),
              error: (e, st) => const SizedBox.shrink(),
              data: (day) {
                if (day == null || day.isRestDay) {
                  return AppCard(
                    child: Row(
                      children: [
                        const Icon(AppIcons.moon, color: AppColors.textSecondary),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            day?.isRestDay == true ? l10n.homeRestDayMessage : l10n.homeNoWorkoutPlanned,
                            style: AppTypography.bodyMd,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(workoutDayName(l10n, day.name), style: AppTypography.headingLg),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.homeWorkoutSummary(day.estimatedDuration.inMinutes, day.exercises.length),
                        style: AppTypography.bodyMd,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: l10n.homeStartWorkout,
                        icon: AppIcons.playFill,
                        onPressed: () => context.push('/workout/active/${day.id}'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(upperForLocale(l10n.nutritionToday, localeObj.languageCode), style: AppTypography.overline),
            const SizedBox(height: AppSpacing.sm),
            nutritionAsync.when(
              loading: () => const LoadingShimmer(height: 150),
              error: (e, st) => const SizedBox.shrink(),
              data: (nutrition) => NutritionSummaryCard(
                nutrition: nutrition,
                onTap: () => context.go('/nutrition'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const _HealthStatsCard(),
            const _WeightGoalCard(),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    icon: AppIcons.forkKnife,
                    label: l10n.homeQuickActionAddMeal,
                    onTap: () => context.go('/nutrition'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _QuickAction(
                    icon: AppIcons.scales,
                    label: l10n.homeQuickActionLogWeight,
                    onTap: () => context.go('/progress'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _QuickAction(
                    icon: AppIcons.chartLineUp,
                    label: l10n.homeQuickActionViewProgress,
                    onTap: () => context.go('/progress'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            // Real gating (hide for subscribers) lands once RevenueCat is
            // wired in — see subscriptionStatusProvider.
            const Center(child: AdBanner()),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  const _Avatar({required this.name});

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isEmpty ? '' : name.trim().characters.first.toUpperCase();
    return GestureDetector(
      onTap: () => context.go('/profile'),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: AppColors.surface2, shape: BoxShape.circle),
        child: initial.isEmpty
            ? const Icon(AppIcons.user, size: 20, color: AppColors.textSecondary)
            : Text(initial, style: AppTypography.headingSm),
      ),
    );
  }
}

/// Start weight (captured in the goal at onboarding) → latest logged weight
/// → target. Hidden until a target exists.
class _WeightGoalCard extends ConsumerWidget {
  const _WeightGoalCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final goal = ref.watch(activeGoalProvider).valueOrNull;
    final entries = ref.watch(weightEntriesProvider).valueOrNull ?? const <WeightEntry>[];
    final formatter = ref.watch(weightFormatterProvider);
    final start = goal?.currentWeightKg;
    final target = goal?.targetWeightKg;
    if (start == null || target == null) return const SizedBox.shrink();

    final latest = entries.isEmpty
        ? start
        : entries.reduce((a, b) => a.date.isAfter(b.date) ? a : b).weightKg;
    final totalChange = (start - target).abs();
    final progress = totalChange < 0.01
        ? 1.0
        : ((start - latest) / (start - target)).clamp(0.0, 1.0);
    final remaining = (latest - target).abs();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: AppCard(
        onTap: () => context.push('/goals'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(l10n.homeWeightGoalLabel, style: AppTypography.overline),
                const Spacer(),
                Text(
                  '${formatter.format(latest)} → ${formatter.format(target)}',
                  style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ProgressBar(progress: progress, color: AppColors.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.homeWeightRemaining(remaining.toStringAsFixed(1)), style: AppTypography.caption),
          ],
        ),
      ),
    );
  }
}

/// Steps + active calories burned, pulled from Health Connect (Android) /
/// HealthKit (iOS) via the `health` plugin. Renders nothing until the user
/// has actually granted access — a "connect" prompt lives here instead,
/// rather than showing a permanently-empty stat card to everyone who hasn't
/// opted in.
class _HealthStatsCard extends ConsumerWidget {
  const _HealthStatsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final statsAsync = ref.watch(dailyHealthStatsProvider);

    return statsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (stats) {
        if (stats == null) {
          return AppCard(
            onTap: () async {
              final granted = await HealthService.requestPermissions();
              if (granted) ref.invalidate(dailyHealthStatsProvider);
            },
            child: Row(
              children: [
                const Icon(AppIcons.heartbeat, color: AppColors.textSecondary, size: 20),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: Text(l10n.healthConnectPrompt, style: AppTypography.bodyMd)),
                const Icon(AppIcons.caretRight, color: AppColors.textTertiary, size: 18),
              ],
            ),
          );
        }
        return AppCard(
          child: Row(
            children: [
              Expanded(
                child: _HealthStat(
                  icon: AppIcons.footprints,
                  value: NumberFormat.decimalPattern().format(stats.steps),
                  label: l10n.healthStepsLabel,
                ),
              ),
              Container(width: 1, height: 36, color: AppColors.surfaceBorder),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: _HealthStat(
                  icon: AppIcons.fire,
                  value: stats.activeCaloriesBurned.round().toString(),
                  label: l10n.healthCaloriesBurnedLabel,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HealthStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _HealthStat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: AppTypography.headingSm),
            Text(label, style: AppTypography.caption),
          ],
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.md),
      child: Column(
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 22),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
