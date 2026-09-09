// Shared enums used across models and services.

enum Gender { male, female, unspecified }

enum FitnessLevel { beginner, intermediate, advanced }

enum PrimaryGoal { loseWeight, gainWeight, buildMuscle, loseFat, maintainFitness }

enum WorkoutLocation { gym, home, both }

enum ActivityLevel { sedentary, moderatelyActive, veryActive }

enum NutritionPreference { standard, highProtein, keto, vegetarian, vegan }

enum WeightUnit { kg, lbs }

enum DistanceUnit { km, miles }

enum MealType { breakfast, lunch, dinner, snack }

enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  legs,
  glutes,
  core,
  cardio,
  fullBody,
}

enum Equipment {
  barbell,
  dumbbell,
  bench,
  cable,
  machine,
  resistanceBand,
  bodyweight,
  kettlebell,
}

enum WorkoutSessionStatus { notStarted, inProgress, paused, completed, cancelled }

T enumFromString<T>(List<T> values, String? name, T fallback) {
  if (name == null) return fallback;
  return values.firstWhere(
    (v) => (v as dynamic).name == name,
    orElse: () => fallback,
  );
}
