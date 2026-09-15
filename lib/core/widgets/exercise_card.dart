import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/models.dart';
import '../../features/settings/presentation/controllers/settings_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'muscle_group_visuals.dart';

class ExerciseCard extends ConsumerWidget {
  final Exercise exercise;
  final String? previousBest;
  final VoidCallback? onTap;

  const ExerciseCard({super.key, required this.exercise, this.previousBest, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final formatter = ref.watch(weightFormatterProvider);
    final workingSets = exercise.sets.where((s) => !s.isWarmup).toList();
    final targetReps = workingSets.isNotEmpty ? workingSets.first.targetReps : 0;
    final targetWeight = workingSets.isNotEmpty ? workingSets.first.targetWeightKg : 0.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Container(
                width: 48,
                height: 48,
                color: muscleGroupColor(exercise.muscleGroup).withValues(alpha: 0.16),
                child: Icon(
                  muscleGroupIcon(exercise.muscleGroup),
                  color: muscleGroupColor(exercise.muscleGroup),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name, style: AppTypography.bodyLg),
                  Text(
                    '${muscleGroupLabel(l10n, exercise.muscleGroup)} · ${l10n.exerciseCardSetsReps(workingSets.length, targetReps)}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(formatter.format(targetWeight), style: AppTypography.bodyMd
                    .copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                if (previousBest != null)
                  Text(l10n.exerciseCardLastBest(previousBest!), style: AppTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
