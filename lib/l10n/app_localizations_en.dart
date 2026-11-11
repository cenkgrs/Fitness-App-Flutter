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
  String get authSignUpTitle => 'Create account';

  @override
  String get authSignInTitle => 'Welcome back';

  @override
  String get authSignUpSubtitle =>
      'Create an account and we\'ll set up your plan together.';

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
  String get authSignUpButton => 'Sign up';

  @override
  String get authSignInButton => 'Sign in';

  @override
  String get authSwitchToSignIn => 'Already have an account? Sign in';

  @override
  String get authSwitchToSignUp => 'New here? Create an account';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authResetPasswordTitle => 'Reset password';

  @override
  String get authResetPasswordMessage =>
      'Enter your email and we\'ll send you a reset link.';

  @override
  String get authResetPasswordSend => 'Send reset link';

  @override
  String get authResetPasswordSent =>
      'If that email exists, a reset link has been sent.';

  @override
  String get authResetPasswordFailed =>
      'Couldn\'t send the reset link. Please try again.';

  @override
  String get authNewPasswordTitle => 'Set a new password';

  @override
  String get authNewPasswordHint => 'New password';

  @override
  String get authNewPasswordButton => 'Update password';

  @override
  String get authNewPasswordSuccess => 'Password updated.';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingWelcomeHeadline => 'Training and food, in one plan.';

  @override
  String get onboardingWelcomeSubtitle =>
      'A few quick questions, then we\'ll build a program and calorie target that fit you.';

  @override
  String get onboardingGetStarted => 'Get started';

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
  String get goalLoseWeight => 'Lose weight';

  @override
  String get goalBuildMuscle => 'Build muscle';

  @override
  String get goalLoseFat => 'Lose fat';

  @override
  String get goalMaintainFitness => 'Stay fit';

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
  String get activityModeratelyActiveLabel => 'Moderately active';

  @override
  String get activityModeratelyActiveSubtitle => '~7,500 steps/day';

  @override
  String get activityVeryActiveLabel => 'Very active';

  @override
  String get activityVeryActiveSubtitle => '10,000+ steps/day, physical job';

  @override
  String get onboardingNutritionPrefTitle =>
      'What\'s your nutrition preference?';

  @override
  String get nutritionStandard => 'Standard';

  @override
  String get nutritionHighProtein => 'High protein';

  @override
  String get nutritionKeto => 'Ketogenic';

  @override
  String get nutritionVegetarian => 'Vegetarian';

  @override
  String get nutritionVegan => 'Vegan';

  @override
  String get onboardingCalculatingLine1 => 'Working out your calorie needs…';

  @override
  String get onboardingCalculatingLine2 =>
      'Putting your weekly program together…';

  @override
  String onboardingPlanReadyTitle(String name) {
    return '$name, your plan is ready';
  }

  @override
  String get onboardingDefaultName => 'Athlete';

  @override
  String get onboardingDailyCalories => 'Daily calories';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Carbs';

  @override
  String get macroFat => 'Fat';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return '$days days a week';
  }

  @override
  String get onboardingPlanTagline => 'Strength and body composition';

  @override
  String get onboardingStartMyPlan => 'Start my plan';

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String get homeDefaultAthleteName => 'Athlete';

  @override
  String homeCaloriesLeft(int count) {
    return '$count left';
  }

  @override
  String get homeTodaysWorkoutLabel => 'TODAY\'S WORKOUT';

  @override
  String get homeRestDayMessage => 'Rest day. Recovery is part of the plan.';

  @override
  String get homeNoWorkoutPlanned => 'No workout planned yet.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '$minutes min · $count exercises';
  }

  @override
  String get homeStartWorkout => 'Start workout';

  @override
  String get homeWeightGoalLabel => 'WEIGHT GOAL';

  @override
  String homeWeightRemaining(String kg) {
    return '$kg kg to go';
  }

  @override
  String get homeQuickActionAddMeal => 'Add meal';

  @override
  String get homeQuickActionLogWeight => 'Log weight';

  @override
  String get homeQuickActionViewProgress => 'Progress';

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
  String get workoutsScreenTitle => 'This week';

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
      'Finish setup to generate your weekly program.';

  @override
  String get workoutsCreateMyPlan => 'Create my plan';

  @override
  String get activeWorkoutNoExercises => 'No exercises for this day.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return 'Exercise $current of $total';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'Set $current of $total';
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
  String get activeWorkoutSkipExercise => 'Skip exercise';

  @override
  String get activeWorkoutAddSet => 'Add set';

  @override
  String get activeWorkoutCompleteSet => 'Complete set';

  @override
  String get activeWorkoutEndTitle => 'End workout?';

  @override
  String get activeWorkoutEndContent =>
      'Your progress on this session will be lost.';

  @override
  String get activeWorkoutEndConfirm => 'End workout';

  @override
  String get workoutDetailNotFound => 'Workout not found';

  @override
  String get workoutDetailStartButton => 'Start workout';

  @override
  String get workoutSummarySessionNotFound => 'Session not found';

  @override
  String get workoutSummaryComplete => 'Workout complete';

  @override
  String get workoutSummaryDuration => 'Duration';

  @override
  String get workoutSummaryTotalVolume => 'Total volume';

  @override
  String get workoutSummarySetsCompleted => 'Sets completed';

  @override
  String get workoutSummaryEstCalories => 'Est. calories';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'New PR: $weight kg × $reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Good session. Every set you log makes next week\'s plan more accurate.';

  @override
  String get workoutSummaryFinish => 'Done';

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
  String get foodLoggerQuickAddTab => 'Quick add';

  @override
  String get foodLoggerSearchHint => 'Search for food or brand...';

  @override
  String get barcodeScannerTitle => 'Scan barcode';

  @override
  String get barcodeScannerHint => 'Point the camera at a product barcode';

  @override
  String get barcodeScannerNotFound => 'No product found for that barcode.';

  @override
  String get aiChatTitle => 'AI Coach';

  @override
  String get aiChatInputHint => 'Ask about training, food or recovery';

  @override
  String get aiChatEmptyState =>
      'Ask me anything about training, nutrition, or recovery.';

  @override
  String aiChatRemainingToday(int count) {
    return '$count messages left today';
  }

  @override
  String get aiChatLimitReached =>
      'That\'s today\'s message limit. It resets tomorrow.';

  @override
  String get healthConnectPrompt =>
      'Connect Apple Health or Health Connect to see steps and calories burned';

  @override
  String get healthStepsLabel => 'Steps';

  @override
  String get healthCaloriesBurnedLabel => 'Active kcal';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total unlocked';
  }

  @override
  String get achievementFirstWorkoutTitle => 'First Step';

  @override
  String get achievementFirstWorkoutDesc => 'Complete your first workout';

  @override
  String get achievementWorkout5Title => 'Getting Started';

  @override
  String get achievementWorkout5Desc => 'Complete 5 workouts';

  @override
  String get achievementWorkout25Title => 'Committed';

  @override
  String get achievementWorkout25Desc => 'Complete 25 workouts';

  @override
  String get achievementWorkout100Title => 'Century Club';

  @override
  String get achievementWorkout100Desc => 'Complete 100 workouts';

  @override
  String get achievementFirstPrTitle => 'New Record';

  @override
  String get achievementFirstPrDesc => 'Hit your first personal record';

  @override
  String get achievementStreak3Title => 'On a Roll';

  @override
  String get achievementStreak3Desc => '3-day workout streak';

  @override
  String get achievementStreak7Title => 'One Week Strong';

  @override
  String get achievementStreak7Desc => '7-day workout streak';

  @override
  String get achievementStreak30Title => 'Unstoppable';

  @override
  String get achievementStreak30Desc => '30-day workout streak';

  @override
  String get achievementWeightLogged5Title => 'Tracking It';

  @override
  String get achievementWeightLogged5Desc => 'Log your weight 5 times';

  @override
  String get achievementWeightLogged30Title => 'Data Driven';

  @override
  String get achievementWeightLogged30Desc => 'Log your weight 30 times';

  @override
  String get waterCardTitle => 'Water';

  @override
  String waterCardAmount(int consumed, int goal) {
    return '$consumed/$goal ml';
  }

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
  String get quickAddEntryDefaultName => 'Quick add';

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
      'Finish a workout to start tracking your estimated 1RM.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise';
  }

  @override
  String get progressCurrentStreak => 'Current streak';

  @override
  String get progressLongestStreak => 'Longest streak';

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
    return 'Body fat · $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Essential fat';

  @override
  String get bodyFatCategoryAthletic => 'Athletic';

  @override
  String get bodyFatCategoryFitness => 'Fitness';

  @override
  String get bodyFatCategoryAverage => 'Average';

  @override
  String get bodyFatCategoryHigh => 'High';

  @override
  String get measurementsAddButton => 'Add measurement';

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
  String get measurementsSheetTitle => 'Add measurement';

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
  String get profileEmptyMessage => 'Finish setup to build your profile.';

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
  String get profileSignOut => 'Sign out';

  @override
  String get goalsEmptyTitle => 'No goals set';

  @override
  String get goalsEmptyMessage => 'Finish setup to set your goals.';

  @override
  String get goalsCurrentLabel => 'Current';

  @override
  String get goalsTargetLabel => 'Target';

  @override
  String get goalsRemainingLabel => 'Remaining';

  @override
  String get goalsWeeklyWorkoutLabel => 'WEEKLY WORKOUTS';

  @override
  String get goalsDailyCalorieLabel => 'DAILY CALORIES';

  @override
  String get goalsProteinLabel => 'DAILY PROTEIN';

  @override
  String get settingsWorkoutSection => 'Workout';

  @override
  String get settingsDefaultRestTime => 'Default rest time';

  @override
  String get settingsAutoStartNextSet => 'Auto-start next set';

  @override
  String get settingsWeightUnit => 'Weight unit';

  @override
  String get settingsDistanceUnit => 'Distance unit';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsHaptics => 'Haptics';

  @override
  String get settingsCountdownBeep => 'Countdown beep (3-2-1)';

  @override
  String get settingsNutritionSection => 'Nutrition';

  @override
  String get settingsAutoCalculateTargets => 'Auto-calculate targets (TDEE)';

  @override
  String get settingsFoodDatabase => 'Food database';

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
  String get settingsEnableNotifications => 'Reminders';

  @override
  String get settingsAppearanceSection => 'Language';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsAccountSection => 'Account & support';

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
  String get muscleGroupFullBody => 'Full body';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'No ads, plus the AI coach.';

  @override
  String get paywallFeatureNoAds => 'No ads';

  @override
  String get paywallFeatureAiWorkouts => 'AI-built workout programs';

  @override
  String get paywallFeatureAiMeals => 'Log meals by typing them out';

  @override
  String get paywallSubscribeButton => 'Subscribe';

  @override
  String get paywallRestoreButton => 'Restore purchases';

  @override
  String get paywallUnavailable => 'Subscriptions aren\'t available yet.';

  @override
  String get paywallAlreadySubscribed =>
      'You\'re on Premium. Thanks for the support.';

  @override
  String get paywallPurchaseFailed =>
      'Purchase couldn\'t be completed. Please try again.';

  @override
  String get paywallRestoreSuccess => 'Purchases restored.';

  @override
  String get paywallRestoreNone =>
      'No previous purchases found for this account.';

  @override
  String get settingsSendFeedback => 'Send feedback';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsDeleteAccount => 'Delete account';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Delete your account?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'This permanently deletes your account and all your data — workouts, nutrition logs, progress, everything. This cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Delete permanently';

  @override
  String get settingsDeleteAccountFailed =>
      'Couldn\'t delete your account. Please try again.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '${seconds}s';
  }

  @override
  String get mealCardNoItems => 'Nothing logged yet';

  @override
  String get mealCardAddFood => 'Add food';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes min · $count exercises';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets × $reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Last: $value';
  }

  @override
  String get restTimerLabel => 'Rest';

  @override
  String get restTimerSubtract => '-15s';

  @override
  String get restTimerSkip => 'Skip rest';

  @override
  String get restTimerAdd => '+30s';

  @override
  String get splashTagline => 'Training, food and progress in one place.';

  @override
  String get lineChartNoData => 'No data yet';

  @override
  String get weightLogButton => 'Log weight';

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

  @override
  String get weekdayInitials => 'M,T,W,T,F,S,S';

  @override
  String get streakLabel => 'day streak';

  @override
  String get authErrorInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirm your email first. Check your inbox.';

  @override
  String get authErrorUserExists =>
      'There\'s already an account with this email. Try signing in.';

  @override
  String get authErrorWeakPassword =>
      'That password is too weak. Use at least 6 characters.';

  @override
  String get authErrorInvalidEmail => 'That email address doesn\'t look right.';

  @override
  String get authErrorRateLimited =>
      'Too many attempts. Wait a minute and try again.';

  @override
  String get authErrorNetwork =>
      'No connection. Check your internet and try again.';

  @override
  String get authErrorGeneric => 'Couldn\'t sign you in. Please try again.';

  @override
  String get authErrorMissingFields => 'Enter your email and password.';

  @override
  String get authConfirmEmailSent =>
      'We sent a confirmation link to your email. Open it to finish signing up.';

  @override
  String get notifWorkoutTitle => 'Today\'s workout is waiting';

  @override
  String get notifWorkoutBody => 'No workout logged yet today. Got 20 minutes?';

  @override
  String get notifMealTitle => 'Log your meal';

  @override
  String get notifLunchBody =>
      'Lunch time. Add what you ate while you remember it.';

  @override
  String get notifDinnerBody =>
      'Dinner time. Add what you ate while you remember it.';

  @override
  String get dayFullBodyA => 'Full Body A';

  @override
  String get dayFullBodyB => 'Full Body B';

  @override
  String get dayFullBodyC => 'Full Body C';

  @override
  String get dayFullBody => 'Full Body';

  @override
  String get dayUpperBodyPower => 'Upper Body · Strength';

  @override
  String get dayUpperBodyHypertrophy => 'Upper Body · Volume';

  @override
  String get dayUpperBody => 'Upper Body';

  @override
  String get dayLowerBodyFocus => 'Lower Body · Strength';

  @override
  String get dayLowerBody => 'Lower Body';

  @override
  String get dayPush => 'Push';

  @override
  String get dayPull => 'Pull';

  @override
  String get dayLegsCore => 'Legs & Core';

  @override
  String get dayActiveRecovery => 'Active recovery';

  @override
  String get dayRest => 'Rest';

  @override
  String get programFullBody => 'Full Body Program';

  @override
  String get programUpperLower => 'Upper/Lower Split';

  @override
  String get exBenchPress => 'Bench Press';

  @override
  String get exInclineDumbbellPress => 'Incline Dumbbell Press';

  @override
  String get exOverheadPress => 'Overhead Press';

  @override
  String get exTricepsPushdown => 'Triceps Pushdown';

  @override
  String get exLateralRaise => 'Lateral Raise';

  @override
  String get exDeadlift => 'Deadlift';

  @override
  String get exPullUp => 'Pull-Up';

  @override
  String get exBarbellRow => 'Barbell Row';

  @override
  String get exFacePull => 'Face Pull';

  @override
  String get exBicepCurl => 'Biceps Curl';

  @override
  String get exBackSquat => 'Back Squat';

  @override
  String get exRomanianDeadlift => 'Romanian Deadlift';

  @override
  String get exLegPress => 'Leg Press';

  @override
  String get exWalkingLunge => 'Walking Lunge';

  @override
  String get exPlank => 'Plank';

  @override
  String get exGobletSquat => 'Goblet Squat';

  @override
  String get exPushUp => 'Push-Up';

  @override
  String get exDumbbellRow => 'Dumbbell Row';
}
