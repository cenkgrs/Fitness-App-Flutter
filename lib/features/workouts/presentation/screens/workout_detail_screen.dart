import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/muscle_group_visuals.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/utils/weight_formatter.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../controllers/workout_providers.dart';
import '../workout_names.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final String dayId;
  const WorkoutDetailScreen({super.key, required this.dayId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final programAsync = ref.watch(activeProgramProvider);
    final sessionsAsync = ref.watch(workoutSessionsProvider);
    final formatter = ref.watch(weightFormatterProvider);

    return Scaffold(
      appBar: AppBar(),
      body: programAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (program) {
          final day = program?.days.firstWhere((d) => d.id == dayId, orElse: () => program.days.first);
          if (day == null) return Center(child: Text(l10n.workoutDetailNotFound));

          final sessions = sessionsAsync.valueOrNull ?? [];
          final restSeconds = ref.watch(settingsControllerProvider).defaultRestTime.inSeconds;
          final muscles = day.exercises.map((e) => muscleGroupLabel(l10n, e.muscleGroup)).toSet().join(', ');

          return ListView(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xxl),
            children: [
              Text(workoutDayName(l10n, day.name), style: AppTypography.displayMd),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.homeWorkoutSummary(day.estimatedDuration.inMinutes, day.exercises.length),
                style: AppTypography.bodyLg.copyWith(color: AppColors.textSecondary),
              ),
              if (muscles.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(muscles, style: AppTypography.bodyMd),
              ],
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                child: Column(
                  children: [
                    for (var i = 0; i < day.exercises.length; i++) ...[
                      if (i > 0) const Divider(),
                      _ExerciseLine(
                        index: i,
                        exercise: day.exercises[i],
                        previousBest: _previousBest(sessions, day.exercises[i].id, formatter),
                        restSeconds: restSeconds,
                        formatter: formatter,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: programAsync.valueOrNull == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin,
                AppSpacing.sm,
                AppSpacing.screenMargin,
                AppSpacing.md,
              ),
              child: PrimaryButton(
                label: l10n.workoutDetailStartButton,
                icon: AppIcons.playFill,
                onPressed: () => context.push('/workout/active/$dayId'),
              ),
            ),
    );
  }

  String? _previousBest(List<WorkoutSession> sessions, String exerciseId, WeightFormatter formatter) {
    for (final session in sessions) {
      final matches = session.sets.where((s) => s.isCompleted && s.exerciseId == exerciseId);
      if (matches.isNotEmpty) {
        final best = matches.reduce((a, b) => a.actualWeightKg >= b.actualWeightKg ? a : b);
        return '${formatter.format(best.actualWeightKg)} × ${best.actualReps}';
      }
    }
    return null;
  }
}

class _ExerciseLine extends StatelessWidget {
  final int index;
  final Exercise exercise;
  final String? previousBest;
  final int restSeconds;
  final WeightFormatter formatter;

  const _ExerciseLine({
    required this.index,
    required this.exercise,
    required this.previousBest,
    required this.restSeconds,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final working = exercise.sets.where((s) => !s.isWarmup).toList();
    final reps = working.isNotEmpty ? working.first.targetReps : 0;
    final weight = working.isNotEmpty ? working.first.targetWeightKg : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Text('${index + 1}', style: AppTypography.headingSm.copyWith(color: AppColors.textTertiary)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exerciseName(l10n, exercise.name), style: AppTypography.bodyLg),
                const SizedBox(height: 2),
                Text(
                  '${muscleGroupLabel(l10n, exercise.muscleGroup)} · ${l10n.workoutDetailRest(restSeconds)}',
                  style: AppTypography.caption,
                ),
                if (previousBest != null)
                  Text(l10n.activeWorkoutLastTime(previousBest!), style: AppTypography.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(l10n.exerciseCardSetsReps(working.length, reps), style: AppTypography.headingSm),
              if (weight > 0) Text(formatter.format(weight), style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}
