import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/nutrition_repository.dart';
import 'open_food_facts_client.dart';

/// Supabase-backed [NutritionRepository]. The `foods` table doubles as a
/// growing cache of Open Food Facts results — every search upserts new
/// products (keyed on barcode) so later searches, and other users, hit the
/// local catalog first instead of the external API every time.
class SupabaseNutritionRepository implements NutritionRepository {
  final sb.SupabaseClient _client;
  final OpenFoodFactsClient _openFoodFacts;

  SupabaseNutritionRepository(this._client, {OpenFoodFactsClient? openFoodFacts})
      : _openFoodFacts = openFoodFacts ?? OpenFoodFactsClient();

  String _dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Food _foodFromRow(Map<String, dynamic> row) => Food(
        id: row['id'] as String,
        name: row['name'] as String,
        brand: row['brand'] as String?,
        caloriesPer100g: (row['calories_per_100g'] as num).toDouble(),
        proteinPer100g: (row['protein_per_100g'] as num).toDouble(),
        carbsPer100g: (row['carbs_per_100g'] as num).toDouble(),
        fatPer100g: (row['fat_per_100g'] as num).toDouble(),
      );

  Map<String, dynamic> _foodToRow(Food food, {String? barcode, required String source}) => {
        'name': food.name,
        'brand': food.brand,
        'calories_per_100g': food.caloriesPer100g,
        'protein_per_100g': food.proteinPer100g,
        'carbs_per_100g': food.carbsPer100g,
        'fat_per_100g': food.fatPer100g,
        if (barcode != null) 'barcode': barcode,
        'source': source,
      };

  Meal _mealFromRow(Map<String, dynamic> row) => Meal(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        date: DateTime.parse(row['date'] as String),
        type: enumFromString(MealType.values, row['type'] as String?, MealType.snack),
        entries: (row['entries'] as List<dynamic>? ?? [])
            .map((e) => MealEntry.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );

  Map<String, dynamic> _mealToRow(Meal meal) => {
        // id intentionally omitted: on insert Postgres assigns it (default
        // gen_random_uuid()); on update-by-conflict the existing row's id
        // stays untouched. Letting the client dictate id here would fight
        // the (user_id, date, type) upsert target for no benefit.
        'user_id': meal.userId,
        'date': _dateOnly(meal.date),
        'type': meal.type.name,
        'entries': meal.entries.map((e) => e.toJson()).toList(),
      };

  WeightEntry _weightFromRow(Map<String, dynamic> row) => WeightEntry(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        date: DateTime.parse(row['date'] as String),
        weightKg: (row['weight_kg'] as num).toDouble(),
        note: row['note'] as String?,
      );

  @override
  Future<List<Food>> searchFoods(String query, {String country = ''}) async {
    final trimmed = query.trim();

    final catalogRows = trimmed.isEmpty
        ? await _client.from('foods').select().order('name').limit(30)
        : await _client.from('foods').select().ilike('name', '%$trimmed%').limit(20);
    final catalog =
        (catalogRows as List).cast<Map<String, dynamic>>().map(_foodFromRow).toList();

    if (trimmed.isEmpty) return catalog;

    List<Food> external = const [];
    try {
      external = await _openFoodFacts.search(trimmed, country: country);
    } catch (_) {
      // External source hiccup — the local catalog results above still
      // stand, so the user isn't left with an empty screen.
    }
    if (external.isEmpty) return catalog;

    var cached = external;
    try {
      final rows = external
          .map((f) => _foodToRow(f, barcode: f.id, source: 'openfoodfacts'))
          .toList();
      final upserted =
          await _client.from('foods').upsert(rows, onConflict: 'barcode').select();
      cached = (upserted as List).cast<Map<String, dynamic>>().map(_foodFromRow).toList();
    } catch (_) {
      // Caching failed (e.g. offline write) — still show the live OFF
      // results even though they won't be persisted this time.
    }

    final seen = <String>{};
    final merged = <Food>[];
    for (final food in [...catalog, ...cached]) {
      if (seen.add(food.id)) merged.add(food);
    }
    return merged;
  }

  @override
  Future<Food?> getFoodByBarcode(String barcode) async {
    final trimmed = barcode.trim();
    if (trimmed.isEmpty) return null;

    final rows = await _client.from('foods').select().eq('barcode', trimmed).limit(1);
    final cached = (rows as List).cast<Map<String, dynamic>>();
    if (cached.isNotEmpty) return _foodFromRow(cached.first);

    Food? found;
    try {
      found = await _openFoodFacts.getByBarcode(trimmed);
    } catch (_) {
      return null;
    }
    if (found == null) return null;

    try {
      final upserted = await _client
          .from('foods')
          .upsert(_foodToRow(found, barcode: trimmed, source: 'openfoodfacts'), onConflict: 'barcode')
          .select()
          .limit(1);
      final list = (upserted as List).cast<Map<String, dynamic>>();
      if (list.isNotEmpty) return _foodFromRow(list.first);
    } catch (_) {
      // Caching failed — still return the live lookup result.
    }
    return found;
  }

  @override
  Future<void> addCustomFood(Food food) async {
    await _client.from('foods').insert(_foodToRow(food, source: 'user'));
  }

  @override
  Future<List<Meal>> getMealsForDate(String userId, DateTime date) async {
    final rows = await _client
        .from('meals')
        .select()
        .eq('user_id', userId)
        .eq('date', _dateOnly(date));
    return (rows as List).cast<Map<String, dynamic>>().map(_mealFromRow).toList();
  }

  @override
  Future<void> saveMeal(Meal meal) async {
    await _client.from('meals').upsert(_mealToRow(meal), onConflict: 'user_id,date,type');
  }

  @override
  Future<void> removeEntry(String mealId, String entryId) async {
    final rows = await _client.from('meals').select().eq('id', mealId).limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isEmpty) return;
    final meal = _mealFromRow(list.first);
    final updatedEntries = meal.entries.where((e) => e.id != entryId).toList();
    await _client
        .from('meals')
        .update({'entries': updatedEntries.map((e) => e.toJson()).toList()}).eq('id', mealId);
  }

  @override
  Future<List<WeightEntry>> getWeightEntries(String userId) async {
    final rows =
        await _client.from('weight_entries').select().eq('user_id', userId).order('date');
    return (rows as List).cast<Map<String, dynamic>>().map(_weightFromRow).toList();
  }

  @override
  Future<void> addWeightEntry(WeightEntry entry) async {
    await _client.from('weight_entries').insert({
      'user_id': entry.userId,
      'date': _dateOnly(entry.date),
      'weight_kg': entry.weightKg,
      'note': entry.note,
    });
  }

  @override
  Future<int> getWaterIntake(String userId, DateTime date) async {
    final rows = await _client
        .from('water_intake')
        .select()
        .eq('user_id', userId)
        .eq('date', _dateOnly(date))
        .limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isEmpty) return 0;
    return (list.first['amount_ml'] as num).toInt();
  }

  @override
  Future<void> addWater(String userId, DateTime date, int amountMl) async {
    final current = await getWaterIntake(userId, date);
    await _client.from('water_intake').upsert({
      'user_id': userId,
      'date': _dateOnly(date),
      'amount_ml': current + amountMl,
    }, onConflict: 'user_id,date');
  }
}
