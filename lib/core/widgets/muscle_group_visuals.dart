import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/enums.dart';

/// Distinct icon + accent color per muscle group, used anywhere an exercise
/// needs a quick "what does this train" visual (there's no real per-exercise
/// photo library wired in yet — see ExerciseCard for that tradeoff).
IconData muscleGroupIcon(MuscleGroup group) => switch (group) {
      MuscleGroup.chest => Icons.fitness_center,
      MuscleGroup.back => Icons.rowing,
      MuscleGroup.shoulders => Icons.accessibility_new,
      MuscleGroup.biceps => Icons.sports_martial_arts,
      MuscleGroup.triceps => Icons.sports_gymnastics,
      MuscleGroup.legs => Icons.directions_walk,
      MuscleGroup.glutes => Icons.self_improvement,
      MuscleGroup.core => Icons.all_inclusive,
      MuscleGroup.cardio => Icons.favorite,
      MuscleGroup.fullBody => Icons.sports_handball,
    };

Color muscleGroupColor(MuscleGroup group) => switch (group) {
      MuscleGroup.chest => const Color(0xFFCCFF00),
      MuscleGroup.back => const Color(0xFF38B6FF),
      MuscleGroup.shoulders => const Color(0xFFFF9F1C),
      MuscleGroup.biceps => const Color(0xFFFF4081),
      MuscleGroup.triceps => const Color(0xFFB388FF),
      MuscleGroup.legs => const Color(0xFF00E676),
      MuscleGroup.glutes => const Color(0xFFFFB300),
      MuscleGroup.core => const Color(0xFF64FFDA),
      MuscleGroup.cardio => const Color(0xFFFF3B30),
      MuscleGroup.fullBody => const Color(0xFFA0A5B5),
    };

String muscleGroupLabel(AppLocalizations l10n, MuscleGroup group) => switch (group) {
      MuscleGroup.chest => l10n.muscleGroupChest,
      MuscleGroup.back => l10n.muscleGroupBack,
      MuscleGroup.shoulders => l10n.muscleGroupShoulders,
      MuscleGroup.biceps => l10n.muscleGroupBiceps,
      MuscleGroup.triceps => l10n.muscleGroupTriceps,
      MuscleGroup.legs => l10n.muscleGroupLegs,
      MuscleGroup.glutes => l10n.muscleGroupGlutes,
      MuscleGroup.core => l10n.muscleGroupCore,
      MuscleGroup.cardio => l10n.muscleGroupCardio,
      MuscleGroup.fullBody => l10n.muscleGroupFullBody,
    };
