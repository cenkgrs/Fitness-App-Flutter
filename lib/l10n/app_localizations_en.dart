// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Repwise';

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
}
