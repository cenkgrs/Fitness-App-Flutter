import '../models/models.dart';

/// Abstraction over an AI-driven coaching backend. No concrete provider is
/// wired in — implementations should call a server-side endpoint that in
/// turn calls an LLM API; **never embed provider API keys in the Flutter
/// client**. A rule-based [WorkoutRecommendationService] and
/// [WorkoutProgramGenerator] cover the same responsibilities today so the
/// app is fully usable before an AI backend exists.
abstract class AIWorkoutCoach {
  /// Generates a full [WorkoutProgram] tailored to the user's profile.
  /// [locale] ('en'/'tr') is the app's current display language — the
  /// model has no other way to know it, since [profile] carries no
  /// language field.
  Future<WorkoutProgram> generateWorkoutPlan(UserProfile profile, {String locale = 'en'});

  /// Suggests the next target weight/reps for an exercise given recent
  /// performance history.
  Future<ExerciseSet> recommendNextWeight({
    required String exerciseId,
    required List<WorkoutSet> recentSets,
    required ExerciseSet currentTarget,
  });

  /// Produces a short natural-language analysis of a completed session
  /// (form cues, load management, notable PRs).
  Future<String> analyzeWorkout(WorkoutSession session);

  /// Suggests nutrition adjustments (e.g. "increase protein by 20g") based
  /// on recent adherence to [DailyNutrition] targets.
  Future<String> generateNutritionSuggestion(List<DailyNutrition> recentDays);
}
