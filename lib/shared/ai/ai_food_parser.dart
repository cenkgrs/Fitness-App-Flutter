import '../models/models.dart';

/// AI-assisted free-text meal parsing (e.g. "3 eggs, 100g rice" → structured
/// entries). Kept separate from [AIWorkoutCoach] — a nutrition-domain
/// concern, not a workout one.
abstract class AIFoodParser {
  Future<List<MealEntry>> parseMealText(String text);
}
