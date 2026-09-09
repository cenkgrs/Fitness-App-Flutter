import 'package:flutter/material.dart';
import '../../shared/models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final String? previousBest;
  final VoidCallback? onTap;

  const ExerciseCard({super.key, required this.exercise, this.previousBest, this.onTap});

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.surface2,
                child: const Icon(Icons.fitness_center, color: AppColors.textTertiary, size: 22),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name, style: AppTypography.bodyLg),
                  Text(
                    '${workingSets.length} Sets × $targetReps Reps',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${targetWeight.toStringAsFixed(1)} kg', style: AppTypography.bodyMd
                    .copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                if (previousBest != null)
                  Text('Last: $previousBest', style: AppTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
