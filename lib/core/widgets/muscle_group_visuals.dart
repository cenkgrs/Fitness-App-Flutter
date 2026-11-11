import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/models/enums.dart';
import '../theme/app_icons.dart';

/// Icon per muscle group, used anywhere an exercise needs a quick "what
/// does this train" visual when no exercise photo is available (see
/// ExerciseVisual). Groups are told apart by icon and label, not color.
IconData muscleGroupIcon(MuscleGroup group) => switch (group) {
      MuscleGroup.chest => AppIcons.barbell,
      MuscleGroup.back => AppIcons.personSimpleTaiChi,
      MuscleGroup.shoulders => AppIcons.personArmsSpread,
      MuscleGroup.biceps => AppIcons.handFist,
      MuscleGroup.triceps => AppIcons.handFist,
      MuscleGroup.legs => AppIcons.personSimpleWalk,
      MuscleGroup.glutes => AppIcons.personSimpleWalk,
      MuscleGroup.core => AppIcons.target,
      MuscleGroup.cardio => AppIcons.heartbeat,
      MuscleGroup.fullBody => AppIcons.personSimple,
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
