import 'package:flutter_test/flutter_test.dart';
import 'package:repwise/shared/models/enums.dart';
import 'package:repwise/shared/models/user_profile.dart';
import 'package:repwise/shared/services/calorie_calculator.dart';
import 'package:repwise/shared/services/nutrition_calculator.dart';

void main() {
  const calculator = CalorieCalculator();

  UserProfile buildProfile({
    Gender gender = Gender.male,
    int age = 28,
    double heightCm = 180,
    double weightKg = 80,
    ActivityLevel activityLevel = ActivityLevel.moderatelyActive,
    PrimaryGoal goal = PrimaryGoal.maintainFitness,
    NutritionPreference nutritionPreference = NutritionPreference.standard,
  }) {
    return UserProfile(
      userId: 'u1',
      name: 'Test',
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      gender: gender,
      fitnessLevel: FitnessLevel.intermediate,
      primaryGoal: goal,
      targetWeightKg: weightKg,
      workoutDaysPerWeek: 4,
      workoutDurationMinutes: 45,
      workoutLocation: WorkoutLocation.gym,
      availableEquipment: const [],
      activityLevel: activityLevel,
      nutritionPreference: nutritionPreference,
    );
  }

  group('CalorieCalculator.bmr', () {
    test('male Mifflin-St Jeor formula', () {
      final profile = buildProfile(gender: Gender.male, age: 28, heightCm: 180, weightKg: 80);
      // 10*80 + 6.25*180 - 5*28 + 5 = 800 + 1125 - 140 + 5 = 1790
      expect(calculator.bmr(profile), closeTo(1790, 0.01));
    });

    test('female Mifflin-St Jeor formula', () {
      final profile = buildProfile(gender: Gender.female, age: 28, heightCm: 165, weightKg: 60);
      // 10*60 + 6.25*165 - 5*28 - 161 = 600 + 1031.25 - 140 - 161 = 1330.25
      expect(calculator.bmr(profile), closeTo(1330.25, 0.01));
    });
  });

  group('CalorieCalculator.dailyCalorieTarget', () {
    test('applies deficit for weight-loss goal', () {
      final maintain = buildProfile(goal: PrimaryGoal.maintainFitness);
      final loseWeight = buildProfile(goal: PrimaryGoal.loseWeight);
      expect(
        calculator.dailyCalorieTarget(loseWeight),
        lessThan(calculator.dailyCalorieTarget(maintain)),
      );
    });

    test('applies surplus for muscle-gain goal', () {
      final maintain = buildProfile(goal: PrimaryGoal.maintainFitness);
      final buildMuscle = buildProfile(goal: PrimaryGoal.buildMuscle);
      expect(
        calculator.dailyCalorieTarget(buildMuscle),
        greaterThan(calculator.dailyCalorieTarget(maintain)),
      );
    });

    test('never drops below the safety floor', () {
      final profile = buildProfile(
        gender: Gender.female,
        age: 60,
        heightCm: 150,
        weightKg: 45,
        activityLevel: ActivityLevel.sedentary,
        goal: PrimaryGoal.loseWeight,
      );
      expect(calculator.dailyCalorieTarget(profile), greaterThanOrEqualTo(1200));
    });
  });

  group('NutritionCalculator', () {
    test('macros sum to approximately the calorie target', () {
      final profile = buildProfile();
      final macros = const NutritionCalculator().calculate(profile);
      final recomposed = macros.proteinG * 4 + macros.carbsG * 4 + macros.fatG * 9;
      expect(recomposed, closeTo(macros.calories.toDouble(), macros.calories * 0.05));
    });

    test('keto preference yields high fat, low carb split', () {
      final profile = buildProfile(nutritionPreference: NutritionPreference.keto);
      final macros = const NutritionCalculator().calculate(profile);
      expect(macros.fatG * 9, greaterThan(macros.carbsG * 4));
    });

    test('high protein preference yields more protein than standard for same profile', () {
      final standard = const NutritionCalculator().calculate(buildProfile());
      final highProtein =
          const NutritionCalculator().calculate(buildProfile(nutritionPreference: NutritionPreference.highProtein));
      expect(highProtein.proteinG, greaterThan(standard.proteinG));
    });
  });
}
