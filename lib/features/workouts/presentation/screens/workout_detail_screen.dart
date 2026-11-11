import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/models.dart';
import '../controllers/workout_providers.dart';
import '../workout_names.dart';
import '../../../../core/theme/app_icons.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final String dayId;
  const WorkoutDetailScreen({super.key, required this.dayId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final programAsync = ref.watch(activeProgramProvider);
    final sessionsAsync = ref.watch(workoutSessionsProvider);

    return Scaffold(
      body: programAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
        data: (program) {
          final day = program?.days.firstWhere((d) => d.id == dayId, orElse: () => program.days.first);
          if (day == null) return Center(child: Text(l10n.workoutDetailNotFound));

          final sessions = sessionsAsync.valueOrNull ?? [];

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 120,
                backgroundColor: AppColors.background,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: AppSpacing.screenMargin, bottom: AppSpacing.md),
                  title: Text(workoutDayName(l10n, day.name), style: AppTypography.headingMd),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.screenMargin),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final exercise = day.exercises[index];
                      final previousBest = _previousBest(sessions, exercise.id);
                      return ExerciseCard(exercise: exercise, previousBest: previousBest);
                    },
                    childCount: day.exercises.length,
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          );
        },
      ),
      bottomNavigationBar: programAsync.valueOrNull == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: PrimaryButton(
                  label: l10n.workoutDetailStartButton,
                  icon: AppIcons.playFill,
                  onPressed: () => context.push('/workout/active/$dayId'),
                ),
              ),
            ),
    );
  }

  String? _previousBest(List<WorkoutSession> sessions, String exerciseId) {
    for (final session in sessions) {
      final matches = session.sets.where((s) => s.isCompleted && s.exerciseId == exerciseId);
      if (matches.isNotEmpty) {
        final best = matches.reduce((a, b) => a.actualWeightKg >= b.actualWeightKg ? a : b);
        return '${best.actualWeightKg.toStringAsFixed(1)} kg × ${best.actualReps}';
      }
    }
    return null;
  }
}
