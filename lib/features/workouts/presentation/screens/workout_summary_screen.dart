import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/utils/weight_formatter.dart';
import '../../../progress/presentation/controllers/progress_providers.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../controllers/workout_providers.dart';
import '../workout_names.dart';

class WorkoutSummaryScreen extends ConsumerWidget {
  final String sessionId;
  const WorkoutSummaryScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sessionAsync = ref.watch(sessionByIdProvider(sessionId));
    final names = ref.watch(exerciseNameByIdProvider).valueOrNull ?? const <String, String>{};
    final formatter = ref.watch(weightFormatterProvider);

    return Scaffold(
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (session) {
          if (session == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenMargin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.workoutSummarySessionNotFound, style: AppTypography.bodyMd),
                    const SizedBox(height: AppSpacing.lg),
                    SecondaryButton(
                      label: l10n.workoutSummaryFinish,
                      onPressed: () => context.go('/home'),
                    ),
                  ],
                ),
              ),
            );
          }
          final estCalories = (session.totalVolumeKg * 0.08).round();
          final prSets = session.sets.where((s) => session.personalRecordSetIds.contains(s.id)).toList();

          // Group logged sets by exercise, keeping the order they were done in.
          final byExercise = <String, List<WorkoutSet>>{};
          for (final s in session.sets.where((s) => s.isCompleted)) {
            byExercise.putIfAbsent(s.exerciseId, () => []).add(s);
          }

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin,
                AppSpacing.xxl,
                AppSpacing.screenMargin,
                AppSpacing.xl,
              ),
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(AppIcons.checkBold, color: AppColors.onPrimary, size: 24),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.workoutSummaryComplete, style: AppTypography.displayMd),
                const SizedBox(height: AppSpacing.xs),
                Text(workoutDayName(l10n, session.workoutDayName), style: AppTypography.bodyLg.copyWith(
                  color: AppColors.textSecondary,
                )),
                const SizedBox(height: AppSpacing.xl),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.sm,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 1.7,
                  children: [
                    StatCard(icon: AppIcons.timer, value: _formatDuration(session.duration), label: l10n.workoutSummaryDuration),
                    StatCard(
                      icon: AppIcons.barbell,
                      value: formatter.format(session.totalVolumeKg, decimals: 0),
                      label: l10n.workoutSummaryTotalVolume,
                    ),
                    StatCard(icon: AppIcons.stack, value: '${session.completedSetCount}', label: l10n.workoutSummarySetsCompleted),
                    StatCard(icon: AppIcons.fire, value: '$estCalories', label: l10n.workoutSummaryEstCalories),
                  ],
                ),
                if (prSets.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  for (final s in prSets)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppCard(
                        child: Row(
                          children: [
                            const Icon(AppIcons.trophyFill, size: 20, color: AppColors.primary),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.workoutSummaryNewPr(s.actualWeightKg.toStringAsFixed(1), '${s.actualReps}'),
                                    style: AppTypography.headingSm,
                                  ),
                                  if (names[s.exerciseId] != null)
                                    Text(exerciseName(l10n, names[s.exerciseId]!), style: AppTypography.caption),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                if (byExercise.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text(l10n.activeWorkoutExercisesHeader, style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.sm),
                  AppCard(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                    child: Column(
                      children: [
                        for (final (i, entry) in byExercise.entries.indexed) ...[
                          if (i > 0) const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    exerciseName(l10n, names[entry.key] ?? '—'),
                                    style: AppTypography.bodyLg,
                                  ),
                                ),
                                Text(
                                  l10n.workoutSummaryExerciseLine(entry.value.length, _best(entry.value, formatter)),
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                Text(l10n.workoutSummaryEncouragement, style: AppTypography.bodyMd),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, AppSpacing.md),
        child: PrimaryButton(
          label: l10n.workoutSummaryFinish,
          onPressed: () => context.go('/home'),
        ),
      ),
    );
  }

  String _best(List<WorkoutSet> sets, WeightFormatter formatter) {
    final best = sets.reduce((a, b) => a.actualWeightKg >= b.actualWeightKg ? a : b);
    return best.actualWeightKg > 0
        ? '${formatter.format(best.actualWeightKg)} × ${best.actualReps}'
        : '× ${best.actualReps}';
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$m:$s';
  }
}
