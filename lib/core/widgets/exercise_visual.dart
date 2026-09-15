import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/enums.dart';
import '../providers/exercise_image_provider.dart';
import 'muscle_group_visuals.dart';

/// Shows a real exercise photo (looked up from wger.de by name) when one is
/// found, falling back to the muscle-group icon+label otherwise — while
/// loading, mid-fetch, or if wger has nothing for this exercise.
class ExerciseVisual extends ConsumerWidget {
  final String exerciseName;
  final MuscleGroup muscleGroup;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final bool showLabel;

  const ExerciseVisual({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
    required double size,
    this.borderRadius = BorderRadius.zero,
    this.showLabel = false,
  })  : width = size,
        height = size;

  const ExerciseVisual.banner({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final imageUrlAsync = ref.watch(exerciseImageProvider(exerciseName));
    final color = muscleGroupColor(muscleGroup);

    final imageUrl = imageUrlAsync.valueOrNull;
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => _iconFallback(l10n, color),
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : _iconFallback(l10n, color),
        ),
      );
    }

    return ClipRRect(borderRadius: borderRadius, child: _iconFallback(l10n, color));
  }

  Widget _iconFallback(AppLocalizations l10n, Color color) {
    return Container(
      width: width,
      height: height,
      color: color.withValues(alpha: 0.16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(muscleGroupIcon(muscleGroup), color: color, size: height * 0.36),
            if (showLabel) ...[
              const SizedBox(height: 4),
              Text(muscleGroupLabel(l10n, muscleGroup),
                  style: TextStyle(color: color, fontSize: 11)),
            ],
          ],
        ),
      ),
    );
  }
}
