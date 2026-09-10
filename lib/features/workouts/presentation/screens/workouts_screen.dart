import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/workout_providers.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dayNames = [
      l10n.weekdayMonday,
      l10n.weekdayTuesday,
      l10n.weekdayWednesday,
      l10n.weekdayThursday,
      l10n.weekdayFriday,
      l10n.weekdaySaturday,
      l10n.weekdaySunday,
    ];
    final programAsync = ref.watch(activeProgramProvider);
    final sessionsAsync = ref.watch(workoutSessionsProvider);
    final aiRegenState = ref.watch(aiProgramRegenerationControllerProvider);

    ref.listen(aiProgramRegenerationControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.workoutsAiUpdateFailedSnackbar(next.error.toString()))),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.workoutsScreenTitle),
        actions: [
          IconButton(
            icon: aiRegenState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
            tooltip: l10n.workoutsAiUpdateTooltip,
            onPressed: aiRegenState.isLoading
                ? null
                : () => ref.read(aiProgramRegenerationControllerProvider.notifier).regenerate(),
          ),
        ],
      ),
      body: programAsync.when(
        loading: () => ListView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          children: List.generate(7, (_) => const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: LoadingShimmer(height: 76),
              )),
        ),
        error: (e, st) => Center(child: Text(l10n.workoutsFailedToLoad(e.toString()))),
        data: (program) {
          if (program == null) {
            return EmptyState(
              icon: Icons.fitness_center,
              title: l10n.homeNoWorkoutPlanned,
              message: l10n.workoutsOnboardingCta,
              ctaLabel: l10n.workoutsCreateMyPlan,
              onCta: () => context.go('/onboarding'),
            );
          }
          final completedDayIds = sessionsAsync.valueOrNull
                  ?.where((s) => s.isCompleted)
                  .map((s) => s.workoutDayId)
                  .toSet() ??
              {};
          final todayWeekday = DateTime.now().weekday;

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            itemCount: program.days.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final day = program.days[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(dayNames[index], style: AppTypography.caption),
                  ),
                  WorkoutCard(
                    day: day,
                    isCompleted: completedDayIds.contains(day.id),
                    isToday: day.dayOfWeek == todayWeekday && !day.isRestDay,
                    onTap: day.isRestDay ? null : () => context.push('/workouts/day/${day.id}'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
