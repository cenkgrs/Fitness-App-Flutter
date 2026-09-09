import 'package:equatable/equatable.dart';
import 'meal.dart';

/// Aggregated nutrition totals for a single calendar day, derived from
/// that day's [Meal]s plus the active calorie/macro goals.
class DailyNutrition extends Equatable {
  final DateTime date;
  final List<Meal> meals;
  final int calorieGoal;
  final int proteinGoal;
  final int carbsGoal;
  final int fatGoal;

  const DailyNutrition({
    required this.date,
    required this.meals,
    required this.calorieGoal,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatGoal,
  });

  double get consumedCalories => meals.fold(0.0, (s, m) => s + m.totalCalories);
  double get consumedProteinG => meals.fold(0.0, (s, m) => s + m.totalProteinG);
  double get consumedCarbsG => meals.fold(0.0, (s, m) => s + m.totalCarbsG);
  double get consumedFatG => meals.fold(0.0, (s, m) => s + m.totalFatG);

  double get remainingCalories => calorieGoal - consumedCalories;
  double get calorieProgress => calorieGoal == 0 ? 0 : (consumedCalories / calorieGoal).clamp(0, 1.5);

  @override
  List<Object?> get props => [date, meals, calorieGoal, proteinGoal, carbsGoal, fatGoal];
}
