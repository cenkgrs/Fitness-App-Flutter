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

  /// Exercise/day ids must stay stable across regenerations — logged
  /// [WorkoutSet.exerciseId]/[WorkoutSession.workoutDayId] history is keyed
  /// on them, and strength-progression charts + "completed today" checkmarks
  /// look history up by id. A fresh random uuid per regeneration (the
  /// previous behavior) orphaned all prior history the moment the plan
  /// changed. Slugifying the name gives the same exercise the same id every
  /// time it reappears.
  String _slug(String name) =>
      name.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

  @override
  Future<WorkoutProgram> generateWorkoutPlan(UserProfile profile, {String locale = 'en'}) async {
    final result =
        await _invoke('generate_workout_plan', {'profile': profile.toJson(), 'locale': locale});

    final days = (result['days'] as List<dynamic>).map((rawDay) {
      final day = Map<String, dynamic>.from(rawDay as Map);
      final exercises = (day['exercises'] as List<dynamic>).map((rawExercise) {
        final exercise = Map<String, dynamic>.from(rawExercise as Map);
        final sets = (exercise['sets'] as List<dynamic>)
            .map((rawSet) => ExerciseSet.fromJson(Map<String, dynamic>.from(rawSet as Map)))
            .toList();
        final exerciseName = exercise['name'] as String;
        return Exercise(
          id: _slug(exerciseName),
          name: exerciseName,
          muscleGroup: enumFromString(MuscleGroup.values, exercise['muscleGroup'] as String?, MuscleGroup.fullBody),
          equipment: (exercise['equipment'] as List<dynamic>)
              .map((e) => enumFromString(Equipment.values, e as String?, Equipment.bodyweight))
              .toList(),
          instructions: exercise['instructions'] as String,
          sets: sets,
          restDuration: Duration(seconds: exercise['restDurationSeconds'] as int),
        );
      }).toList();

      final dayOfWeek = day['dayOfWeek'] as int;
      return WorkoutDay(
        id: 'day-$dayOfWeek',
        name: day['name'] as String,
        dayOfWeek: dayOfWeek,
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
