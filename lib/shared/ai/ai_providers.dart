import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';
import 'ai_food_parser.dart';
import 'ai_workout_coach.dart';
import 'supabase_ai_food_parser.dart';
import 'supabase_ai_workout_coach.dart';

/// Null when Supabase isn't configured — AI features have no local/offline
/// fallback (unlike auth/nutrition), so callers should treat a null value as
/// "feature unavailable" rather than falling back to a fake implementation.
final aiWorkoutCoachProvider = Provider<AIWorkoutCoach?>((ref) {
  if (!SupabaseConfig.isConfigured) return null;
  return SupabaseAIWorkoutCoach(Supabase.instance.client);
});

final aiFoodParserProvider = Provider<AIFoodParser?>((ref) {
  if (!SupabaseConfig.isConfigured) return null;
  return SupabaseAIFoodParser(Supabase.instance.client);
});
