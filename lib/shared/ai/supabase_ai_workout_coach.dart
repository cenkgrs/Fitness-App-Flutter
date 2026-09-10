import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'ai_workout_coach.dart';

/// Calls the `ai-coach` Supabase Edge Function (Gemini-backed) for all four
/// [AIWorkoutCoach] methods. The Edge Function returns bare content
/// (exercise names, sets, day structure) without ids — those are generated
/// here, since asking the model to invent valid unique ids is unnecessary
/// and unreliable.
class SupabaseAIWorkoutCoach implements AIWorkoutCoach {
  final sb.SupabaseClient _client;
  static const _uuid = Uuid();

  SupabaseAIWorkoutCoach(this._client);

  Future<Map<String, dynamic>> _invoke(String action, Map<String, dynamic> payload) async {
    final response = await _client.functions.invoke('ai-coach', body: {'action': action, ...payload});
    if (response.status != 200) {
      throw StateError('ai-coach($action) failed: ${response.status} ${response.data}');
    }
    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<WorkoutProgram> generateWorkoutPlan(UserProfile profile) async {
    final result = await _invoke('generate_workout_plan', {'profile': profile.toJson()});

    final days = (result['days'] as List<dynamic>).map((rawDay) {
      final day = Map<String, dynamic>.from(rawDay as Map);
      final exercises = (day['exercises'] as List<dynamic>).map((rawExercise) {
        final exercise = Map<String, dynamic>.from(rawExercise as Map);
        final sets = (exercise['sets'] as List<dynamic>)
            .map((rawSet) => ExerciseSet.fromJson(Map<String, dynamic>.from(rawSet as Map)))
            .toList();
        return Exercise(
          id: _uuid.v4(),
          name: exercise['name'] as String,
          muscleGroup: enumFromString(MuscleGroup.values, exercise['muscleGroup'] as String?, MuscleGroup.fullBody),
          equipment: (exercise['equipment'] as List<dynamic>)
              .map((e) => enumFromString(Equipment.values, e as String?, Equipment.bodyweight))
              .toList(),
          instructions: exercise['instructions'] as String,
          sets: sets,
          restDuration: Duration(seconds: exercise['restDurationSeconds'] as int),
        );
      }).toList();

      return WorkoutDay(
        id: _uuid.v4(),
        name: day['name'] as String,
        dayOfWeek: day['dayOfWeek'] as int,
        exercises: exercises,
        isRestDay: day['isRestDay'] as bool,
        estimatedDuration: Duration(minutes: day['estimatedDurationMinutes'] as int),
      );
    }).toList();

    return WorkoutProgram(
      id: _uuid.v4(),
      userId: profile.userId,
      name: result['name'] as String,
      days: days,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<ExerciseSet> recommendNextWeight({
    required String exerciseId,
    required List<WorkoutSet> recentSets,
    required ExerciseSet currentTarget,
  }) async {
    final result = await _invoke('recommend_next_weight', {
      'recentSets': recentSets.map((s) => s.toJson()).toList(),
      'currentTarget': currentTarget.toJson(),
    });
    return ExerciseSet.fromJson(result);
  }

  @override
  Future<String> analyzeWorkout(WorkoutSession session) async {
    final result = await _invoke('analyze_workout', {'session': session.toJson()});
    return result['text'] as String;
  }

  @override
  Future<String> generateNutritionSuggestion(List<DailyNutrition> recentDays) async {
    final result = await _invoke('generate_nutrition_suggestion', {
      'recentDays': recentDays
          .map((d) => {
                'date': d.date.toIso8601String(),
                'calorieGoal': d.calorieGoal,
                'proteinGoal': d.proteinGoal,
                'carbsGoal': d.carbsGoal,
                'fatGoal': d.fatGoal,
                'consumedCalories': d.consumedCalories,
                'consumedProteinG': d.consumedProteinG,
              })
          .toList(),
    });
    return result['text'] as String;
  }
}
