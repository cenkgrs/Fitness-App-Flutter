// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'THRIVE+';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get authSignUpTitle => 'Create Account';

  @override
  String get authSignInTitle => 'Welcome Back';

  @override
  String get authSignUpSubtitle =>
      'Create an account first, then we\'ll build your personalized plan together.';

  @override
  String get authSignInSubtitle => 'Sign in and pick up where you left off.';

  @override
  String get authContinueWithApple => 'Continue with Apple';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authOrWithEmail => 'or with email';

  @override
  String get authEmailHint => 'Email';

  @override
  String get authPasswordHint => 'Password';

  @override
  String get authSignUpButton => 'Sign Up';

  @override
  String get authSignInButton => 'Sign In';

  @override
  String get authSwitchToSignIn => 'Already have an account? Sign In';

  @override
  String get authSwitchToSignUp => 'Don\'t have an account? Sign Up';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authResetPasswordTitle => 'Reset Password';

  @override
  String get authResetPasswordMessage =>
      'Enter your email and we\'ll send you a reset link.';

  @override
  String get authResetPasswordSend => 'Send Reset Link';

  @override
  String get authResetPasswordSent =>
      'If that email exists, a reset link has been sent.';

  @override
  String get authResetPasswordFailed =>
      'Couldn\'t send the reset link. Please try again.';

  @override
  String get authNewPasswordTitle => 'Set a New Password';

  @override
  String get authNewPasswordHint => 'New password';

  @override
  String get authNewPasswordButton => 'Update Password';

  @override
  String get authNewPasswordSuccess => 'Password updated. You\'re all set.';

  @override
  String authErrorSnackbar(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingWelcomeHeadline => 'Reach your peak physique';

  @override
  String get onboardingWelcomeSubtitle =>
      'We\'ll ask a few questions to build your personalized workout and nutrition plan.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingNameTitle => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Your name';

  @override
  String get onboardingGenderTitle => 'What\'s your gender?';

  @override
  String get onboardingGenderMale => 'Male';

  @override
  String get onboardingGenderFemale => 'Female';

  @override
  String get onboardingGenderUnspecified => 'Prefer not to say';

  @override
  String get onboardingAgeTitle => 'How old are you?';

  @override
  String get onboardingHeightTitle => 'Your height (cm)';

  @override
  String get onboardingWeightTitle => 'Your weight (kg)';

  @override
  String get onboardingTargetWeightTitle => 'Target weight (kg)';

  @override
  String get onboardingFitnessLevelTitle => 'What\'s your fitness level?';

  @override
  String get fitnessBeginnerLabel => 'Beginner';

  @override
  String get fitnessBeginnerSubtitle => 'Learning basic form (0-1 year)';

  @override
  String get fitnessIntermediateLabel => 'Intermediate';

  @override
  String get fitnessIntermediateSubtitle => 'Training consistently (1-3 years)';

  @override
  String get fitnessAdvancedLabel => 'Advanced';

  @override
  String get fitnessAdvancedSubtitle =>
      'Heavy training & periodization (3+ years)';

  @override
  String get onboardingPrimaryGoalTitle => 'What\'s your main goal?';

  @override
  String get goalLoseWeight => 'Lose Weight';

  @override
  String get goalBuildMuscle => 'Build Muscle';

  @override
  String get goalLoseFat => 'Lose Fat';

  @override
  String get goalMaintainFitness => 'Maintain Fitness';

  @override
  String get onboardingDaysPerWeekTitle =>
      'How many days a week do you want to train?';

  @override
  String get onboardingMostPopular => 'Most popular';

  @override
  String get onboardingDurationTitle => 'How long should your workouts be?';

  @override
  String onboardingDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get onboardingLocationTitle => 'Where do you train?';

  @override
  String get locationGym => 'Gym';

  @override
  String get locationHome => 'Home';

  @override
  String get locationBoth => 'Both';

  @override
  String get onboardingEquipmentLabel => 'Equipment';

  @override
  String get onboardingActivityLevelTitle =>
      'What\'s your daily activity level?';

  @override
  String get activitySedentaryLabel => 'Sedentary';

  @override
  String get activitySedentarySubtitle => 'Desk job, little movement';

  @override
  String get activityModeratelyActiveLabel => 'Moderately Active';

  @override
  String get activityModeratelyActiveSubtitle => '~7,500 steps/day';

  @override
  String get activityVeryActiveLabel => 'Very Active';

  @override
  String get activityVeryActiveSubtitle => '10,000+ steps/day, physical job';

  @override
  String get onboardingNutritionPrefTitle =>
      'What\'s your nutrition preference?';

  @override
  String get nutritionStandard => 'Standard';

  @override
  String get nutritionHighProtein => 'High Protein';

  @override
  String get nutritionKeto => 'Ketogenic';

  @override
  String get nutritionVegetarian => 'Vegetarian';

  @override
  String get nutritionVegan => 'Vegan';

  @override
  String get onboardingCalculatingLine1 => 'Calculating your metabolic rate...';

  @override
  String get onboardingCalculatingLine2 =>
      'Optimizing your hypertrophy volume...';

  @override
  String onboardingPlanReadyTitle(String name) {
    return 'Your Plan Is Ready, $name!';
  }

  @override
  String get onboardingDefaultName => 'Champion';

  @override
  String get onboardingDailyCalories => 'Daily Calories';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Carbs';

  @override
  String get macroFat => 'Fat';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return '$days Days / Week Program';
  }

  @override
  String get onboardingPlanTagline => 'Muscle Hypertrophy & Fat Loss';

  @override
  String get onboardingStartMyPlan => 'Start My Plan';

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String get homeDefaultAthleteName => 'Athlete';

  @override
  String get homeReadySubtitle => 'Ready to get stronger?';

  @override
  String homeCaloriesLeft(int count) {
    return '$count left';
  }

  @override
  String get homeTodaysWorkoutLabel => 'TODAY\'S WORKOUT';

  @override
  String get homeRestDayMessage => 'Rest day today. 🧘';

  @override
  String get homeNoWorkoutPlanned => 'No workout planned yet.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '⏱ $minutes min • 🏋️ $count exercises';
  }

  @override
  String get homeStartWorkout => 'Start Workout';

  @override
  String get homeWeightGoalLabel => 'WEIGHT GOAL';

  @override
  String homeWeightRemaining(String kg) {
    return 'Remaining: $kg kg';
  }

  @override
  String get homeQuickActionAddMeal => 'Add Meal';

  @override
  String get homeQuickActionLogWeight => 'Log Weight';

  @override
  String get homeQuickActionViewProgress => 'View Progress';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get commonCancel => 'Cancel';

  @override
  String get weekdayMonday => 'Monday';

  @override
  String get weekdayTuesday => 'Tuesday';

  @override
  String get weekdayWednesday => 'Wednesday';

  @override
  String get weekdayThursday => 'Thursday';

  @override
  String get weekdayFriday => 'Friday';

  @override
  String get weekdaySaturday => 'Saturday';

  @override
  String get weekdaySunday => 'Sunday';

  @override
  String get workoutsScreenTitle => 'Weekly Routine';

  @override
  String get workoutsAiUpdateTooltip => 'Update with AI';

  @override
  String workoutsAiUpdateFailedSnackbar(String error) {
    return 'AI couldn\'t update the program: $error';
  }

  @override
  String workoutsFailedToLoad(String error) {
    return 'Failed to load program: $error';
  }

  @override
  String get workoutsOnboardingCta =>
      'Complete onboarding to generate your personalized routine.';

  @override
  String get workoutsCreateMyPlan => 'Create My Plan';

  @override
  String get activeWorkoutNoExercises => 'No exercises for this day.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return 'Exercise $current of $total';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'SET $current OF $total';
  }

  @override
  String activeWorkoutTarget(String weight, String reps) {
    return 'Target: $weight kg × $reps reps';
  }

  @override
  String get activeWorkoutWeightLabel => 'WEIGHT (KG)';

  @override
  String get activeWorkoutRepsLabel => 'REPS';

  @override
  String get activeWorkoutSkipExercise => 'Skip Exercise';

  @override
  String get activeWorkoutAddSet => 'Add Set';

  @override
  String get activeWorkoutCompleteSet => 'COMPLETE SET';

  @override
  String get activeWorkoutEndTitle => 'End workout?';

  @override
  String get activeWorkoutEndContent =>
      'Your progress on this session will be lost.';

  @override
  String get activeWorkoutEndConfirm => 'End Workout';

  @override
  String get workoutDetailNotFound => 'Workout not found';

  @override
  String get workoutDetailStartButton => 'START WORKOUT';

  @override
  String get workoutSummarySessionNotFound => 'Session not found';

  @override
  String get workoutSummaryComplete => 'WORKOUT COMPLETE 🎉';

  @override
  String get workoutSummaryDuration => 'Duration';

  @override
  String get workoutSummaryTotalVolume => 'Total Volume';

  @override
  String get workoutSummarySetsCompleted => 'Sets Completed';

  @override
  String get workoutSummaryEstCalories => 'Est. Calories';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'NEW PR! $weight kg × $reps reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Great work! Your muscles are getting stronger and you\'re one step closer to your goal.';

  @override
  String get workoutSummaryFinish => 'Finish & Return Home';

  @override
  String get commonAdd => 'Add';

  @override
  String get nutritionToday => 'Today';

  @override
  String nutritionCaloriesProgress(int consumed, int goal) {
    return '$consumed / $goal kcal';
  }

  @override
  String get mealTypeBreakfast => 'Breakfast';

  @override
  String get mealTypeLunch => 'Lunch';

  @override
  String get mealTypeDinner => 'Dinner';

  @override
  String get mealTypeSnack => 'Snack';

  @override
  String foodLoggerTitle(String mealType) {
    return 'Add to $mealType';
  }

  @override
  String get foodLoggerSearchTab => 'Search';

  @override
  String get foodLoggerQuickAddTab => 'Quick Add';

  @override
  String get foodLoggerSearchHint => 'Search for food or brand...';

  @override
  String get foodLoggerNoResultsTitle => 'No results';

  @override
  String get foodLoggerNoResultsMessage => 'Try a different search term.';

  @override
  String foodLoggerNutritionSummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal / 100g • P:${protein}g C:${carbs}g F:${fat}g';
  }

  @override
  String foodLoggerQuantitySummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal — P: ${protein}g, C: ${carbs}g, F: ${fat}g';
  }

  @override
  String get foodLoggerAiHint => 'e.g. 3 eggs, 100g rice, a handful of almonds';

  @override
  String get foodLoggerAiFillButton => 'Fill with AI';

  @override
  String get foodLoggerAiParsing => 'Parsing...';

  @override
  String get foodLoggerOrManualEntry => 'or enter manually';

  @override
  String foodLoggerAiParseFailedSnackbar(String error) {
    return 'AI couldn\'t parse the meal: $error';
  }

  @override
  String get quickAddCaloriesLabel => 'Calories';

  @override
  String get quickAddProteinLabel => 'Protein (g)';

  @override
  String get quickAddCarbsLabel => 'Carbs (g)';

  @override
  String get quickAddFatLabel => 'Fat (g)';

  @override
  String get quickAddEntryDefaultName => 'Quick Add';

  @override
  String get progressScreenTitle => 'Progress';

  @override
  String get progressTabWeight => 'Weight';

  @override
  String get progressTabStrength => 'Strength';

  @override
  String get progressTabConsistency => 'Consistency';

  @override
  String get progressTabMeasurements => 'Measurements';

  @override
  String get progressWeightChartTitle => 'Weight (kg)';

  @override
  String get progressStrengthEmptyTitle => 'No strength data yet';

  @override
  String get progressStrengthEmptyMessage =>
      'Complete a workout to start tracking your 1RM progression.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise Progression';
  }

  @override
  String get progressCurrentStreak => 'Current Streak';

  @override
  String get progressLongestStreak => 'Longest Streak';

  @override
  String get progressConsistencyLabel => 'Consistency';

  @override
  String get measurementWaist => 'Waist';

  @override
  String get measurementNeck => 'Neck';

  @override
  String get measurementHip => 'Hip';

  @override
  String get measurementChest => 'Chest';

  @override
  String get measurementBiceps => 'Biceps';

  @override
  String get measurementThigh => 'Thigh';

  @override
  String get measurementsBodyFatHint =>
      'Add your waist and neck measurements to see your body fat percentage.';

  @override
  String measurementsBodyFatLabel(String category) {
    return 'Body Fat — $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Essential Fat';

  @override
  String get bodyFatCategoryAthletic => 'Athletic';

  @override
  String get bodyFatCategoryFitness => 'Fitness';

  @override
  String get bodyFatCategoryAverage => 'Average';

  @override
  String get bodyFatCategoryHigh => 'High';

  @override
  String get measurementsAddButton => 'Add Measurement';

  @override
  String get measurementsEmptyTitle => 'No measurements yet';

  @override
  String get measurementsEmptyMessage =>
      'Add your first measurement to start tracking.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Add Measurement';

  @override
  String measurementsFieldHint(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get commonSave => 'Save';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String profileLoadError(String error) {
    return 'Couldn\'t load profile: $error';
  }

  @override
  String get profileEmptyTitle => 'No profile yet';

  @override
  String get profileEmptyMessage =>
      'Complete onboarding to build your profile.';

  @override
  String get bioAge => 'Age';

  @override
  String get bioHeight => 'Height';

  @override
  String get bioWeight => 'Weight';

  @override
  String get bioLevel => 'Level';

  @override
  String get profileGoalsTile => 'Goals';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get goalsEmptyTitle => 'No goals set';

  @override
  String get goalsEmptyMessage => 'Complete onboarding to set your goals.';

  @override
  String get goalsCurrentLabel => 'Current';

  @override
  String get goalsTargetLabel => 'Target';

  @override
  String get goalsRemainingLabel => 'Remaining';

  @override
  String get goalsWeeklyWorkoutLabel => 'WEEKLY WORKOUT GOAL';

  @override
  String get goalsDailyCalorieLabel => 'DAILY CALORIE GOAL';

  @override
  String get goalsProteinLabel => 'PROTEIN GOAL';

  @override
  String get settingsWorkoutSection => 'Workout Settings';

  @override
  String get settingsDefaultRestTime => 'Default Rest Time';

  @override
  String get settingsAutoStartNextSet => 'Auto-start Next Set';

  @override
  String get settingsWeightUnit => 'Weight Unit';

  @override
  String get settingsDistanceUnit => 'Distance Unit';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsHaptics => 'Haptics';

  @override
  String get settingsCountdownBeep => 'Countdown Beep (3-2-1)';

  @override
  String get settingsNutritionSection => 'Nutrition Settings';

  @override
  String get settingsAutoCalculateTargets => 'Auto-calculate targets (TDEE)';

  @override
  String get settingsFoodDatabase => 'Food Database';

  @override
  String get settingsFoodDbGlobal => 'Global (All)';

  @override
  String get settingsFoodDbTurkey => 'Turkey';

  @override
  String get settingsFoodDbGermany => 'Germany';

  @override
  String get settingsFoodDbUK => 'United Kingdom';

  @override
  String get settingsFoodDbUS => 'United States';

  @override
  String get settingsFoodDbFrance => 'France';

  @override
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat) {
    return 'Manual macro editing: Calories $calories · Protein ${protein}g · Carbs ${carbs}g · Fat ${fat}g';
  }

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsEnableNotifications => 'Enable Notifications';

  @override
  String get settingsAppearanceSection => 'Appearance & Language';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsAccountSection => 'Account & Support';

  @override
  String get muscleGroupChest => 'Chest';

  @override
  String get muscleGroupBack => 'Back';

  @override
  String get muscleGroupShoulders => 'Shoulders';

  @override
  String get muscleGroupBiceps => 'Biceps';

  @override
  String get muscleGroupTriceps => 'Triceps';

  @override
  String get muscleGroupLegs => 'Legs';

  @override
  String get muscleGroupGlutes => 'Glutes';

  @override
  String get muscleGroupCore => 'Core';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Full Body';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Remove ads and unlock AI coaching.';

  @override
  String get paywallFeatureNoAds => 'No ads';

  @override
  String get paywallFeatureAiWorkouts => 'AI-generated workout plans';

  @override
  String get paywallFeatureAiMeals => 'AI meal-text logging';

  @override
  String get paywallSubscribeButton => 'Subscribe';

  @override
  String get paywallRestoreButton => 'Restore Purchases';

  @override
  String get paywallUnavailable =>
      'Subscriptions aren\'t available yet — check back soon.';

  @override
  String get paywallAlreadySubscribed => 'You\'re already Premium. Thank you!';

  @override
  String get paywallPurchaseFailed =>
      'Purchase couldn\'t be completed. Please try again.';

  @override
  String get paywallRestoreSuccess => 'Purchases restored.';

  @override
  String get paywallRestoreNone =>
      'No previous purchases found for this account.';

  @override
  String get settingsSendFeedback => 'Send Feedback';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Delete your account?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'This permanently deletes your account and all your data — workouts, nutrition logs, progress, everything. This cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Delete Permanently';

  @override
  String get settingsDeleteAccountFailed =>
      'Couldn\'t delete your account. Please try again.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '${seconds}s';
  }

  @override
  String get mealCardNoItems => 'No items logged yet';

  @override
  String get mealCardAddFood => 'Add Food';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes min • $count exercises';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets Sets × $reps Reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Last: $value';
  }

  @override
  String get restTimerLabel => 'REST';

  @override
  String get restTimerSubtract => '-15s';

  @override
  String get restTimerSkip => 'Skip Rest';

  @override
  String get restTimerAdd => '+30s';

  @override
  String get splashTagline => 'Train smarter. Get stronger.';

  @override
  String get lineChartNoData => 'No data yet';

  @override
  String get weightLogButton => 'Log Weight';

  @override
  String get weightFieldHint => 'Weight';

  @override
  String get navHome => 'Home';

  @override
  String get navWorkouts => 'Workouts';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';
}
