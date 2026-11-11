import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/enums.dart';
import '../providers/exercise_image_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
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

  /// When set, tapping a real photo opens it full screen under this title.
  final String? expandTitle;

  const ExerciseVisual({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
    required double size,
    this.borderRadius = BorderRadius.zero,
    this.showLabel = false,
    this.expandTitle,
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
    this.expandTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final imageUrlAsync = ref.watch(exerciseImageProvider(exerciseName));

    final imageUrl = imageUrlAsync.valueOrNull;
    if (imageUrl != null) {
      final heroTag = 'exercise-photo-$exerciseName';
      final photo = ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => _iconFallback(l10n),
          loadingBuilder: (context, child, progress) => progress == null ? child : _iconFallback(l10n),
        ),
      );
      if (expandTitle == null) return photo;
      return GestureDetector(
        onTap: () => Navigator.of(context).push(PageRouteBuilder<void>(
          opaque: false,
          barrierColor: Colors.black,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) => _PhotoViewer(url: imageUrl, title: expandTitle!, heroTag: heroTag),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        )),
        child: Stack(
          children: [
            Hero(tag: heroTag, child: photo),
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(AppIcons.cornersOut, size: 13, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return ClipRRect(borderRadius: borderRadius, child: _iconFallback(l10n));
  }

  Widget _iconFallback(AppLocalizations l10n) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surface2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(muscleGroupIcon(muscleGroup), color: AppColors.textSecondary, size: height * 0.34),
            if (showLabel) ...[
              const SizedBox(height: 4),
              Text(muscleGroupLabel(l10n, muscleGroup), style: AppTypography.caption.copyWith(fontSize: 11)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Full-screen exercise photo: pinch to zoom, tap anywhere to close.
class _PhotoViewer extends StatelessWidget {
  final String url;
  final String title;
  final String heroTag;
  const _PhotoViewer({required this.url, required this.title, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Scaled to the full screen width (the wger photos are small),
            // centered vertically; pinch to zoom in further.
            InteractiveViewer(
              maxScale: 4,
              child: Hero(
                tag: heroTag,
                child: Image.network(url, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(AppIcons.x, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTypography.headingSm.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
