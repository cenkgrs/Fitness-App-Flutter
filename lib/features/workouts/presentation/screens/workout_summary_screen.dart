import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/workout_providers.dart';
import '../../../../core/theme/app_icons.dart';

class WorkoutSummaryScreen extends ConsumerWidget {
  final String sessionId;
  const WorkoutSummaryScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sessionAsync = ref.watch(sessionByIdProvider(sessionId));

    return Scaffold(
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (session) {
          if (session == null) return Center(child: Text(l10n.workoutSummarySessionNotFound));
          final estCalories = (session.totalVolumeKg * 0.08).round();
          final prSets = session.sets.where((s) => session.personalRecordSetIds.contains(s.id)).toList();

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              children: [
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.workoutSummaryComplete, style: AppTypography.headingLg, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xs),
                Text(session.workoutDayName, style: AppTypography.bodyMd, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xl),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.6,
                  children: [
                    StatCard(icon: AppIcons.timer, value: _formatDuration(session.duration), label: l10n.workoutSummaryDuration),
                    StatCard(icon: AppIcons.barbell, value: '${session.totalVolumeKg.round()} kg', label: l10n.workoutSummaryTotalVolume),
                    StatCard(icon: AppIcons.stack, value: '${session.completedSetCount}', label: l10n.workoutSummarySetsCompleted),
                    StatCard(icon: AppIcons.fire, value: '$estCalories kcal', label: l10n.workoutSummaryEstCalories),
                  ],
                ),
                if (prSets.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  ...prSets.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppCard(
                          accentColor: AppColors.primary,
                          child: Row(
                            children: [
                              const Icon(AppIcons.trophyFill, size: 20, color: AppColors.primary),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  l10n.workoutSummaryNewPr(s.actualWeightKg.toStringAsFixed(1), '${s.actualReps}'),
                                  style: AppTypography.bodyLg,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
                const SizedBox(height: AppSpacing.xl),
                AppCard(
                  child: Text(
                    l10n.workoutSummaryEncouragement,
                    style: AppTypography.bodyMd,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: l10n.workoutSummaryFinish,
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$m:$s';
  }
}
