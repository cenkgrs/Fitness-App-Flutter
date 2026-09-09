import '../models/enums.dart';
import '../models/user_profile.dart';

/// Computes BMR (Mifflin-St Jeor), TDEE, and a goal-adjusted daily calorie
/// target from a [UserProfile]. Kept isolated from UI/state so it can be
/// unit-tested and reused by onboarding, goals, and nutrition settings.
class CalorieCalculator {
  const CalorieCalculator();

  static const _activityMultiplier = {
    ActivityLevel.sedentary: 1.2,
    ActivityLevel.moderatelyActive: 1.45,
    ActivityLevel.veryActive: 1.75,
  };

  static const _goalAdjustment = {
    PrimaryGoal.loseWeight: -500,
    PrimaryGoal.loseFat: -400,
    PrimaryGoal.gainWeight: 400,
    PrimaryGoal.buildMuscle: 300,
    PrimaryGoal.maintainFitness: 0,
  };

  /// Mifflin-St Jeor equation. Male: +5, Female: -161, unspecified: average (-78).
  double bmr(UserProfile profile) {
    final base = 10 * profile.weightKg + 6.25 * profile.heightCm - 5 * profile.age;
    switch (profile.gender) {
      case Gender.male:
        return base + 5;
      case Gender.female:
        return base - 161;
      case Gender.unspecified:
        return base - 78;
    }
  }

  double tdee(UserProfile profile) {
    final multiplier = _activityMultiplier[profile.activityLevel]!;
    return bmr(profile) * multiplier;
  }

  int dailyCalorieTarget(UserProfile profile) {
    final adjustment = _goalAdjustment[profile.primaryGoal] ?? 0;
    final target = tdee(profile) + adjustment;
    return target.clamp(1200, 6000).round();
  }
}
