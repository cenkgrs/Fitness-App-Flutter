import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

enum AchievementId {
  firstWorkout,
  workout5,
  workout25,
  workout100,
  firstPr,
  streak3,
  streak7,
  streak30,
  weightLogged5,
  weightLogged30,
}

class Achievement {
  final AchievementId id;
  final IconData icon;
  final bool Function(AchievementStats stats) isUnlocked;

  const Achievement({required this.id, required this.icon, required this.isUnlocked});

  String title(AppLocalizations l10n) => switch (id) {
        AchievementId.firstWorkout => l10n.achievementFirstWorkoutTitle,
        AchievementId.workout5 => l10n.achievementWorkout5Title,
        AchievementId.workout25 => l10n.achievementWorkout25Title,
        AchievementId.workout100 => l10n.achievementWorkout100Title,
        AchievementId.firstPr => l10n.achievementFirstPrTitle,
        AchievementId.streak3 => l10n.achievementStreak3Title,
        AchievementId.streak7 => l10n.achievementStreak7Title,
        AchievementId.streak30 => l10n.achievementStreak30Title,
        AchievementId.weightLogged5 => l10n.achievementWeightLogged5Title,
        AchievementId.weightLogged30 => l10n.achievementWeightLogged30Title,
      };

  String description(AppLocalizations l10n) => switch (id) {
        AchievementId.firstWorkout => l10n.achievementFirstWorkoutDesc,
        AchievementId.workout5 => l10n.achievementWorkout5Desc,
        AchievementId.workout25 => l10n.achievementWorkout25Desc,
        AchievementId.workout100 => l10n.achievementWorkout100Desc,
        AchievementId.firstPr => l10n.achievementFirstPrDesc,
        AchievementId.streak3 => l10n.achievementStreak3Desc,
        AchievementId.streak7 => l10n.achievementStreak7Desc,
        AchievementId.streak30 => l10n.achievementStreak30Desc,
        AchievementId.weightLogged5 => l10n.achievementWeightLogged5Desc,
        AchievementId.weightLogged30 => l10n.achievementWeightLogged30Desc,
      };
}

/// Everything achievements are derived from — purely computed from data
/// that already exists elsewhere (workout sessions, streaks, weight log
/// count), no separate "unlocked" state to persist or get out of sync.
class AchievementStats {
  final int completedWorkouts;
  final bool hasEverHitPr;
  final int longestStreak;
  final int weightEntriesCount;

  const AchievementStats({
    required this.completedWorkouts,
    required this.hasEverHitPr,
    required this.longestStreak,
    required this.weightEntriesCount,
  });
}

final achievements = <Achievement>[
  Achievement(
    id: AchievementId.firstWorkout,
    icon: Icons.fitness_center,
    isUnlocked: (s) => s.completedWorkouts >= 1,
  ),
  Achievement(
    id: AchievementId.workout5,
    icon: Icons.military_tech,
    isUnlocked: (s) => s.completedWorkouts >= 5,
  ),
  Achievement(
    id: AchievementId.workout25,
    icon: Icons.emoji_events,
    isUnlocked: (s) => s.completedWorkouts >= 25,
  ),
  Achievement(
    id: AchievementId.workout100,
    icon: Icons.workspace_premium,
    isUnlocked: (s) => s.completedWorkouts >= 100,
  ),
  Achievement(
    id: AchievementId.firstPr,
    icon: Icons.trending_up,
    isUnlocked: (s) => s.hasEverHitPr,
  ),
  Achievement(
    id: AchievementId.streak3,
    icon: Icons.local_fire_department,
    isUnlocked: (s) => s.longestStreak >= 3,
  ),
  Achievement(
    id: AchievementId.streak7,
    icon: Icons.local_fire_department,
    isUnlocked: (s) => s.longestStreak >= 7,
  ),
  Achievement(
    id: AchievementId.streak30,
    icon: Icons.local_fire_department,
    isUnlocked: (s) => s.longestStreak >= 30,
  ),
  Achievement(
    id: AchievementId.weightLogged5,
    icon: Icons.monitor_weight,
    isUnlocked: (s) => s.weightEntriesCount >= 5,
  ),
  Achievement(
    id: AchievementId.weightLogged30,
    icon: Icons.monitor_weight,
    isUnlocked: (s) => s.weightEntriesCount >= 30,
  ),
];
