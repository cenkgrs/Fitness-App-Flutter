import '../../../shared/models/models.dart';

abstract class NutritionRepository {
  Future<List<Meal>> getMealsForDate(String userId, DateTime date);
  Future<void> saveMeal(Meal meal);
  Future<void> removeEntry(String mealId, String entryId);
  /// [country] is an Open Food Facts country tag used to restrict results
  /// (e.g. 'Turkey'); empty means no filter.
  Future<List<Food>> searchFoods(String query, {String country = ''});
  Future<Food?> getFoodByBarcode(String barcode);
  Future<void> addCustomFood(Food food);

  Future<List<WeightEntry>> getWeightEntries(String userId);
  Future<void> addWeightEntry(WeightEntry entry);
}
