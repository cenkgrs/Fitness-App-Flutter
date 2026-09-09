import '../../../shared/models/models.dart';

abstract class NutritionRepository {
  Future<List<Meal>> getMealsForDate(String userId, DateTime date);
  Future<void> saveMeal(Meal meal);
  Future<void> removeEntry(String mealId, String entryId);
  Future<List<Food>> searchFoods(String query);
  Future<void> addCustomFood(Food food);

  Future<List<WeightEntry>> getWeightEntries(String userId);
  Future<void> addWeightEntry(WeightEntry entry);
}
