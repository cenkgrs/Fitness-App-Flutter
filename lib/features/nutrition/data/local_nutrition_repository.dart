import 'package:uuid/uuid.dart';
import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/nutrition_repository.dart';
import 'food_seed_data.dart';
import 'open_food_facts_client.dart';

class LocalNutritionRepository implements NutritionRepository {
  final LocalStorageService _storage;

  LocalNutritionRepository(this._storage) {
    if (_storage.foodsBox.isEmpty) {
      for (final food in seedFoods) {
        _storage.foodsBox.put(food.id, food.toJson());
      }
    }
  }

  String _mealKey(String userId, DateTime date, MealType type) =>
      '$userId:${date.year}-${date.month}-${date.day}:${type.name}';

  @override
  Future<List<Meal>> getMealsForDate(String userId, DateTime date) async {
    final meals = <Meal>[];
    for (final type in MealType.values) {
      final raw = _storage.mealsBox.get(_mealKey(userId, date, type));
      if (raw != null) {
        meals.add(Meal.fromJson(Map<String, dynamic>.from(raw as Map)));
      }
    }
    return meals;
  }

  @override
  Future<void> saveMeal(Meal meal) async {
    await _storage.mealsBox.put(_mealKey(meal.userId, meal.date, meal.type), meal.toJson());
  }

  @override
  Future<void> removeEntry(String mealId, String entryId) async {
    for (final key in _storage.mealsBox.keys) {
      final raw = _storage.mealsBox.get(key);
      if (raw == null) continue;
      final meal = Meal.fromJson(Map<String, dynamic>.from(raw as Map));
      if (meal.id == mealId) {
        final updated = meal.copyWith(entries: meal.entries.where((e) => e.id != entryId).toList());
        await _storage.mealsBox.put(key, updated.toJson());
        return;
      }
    }
  }

  @override
  Future<List<Food>> searchFoods(String query, {String country = ''}) async {
    final all = _storage.foodsBox.values
        .map((raw) => Food.fromJson(Map<String, dynamic>.from(raw as Map)))
        .toList();
    if (query.trim().isEmpty) return all;
    final lower = query.toLowerCase();
    return all.where((f) => f.name.toLowerCase().contains(lower)).toList();
  }

  @override
  Future<Food?> getFoodByBarcode(String barcode) async {
    final trimmed = barcode.trim();
    if (trimmed.isEmpty) return null;
    for (final raw in _storage.foodsBox.values) {
      final food = Food.fromJson(Map<String, dynamic>.from(raw as Map));
      if (food.id == trimmed) return food;
    }
    final client = OpenFoodFactsClient();
    final found = await client.getByBarcode(trimmed);
    if (found != null) await _storage.foodsBox.put(found.id, found.toJson());
    return found;
  }

  @override
  Future<void> addCustomFood(Food food) async {
    await _storage.foodsBox.put(food.id, food.toJson());
  }

  @override
  Future<List<WeightEntry>> getWeightEntries(String userId) async {
    return _storage.weightBox.values
        .map((raw) => WeightEntry.fromJson(Map<String, dynamic>.from(raw as Map)))
        .where((w) => w.userId == userId)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Future<void> addWeightEntry(WeightEntry entry) async {
    await _storage.weightBox.put(entry.id, entry.toJson());
  }
}

// Re-export a fresh id helper for callers building new entries.
String newId() => const Uuid().v4();
