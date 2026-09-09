# Repwise

Personalized fitness, workout tracking, nutrition tracking, and progress tracking app. Flutter (iOS & Android), dark high-contrast "gym mode" design system inspired by Apple Fitness+, Nike Training Club, Hevy, Whoop, and MacroFactor.

## Getting started

```bash
flutter pub get
flutter run
```

Run tests:

```bash
flutter test
```

## Architecture

Feature-first, with each feature split into `data` / `domain` / `presentation` layers:

```
lib/
  core/        # theme tokens, reusable widgets, routing, constants
  features/
    auth/ onboarding/ home/ workouts/ nutrition/ progress/ goals/ profile/ settings/
  shared/
    models/    # User, UserProfile, Goal, WorkoutProgram, WorkoutSession, Meal, ...
    services/  # CalorieCalculator, NutritionCalculator, ConsistencyService, ...
    ai/        # AIWorkoutCoach abstraction (no provider wired in yet)
```

State management: Riverpod. Persistence: Hive, behind repository interfaces (`AuthRepository`, `WorkoutRepository`, `NutritionRepository`) so a remote backend (Firebase/Supabase) can replace the local implementation without touching UI code.

## Status

All 8 build phases from the original spec are implemented: onboarding → auth → home dashboard → workout program & detail → active workout runner (gym mode) → nutrition & meal logging → progress charts & goals → settings, plus an `AIWorkoutCoach` abstraction and unit tests for the calorie/macro math, consistency streaks, and the active-workout state machine.

Known gaps: body-measurement tracking isn't built yet; push notifications and real OAuth are behind abstractions but not wired to a provider.
