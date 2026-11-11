import '../../../l10n/app_localizations.dart';

// Programs built by WorkoutProgramGenerator store English names, which also
// double as the wger.de image lookup key — so they stay English in the data
// and get translated only for display. Anything not in these tables (e.g. a
// program the AI coach wrote) is shown as-is.

String workoutDayName(AppLocalizations l10n, String name) => switch (name) {
      'Full Body A' => l10n.dayFullBodyA,
      'Full Body B' => l10n.dayFullBodyB,
      'Full Body C' => l10n.dayFullBodyC,
      'Full Body' => l10n.dayFullBody,
      'Upper Body Power' => l10n.dayUpperBodyPower,
      'Upper Body Hypertrophy' => l10n.dayUpperBodyHypertrophy,
      'Upper Body' => l10n.dayUpperBody,
      'Lower Body Focus' => l10n.dayLowerBodyFocus,
      'Lower Body' => l10n.dayLowerBody,
      'Push Day' => l10n.dayPush,
      'Pull Day' => l10n.dayPull,
      'Legs & Core' => l10n.dayLegsCore,
      'Active Recovery' => l10n.dayActiveRecovery,
      'Rest & Recovery' => l10n.dayRest,
      _ => name,
    };

String workoutProgramName(AppLocalizations l10n, String name) => switch (name) {
      'Full Body Program' => l10n.programFullBody,
      'Upper/Lower Split' => l10n.programUpperLower,
      _ => name,
    };

String exerciseName(AppLocalizations l10n, String name) => switch (name) {
      'Bench Press (Barbell)' => l10n.exBenchPress,
      'Incline Dumbbell Press' => l10n.exInclineDumbbellPress,
      'Overhead Press' => l10n.exOverheadPress,
      'Triceps Pushdown' => l10n.exTricepsPushdown,
      'Lateral Raise' => l10n.exLateralRaise,
      'Deadlift' => l10n.exDeadlift,
      'Pull-Up' => l10n.exPullUp,
      'Barbell Row' => l10n.exBarbellRow,
      'Face Pull' => l10n.exFacePull,
      'Bicep Curl' => l10n.exBicepCurl,
      'Back Squat' => l10n.exBackSquat,
      'Romanian Deadlift' => l10n.exRomanianDeadlift,
      'Leg Press' => l10n.exLegPress,
      'Walking Lunge' => l10n.exWalkingLunge,
      'Plank' => l10n.exPlank,
      'Goblet Squat' => l10n.exGobletSquat,
      'Push-Up' => l10n.exPushUp,
      'Dumbbell Row' => l10n.exDumbbellRow,
      _ => name,
    };

