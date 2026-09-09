import '../models/enums.dart';
import '../models/user_profile.dart';
import 'calorie_calculator.dart';

class MacroTargets {
  final int calories;
  final int proteinG;
  final int carbsG;
  final int fatG;

  const MacroTargets({
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
  });
}

/// Derives protein/carb/fat gram targets from the calorie target and the
/// user's nutrition preference. Split out from [CalorieCalculator] so each
/// service has a single responsibility.
class NutritionCalculator {
  final CalorieCalculator _calorieCalculator;

  const NutritionCalculator([this._calorieCalculator = const CalorieCalculator()]);

  static const _proteinPerKg = {
    NutritionPreference.standard: 1.8,
    NutritionPreference.highProtein: 2.4,
    NutritionPreference.keto: 1.8,
    NutritionPreference.vegetarian: 1.6,
    NutritionPreference.vegan: 1.6,
  };

  static const _fatPercentOfCalories = {
    NutritionPreference.standard: 0.28,
    NutritionPreference.highProtein: 0.25,
    NutritionPreference.keto: 0.70,
    NutritionPreference.vegetarian: 0.28,
    NutritionPreference.vegan: 0.28,
  };

  MacroTargets calculate(UserProfile profile) {
    final calories = _calorieCalculator.dailyCalorieTarget(profile);
    final proteinPerKg = _proteinPerKg[profile.nutritionPreference]!;
    final proteinG = (proteinPerKg * profile.weightKg).round();
    final proteinCalories = proteinG * 4;

    final fatPercent = _fatPercentOfCalories[profile.nutritionPreference]!;
    final fatCalories = calories * fatPercent;
    final fatG = (fatCalories / 9).round();

    final remainingCalories = (calories - proteinCalories - fatCalories).clamp(0, calories).toDouble();
    final carbsG = (remainingCalories / 4).round();

    return MacroTargets(calories: calories, proteinG: proteinG, carbsG: carbsG, fatG: fatG);
  }
}
