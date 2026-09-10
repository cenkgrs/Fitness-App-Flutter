import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'ai_food_parser.dart';

class SupabaseAIFoodParser implements AIFoodParser {
  final sb.SupabaseClient _client;
  static const _uuid = Uuid();

  SupabaseAIFoodParser(this._client);

  @override
  Future<List<MealEntry>> parseMealText(String text) async {
    final response =
        await _client.functions.invoke('ai-coach', body: {'action': 'parse_meal_text', 'text': text});
    if (response.status != 200) {
      throw StateError('ai-coach(parse_meal_text) failed: ${response.status} ${response.data}');
    }
    final result = Map<String, dynamic>.from(response.data as Map);
    final entries = result['entries'] as List<dynamic>;

    return entries.map((raw) {
      final entry = Map<String, dynamic>.from(raw as Map);
      return MealEntry(
        id: _uuid.v4(),
        name: entry['name'] as String,
        quantityGrams: (entry['quantityGrams'] as num).toDouble(),
        calories: (entry['calories'] as num).toDouble(),
        proteinG: (entry['proteinG'] as num).toDouble(),
        carbsG: (entry['carbsG'] as num).toDouble(),
        fatG: (entry['fatG'] as num).toDouble(),
        isQuickAdd: true,
      );
    }).toList();
  }
}
