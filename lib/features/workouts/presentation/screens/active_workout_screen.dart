import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../domain/workout_runner_state.dart';
import '../controllers/workout_providers.dart';
import '../controllers/workout_runner_controller.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  final String dayId;
  const ActiveWorkoutScreen({super.key, required this.dayId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final programAsync = ref.watch(activeProgramProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: programAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (program) {
          final day = program?.days.firstWhere((d) => d.id == dayId, orElse: () => program.days.first);
          if (day == null || day.exercises.isEmpty) {
            return Center(child: Text(l10n.activeWorkoutNoExercises));
          }
          return _RunnerView(day: day);
        },
      ),
    );
  }
}

class _RunnerView extends ConsumerWidget {
  final WorkoutDay day;
  const _RunnerView({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final runnerState = ref.watch(workoutRunnerProvider(day));
    final notifier = ref.read(workoutRunnerProvider(day).notifier);
    final formatter = ref.watch(weightFormatterProvider);

    ref.listen(workoutRunnerProvider(day), (prev, next) {
      if (next.phase == WorkoutRunnerPhase.finished && prev?.phase != WorkoutRunnerPhase.finished) {
        context.pushReplacement('/workout/summary/${next.session.id}');
      }
    });

    final exercise = runnerState.currentExercise;
    final exerciseNumber = runnerState.exerciseIndex + 1;
    final totalExercises = runnerState.day.exercises.length;
    final setNumber = runnerState.setIndex + 1;
    final totalSets = exercise.sets.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => _confirmExit(context),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(_formatDuration(runnerState.elapsed), style: AppTypography.headingSm),
                      Text(l10n.activeWorkoutExerciseCounter(exerciseNumber, totalExercises), style: AppTypography.caption),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(runnerState.isPaused ? Icons.play_arrow : Icons.pause, color: AppColors.textSecondary),
                  onPressed: notifier.togglePause,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.md),
                  Text(exercise.name.toUpperCase(), style: AppTypography.headingLg, textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.surface1, borderRadius: BorderRadius.circular(20)),
                    child: const Center(child: Icon(Icons.fitness_center, size: 56, color: AppColors.surfaceBorder)),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(l10n.activeWorkoutSetCounter(setNumber, totalSets), style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.activeWorkoutTarget(
                      runnerState.currentPlannedSet != null
                          ? formatter.fromKg(runnerState.currentPlannedSet!.targetWeightKg).toStringAsFixed(1)
                          : '-',
                      '${runnerState.currentPlannedSet?.targetReps ?? '-'}',
                    ),
                    style: AppTypography.bodyMd,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (runnerState.phase == WorkoutRunnerPhase.resting)
                    RestTimer(
                      remaining: runnerState.restRemaining,
                      total: runnerState.restTotal,
                      onAdd15s: () => notifier.addRest(const Duration(seconds: 30)),
                      onSubtract15s: () => notifier.addRest(const Duration(seconds: -15)),
                      onSkip: notifier.skipRest,
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: SetInput(
                            label: l10n.activeWorkoutWeightLabel,
                            displayValue: runnerState.draftWeightKg.toStringAsFixed(1),
                            onIncrement: () => notifier.updateDraftWeight(runnerState.draftWeightKg + 2.5),
                            onDecrement: () =>
                                notifier.updateDraftWeight((runnerState.draftWeightKg - 2.5).clamp(0, 999)),
                          ),
                        ),
                        Expanded(
                          child: SetInput(
                            label: l10n.activeWorkoutRepsLabel,
                            displayValue: '${runnerState.draftReps}',
                            onIncrement: () => notifier.updateDraftReps(runnerState.draftReps + 1),
                            onDecrement: () => notifier.updateDraftReps((runnerState.draftReps - 1).clamp(0, 99)),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: notifier.skipExercise, child: Text(l10n.activeWorkoutSkipExercise)),
                      TextButton(onPressed: notifier.addExtraSet, child: Text(l10n.activeWorkoutAddSet)),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
      bottomSheet: runnerState.phase == WorkoutRunnerPhase.resting
          ? null
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: PrimaryButton(
                label: l10n.activeWorkoutCompleteSet,
                icon: Icons.check,
                backgroundColor: AppColors.success,
                onPressed: () => notifier.completeSet(
                  actualWeight: runnerState.draftWeightKg,
                  actualReps: runnerState.draftReps,
                ),
              ),
            ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _confirmExit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface1,
        title: Text(l10n.activeWorkoutEndTitle),
        content: Text(l10n.activeWorkoutEndContent),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            child: Text(l10n.activeWorkoutEndConfirm, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
