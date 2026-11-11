import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/exercise_visual.dart';
import '../../../../core/widgets/muscle_group_visuals.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/utils/text_case.dart';
import '../../../../shared/utils/weight_formatter.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../domain/workout_runner_logic.dart';
import '../../domain/workout_runner_state.dart';
import '../controllers/workout_providers.dart';
import '../controllers/workout_runner_controller.dart';
import '../workout_names.dart';

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

/// Weight step per tap: 2.5 kg, or 5 lb for imperial users (stored in kg).
double _weightStepKg(WeightFormatter f) => f.toKg(f.suffix == 'lb' ? 5 : 2.5);

String _formatNumber(double v) => v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1);

class _RunnerView extends ConsumerWidget {
  final WorkoutDay day;
  const _RunnerView({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final runnerState = ref.watch(workoutRunnerProvider(day));
    final notifier = ref.read(workoutRunnerProvider(day).notifier);
    final formatter = ref.watch(weightFormatterProvider);
    final history = ref.watch(workoutSessionsProvider).valueOrNull ?? const <WorkoutSession>[];

    ref.listen(workoutRunnerProvider(day), (prev, next) {
      if (next.isSaved && prev?.isSaved != true) {
        if (next.session.sets.any((s) => s.isCompleted)) {
          context.pushReplacement('/workout/summary/${next.session.id}');
        } else {
          context.pop();
        }
      }
    });

    final exercise = runnerState.currentExercise;
    final resting = runnerState.phase == WorkoutRunnerPhase.resting;
    final doneSets = runnerState.session.sets.where((s) => s.isCompleted).length;
    final totalSets = runnerState.totalPlannedSets;
    final previous = _previousSets(history, exercise.id);
    final loggedHere = runnerState.session.sets.where((s) => s.isCompleted && s.exerciseId == exercise.id).toList();
    final lang = Localizations.localeOf(context).languageCode;

    Future<void> editWeight() async {
      final value = await _promptNumber(
        context,
        title: '${l10n.weightFieldHint} (${formatter.suffix})',
        initial: _formatNumber(formatter.fromKg(runnerState.draftWeightKg)),
        decimal: true,
      );
      if (value != null) notifier.updateDraftWeight(formatter.toKg(value).clamp(0, 999));
    }

    Future<void> editReps() async {
      final value = await _promptNumber(
        context,
        title: l10n.activeWorkoutRepsLabel,
        initial: '${runnerState.draftReps}',
        decimal: false,
      );
      if (value != null) notifier.updateDraftReps(value.round().clamp(0, 999));
    }

    if (runnerState.phase == WorkoutRunnerPhase.finished) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          _TopBar(
            elapsed: runnerState.elapsed,
            isPaused: runnerState.isPaused,
            subtitle: l10n.activeWorkoutSetsDone(doneSets, totalSets),
            onClose: () => _confirmExit(context, runnerState, notifier),
            onTogglePause: notifier.togglePause,
            onFinish: () => _confirmExit(context, runnerState, notifier),
          ),
          ClipRRect(
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: totalSets == 0 ? 0 : doneSets / totalSets),
              duration: const Duration(milliseconds: 400),
              builder: (context, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 3,
                backgroundColor: AppColors.surface1,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin,
                AppSpacing.lg,
                AppSpacing.screenMargin,
                AppSpacing.xl,
              ),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExerciseVisual(
                      exerciseName: exercise.name,
                      muscleGroup: exercise.muscleGroup,
                      size: 96,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      expandTitle: exerciseName(l10n, exercise.name),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            upperForLocale(muscleGroupLabel(l10n, exercise.muscleGroup), lang),
                            style: AppTypography.overline,
                          ),
                          const SizedBox(height: 2),
                          Text(exerciseName(l10n, exercise.name), style: AppTypography.headingLg),
                          if (previous.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              l10n.activeWorkoutLastTime(_bestOf(previous.values, formatter)),
                              style: AppTypography.caption,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                _SetTable(
                  exercise: exercise,
                  logged: loggedHere,
                  currentIndex: runnerState.setIndex,
                  previous: previous,
                  formatter: formatter,
                  onAddSet: notifier.addExtraSet,
                ),
                const SizedBox(height: AppSpacing.lg),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: resting
                      ? Padding(
                          key: const ValueKey('rest'),
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: RestTimer(
                            remaining: runnerState.restRemaining,
                            total: runnerState.restTotal,
                            onAdd30s: () => notifier.addRest(const Duration(seconds: 30)),
                            onSubtract15s: () => notifier.addRest(const Duration(seconds: -15)),
                            nextLabel: _nextLabel(l10n, runnerState, exercise),
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('no-rest')),
                ),
                Text(
                  upperForLocale(l10n.activeWorkoutCurrentSet(runnerState.setIndex + 1), lang),
                  style: AppTypography.overline.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: SetInput(
                        label: formatter.suffix.toUpperCase(),
                        displayValue: _formatNumber(formatter.fromKg(runnerState.draftWeightKg)),
                        onTapValue: editWeight,
                        onIncrement: () =>
                            notifier.updateDraftWeight(runnerState.draftWeightKg + _weightStepKg(formatter)),
                        onDecrement: () => notifier.updateDraftWeight(
                            (runnerState.draftWeightKg - _weightStepKg(formatter)).clamp(0, 999)),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: SetInput(
                        label: l10n.activeWorkoutRepsLabel,
                        displayValue: '${runnerState.draftReps}',
                        onTapValue: editReps,
                        onIncrement: () => notifier.updateDraftReps(runnerState.draftReps + 1),
                        onDecrement: () => notifier.updateDraftReps((runnerState.draftReps - 1).clamp(0, 999)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(l10n.activeWorkoutExercisesHeader, style: AppTypography.overline),
                const SizedBox(height: AppSpacing.sm),
                for (var i = 0; i < runnerState.day.exercises.length; i++)
                  _ExerciseRow(
                    index: i,
                    exercise: runnerState.day.exercises[i],
                    done: WorkoutRunnerLogic.completedSetCount(runnerState.session, runnerState.day.exercises[i].id),
                    isCurrent: i == runnerState.exerciseIndex,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      notifier.goToExercise(i);
                    },
                  ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: notifier.skipExercise,
                    icon: const Icon(AppIcons.caretRight, size: 16, color: AppColors.textSecondary),
                    label: Text(
                      l10n.activeWorkoutSkipExercise,
                      style: AppTypography.bodyMd,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _BottomAction(
            resting: resting,
            completeLabel: l10n.activeWorkoutCompleteSet,
            skipRestLabel: l10n.restTimerSkip,
            onComplete: () => notifier.completeSet(
              actualWeight: runnerState.draftWeightKg,
              actualReps: runnerState.draftReps,
            ),
            onSkipRest: notifier.skipRest,
          ),
        ],
      ),
    );
  }

  /// Most recent earlier session that logged this exercise, by set number.
  Map<int, WorkoutSet> _previousSets(List<WorkoutSession> history, String exerciseId) {
    final sessions = history.where((s) => s.isCompleted).toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    for (final session in sessions) {
      final sets = session.sets.where((s) => s.isCompleted && s.exerciseId == exerciseId).toList();
      if (sets.isNotEmpty) return {for (final s in sets) s.setNumber: s};
    }
    return const {};
  }

  String _bestOf(Iterable<WorkoutSet> sets, WeightFormatter f) {
    final best = sets.reduce((a, b) => a.actualWeightKg >= b.actualWeightKg ? a : b);
    return '${f.format(best.actualWeightKg)} × ${best.actualReps}';
  }

  String _nextLabel(AppLocalizations l10n, WorkoutRunnerState state, Exercise current) {
    // After completeSet the state already points at the upcoming set, so
    // "next" is either another set of this exercise or a new exercise.
    final loggedHere = WorkoutRunnerLogic.completedSetCount(state.session, current.id);
    if (loggedHere == 0) return exerciseName(l10n, current.name);
    return l10n.activeWorkoutCurrentSet(state.setIndex + 1);
  }

  Future<double?> _promptNumber(
    BuildContext context, {
    required String title,
    required String initial,
    required bool decimal,
  }) {
    final controller = TextEditingController(text: initial)
      ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);
    final l10n = AppLocalizations.of(context)!;
    double? parse() => double.tryParse(controller.text.replaceAll(',', '.'));
    return showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          textAlign: TextAlign.center,
          style: AppTypography.displayMd,
          keyboardType: TextInputType.numberWithOptions(decimal: decimal),
          inputFormatters: [
            FilteringTextInputFormatter.allow(decimal ? RegExp(r'[0-9.,]') : RegExp(r'[0-9]')),
          ],
          onSubmitted: (_) => Navigator.pop(ctx, parse()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, parse()),
            child: Text(l10n.commonSave, style: const TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _confirmExit(BuildContext context, WorkoutRunnerState state, WorkoutRunnerNotifier notifier) {
    final l10n = AppLocalizations.of(context)!;
    final logged = state.session.sets.where((s) => s.isCompleted).length;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.activeWorkoutEndTitle),
        content: Text(logged == 0 ? l10n.activeWorkoutEndContent : l10n.activeWorkoutFinishContent(logged)),
        actionsOverflowDirection: VerticalDirection.down,
        actionsOverflowButtonSpacing: AppSpacing.xs,
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.activeWorkoutKeepGoing)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            child: Text(
              logged == 0 ? l10n.activeWorkoutEndConfirm : l10n.activeWorkoutDiscard,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
          if (logged > 0)
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                notifier.finishEarly();
              },
              child: Text(l10n.activeWorkoutFinishSave, style: const TextStyle(color: AppColors.primary)),
            ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final Duration elapsed;
  final bool isPaused;
  final String subtitle;
  final VoidCallback onClose;
  final VoidCallback onTogglePause;
  final VoidCallback onFinish;

  const _TopBar({
    required this.elapsed,
    required this.isPaused,
    required this.subtitle,
    required this.onClose,
    required this.onTogglePause,
    required this.onFinish,
  });

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.xs, AppSpacing.xs, AppSpacing.sm, AppSpacing.sm),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(AppIcons.x, color: AppColors.textSecondary),
            onPressed: onClose,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTogglePause,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isPaused) ...[
                        const Icon(AppIcons.pauseFill, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        _format(elapsed),
                        style: AppTypography.headingMd.copyWith(
                          color: isPaused ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(isPaused ? AppIcons.playFill : AppIcons.pauseFill, color: AppColors.textSecondary, size: 20),
            onPressed: onTogglePause,
          ),
          TextButton(
            onPressed: onFinish,
            child: Text(l10n.activeWorkoutFinishNow, style: const TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

/// Every planned set of the current exercise: logged sets show what was
/// actually lifted, the current one is highlighted, later ones show targets.
class _SetTable extends StatelessWidget {
  final Exercise exercise;
  final List<WorkoutSet> logged;
  final int currentIndex;
  final Map<int, WorkoutSet> previous;
  final WeightFormatter formatter;
  final VoidCallback onAddSet;

  const _SetTable({
    required this.exercise,
    required this.logged,
    required this.currentIndex,
    required this.previous,
    required this.formatter,
    required this.onAddSet,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const header = AppTypography.overline;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xs),
            child: Row(
              children: [
                SizedBox(width: 36, child: Text(l10n.activeWorkoutSetHeader, style: header)),
                Expanded(child: Text(l10n.activeWorkoutPreviousHeader, style: header)),
                SizedBox(width: 64, child: Text(formatter.suffix.toUpperCase(), style: header, textAlign: TextAlign.right)),
                SizedBox(width: 52, child: Text(l10n.activeWorkoutRepsLabel, style: header, textAlign: TextAlign.right)),
                const SizedBox(width: 36),
              ],
            ),
          ),
          for (var i = 0; i < exercise.sets.length; i++)
            _SetRow(
              number: i + 1,
              planned: exercise.sets[i],
              logged: i < logged.length ? logged[i] : null,
              isCurrent: i == currentIndex && i >= logged.length,
              previous: previous[i + 1],
              formatter: formatter,
            ),
          InkWell(
            onTap: onAddSet,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppRadius.lg)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(AppIcons.plus, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(l10n.activeWorkoutAddSet, style: AppTypography.bodyMd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  final int number;
  final ExerciseSet planned;
  final WorkoutSet? logged;
  final bool isCurrent;
  final WorkoutSet? previous;
  final WeightFormatter formatter;

  const _SetRow({
    required this.number,
    required this.planned,
    required this.logged,
    required this.isCurrent,
    required this.previous,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final done = logged != null;
    final weightKg = done ? logged!.actualWeightKg : planned.targetWeightKg;
    final reps = done ? logged!.actualReps : planned.targetReps;
    final valueColor = done || isCurrent ? AppColors.textPrimary : AppColors.textTertiary;
    final valueStyle = AppTypography.headingSm.copyWith(
      color: valueColor,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.surface2 : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(
              '$number',
              style: AppTypography.headingSm.copyWith(color: isCurrent ? AppColors.primary : AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              previous == null
                  ? '—'
                  : '${_formatNumber(formatter.fromKg(previous!.actualWeightKg))} × ${previous!.actualReps}',
              style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
            ),
          ),
          SizedBox(
            width: 64,
            child: Text(_formatNumber(formatter.fromKg(weightKg)), style: valueStyle, textAlign: TextAlign.right),
          ),
          SizedBox(width: 52, child: Text('$reps', style: valueStyle, textAlign: TextAlign.right)),
          SizedBox(
            width: 36,
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                child: done
                    ? Container(
                        key: const ValueKey('done'),
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(AppIcons.checkBold, size: 13, color: AppColors.onPrimary),
                      )
                    : Container(
                        key: const ValueKey('todo'),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCurrent ? AppColors.textSecondary : AppColors.surfaceBorder,
                            width: 1.5,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  final int index;
  final Exercise exercise;
  final int done;
  final bool isCurrent;
  final VoidCallback onTap;

  const _ExerciseRow({
    required this.index,
    required this.exercise,
    required this.done,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = exercise.sets.length;
    final finished = done >= total;
    return InkWell(
      onTap: finished || isCurrent ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: finished ? AppColors.primary : (isCurrent ? AppColors.textPrimary : AppColors.surface2),
              ),
              child: finished
                  ? const Icon(AppIcons.checkBold, size: 14, color: AppColors.onPrimary)
                  : Text(
                      '${index + 1}',
                      style: AppTypography.caption.copyWith(
                        color: isCurrent ? AppColors.background : AppColors.textSecondary,
                      ),
                    ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                exerciseName(l10n, exercise.name),
                style: AppTypography.bodyLg.copyWith(
                  color: finished ? AppColors.textTertiary : AppColors.textPrimary,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            Text('$done/$total', style: AppTypography.caption),
          ],
        ),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final bool resting;
  final String completeLabel;
  final String skipRestLabel;
  final VoidCallback onComplete;
  final VoidCallback onSkipRest;

  const _BottomAction({
    required this.resting,
    required this.completeLabel,
    required this.skipRestLabel,
    required this.onComplete,
    required this.onSkipRest,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin,
          AppSpacing.md,
          AppSpacing.screenMargin,
          AppSpacing.md,
        ),
        child: resting
            ? SecondaryButton(label: skipRestLabel, icon: AppIcons.caretRight, onPressed: onSkipRest)
            : PrimaryButton(label: completeLabel, icon: AppIcons.checkBold, onPressed: onComplete),
      ),
    );
  }
}
