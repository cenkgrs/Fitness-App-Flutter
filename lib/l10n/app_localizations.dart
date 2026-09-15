import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'THRIVE+'**
  String get appTitle;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// No description provided for @authSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authSignUpTitle;

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authSignInTitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account first, then we\'ll build your personalized plan together.'**
  String get authSignUpSubtitle;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in and pick up where you left off.'**
  String get authSignInSubtitle;

  /// No description provided for @authContinueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authContinueWithApple;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// No description provided for @authOrWithEmail.
  ///
  /// In en, this message translates to:
  /// **'or with email'**
  String get authOrWithEmail;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailHint;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordHint;

  /// No description provided for @authSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUpButton;

  /// No description provided for @authSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignInButton;

  /// No description provided for @authSwitchToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get authSwitchToSignIn;

  /// No description provided for @authSwitchToSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get authSwitchToSignUp;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authResetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get authResetPasswordTitle;

  /// No description provided for @authResetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a reset link.'**
  String get authResetPasswordMessage;

  /// No description provided for @authResetPasswordSend.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get authResetPasswordSend;

  /// No description provided for @authResetPasswordSent.
  ///
  /// In en, this message translates to:
  /// **'If that email exists, a reset link has been sent.'**
  String get authResetPasswordSent;

  /// No description provided for @authResetPasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t send the reset link. Please try again.'**
  String get authResetPasswordFailed;

  /// No description provided for @authNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a New Password'**
  String get authNewPasswordTitle;

  /// No description provided for @authNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authNewPasswordHint;

  /// No description provided for @authNewPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get authNewPasswordButton;

  /// No description provided for @authNewPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated. You\'re all set.'**
  String get authNewPasswordSuccess;

  /// No description provided for @authErrorSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {error}'**
  String authErrorSnackbar(String error);

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingWelcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Reach your peak physique'**
  String get onboardingWelcomeHeadline;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll ask a few questions to build your personalized workout and nutrition plan.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboardingNameTitle;

  /// No description provided for @onboardingNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onboardingNameHint;

  /// No description provided for @onboardingGenderTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your gender?'**
  String get onboardingGenderTitle;

  /// No description provided for @onboardingGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get onboardingGenderMale;

  /// No description provided for @onboardingGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get onboardingGenderFemale;

  /// No description provided for @onboardingGenderUnspecified.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get onboardingGenderUnspecified;

  /// No description provided for @onboardingAgeTitle.
  ///
  /// In en, this message translates to:
  /// **'How old are you?'**
  String get onboardingAgeTitle;

  /// No description provided for @onboardingHeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Your height (cm)'**
  String get onboardingHeightTitle;

  /// No description provided for @onboardingWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Your weight (kg)'**
  String get onboardingWeightTitle;

  /// No description provided for @onboardingTargetWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Target weight (kg)'**
  String get onboardingTargetWeightTitle;

  /// No description provided for @onboardingFitnessLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your fitness level?'**
  String get onboardingFitnessLevelTitle;

  /// No description provided for @fitnessBeginnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get fitnessBeginnerLabel;

  /// No description provided for @fitnessBeginnerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learning basic form (0-1 year)'**
  String get fitnessBeginnerSubtitle;

  /// No description provided for @fitnessIntermediateLabel.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get fitnessIntermediateLabel;

  /// No description provided for @fitnessIntermediateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Training consistently (1-3 years)'**
  String get fitnessIntermediateSubtitle;

  /// No description provided for @fitnessAdvancedLabel.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get fitnessAdvancedLabel;

  /// No description provided for @fitnessAdvancedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Heavy training & periodization (3+ years)'**
  String get fitnessAdvancedSubtitle;

  /// No description provided for @onboardingPrimaryGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your main goal?'**
  String get onboardingPrimaryGoalTitle;

  /// No description provided for @goalLoseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get goalLoseWeight;

  /// No description provided for @goalBuildMuscle.
  ///
  /// In en, this message translates to:
  /// **'Build Muscle'**
  String get goalBuildMuscle;

  /// No description provided for @goalLoseFat.
  ///
  /// In en, this message translates to:
  /// **'Lose Fat'**
  String get goalLoseFat;

  /// No description provided for @goalMaintainFitness.
  ///
  /// In en, this message translates to:
  /// **'Maintain Fitness'**
  String get goalMaintainFitness;

  /// No description provided for @onboardingDaysPerWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'How many days a week do you want to train?'**
  String get onboardingDaysPerWeekTitle;

  /// No description provided for @onboardingMostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get onboardingMostPopular;

  /// No description provided for @onboardingDurationTitle.
  ///
  /// In en, this message translates to:
  /// **'How long should your workouts be?'**
  String get onboardingDurationTitle;

  /// No description provided for @onboardingDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String onboardingDurationMinutes(int minutes);

  /// No description provided for @onboardingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Where do you train?'**
  String get onboardingLocationTitle;

  /// No description provided for @locationGym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get locationGym;

  /// No description provided for @locationHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get locationHome;

  /// No description provided for @locationBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get locationBoth;

  /// No description provided for @onboardingEquipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get onboardingEquipmentLabel;

  /// No description provided for @onboardingActivityLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your daily activity level?'**
  String get onboardingActivityLevelTitle;

  /// No description provided for @activitySedentaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get activitySedentaryLabel;

  /// No description provided for @activitySedentarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Desk job, little movement'**
  String get activitySedentarySubtitle;

  /// No description provided for @activityModeratelyActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Moderately Active'**
  String get activityModeratelyActiveLabel;

  /// No description provided for @activityModeratelyActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'~7,500 steps/day'**
  String get activityModeratelyActiveSubtitle;

  /// No description provided for @activityVeryActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get activityVeryActiveLabel;

  /// No description provided for @activityVeryActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'10,000+ steps/day, physical job'**
  String get activityVeryActiveSubtitle;

  /// No description provided for @onboardingNutritionPrefTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your nutrition preference?'**
  String get onboardingNutritionPrefTitle;

  /// No description provided for @nutritionStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get nutritionStandard;

  /// No description provided for @nutritionHighProtein.
  ///
  /// In en, this message translates to:
  /// **'High Protein'**
  String get nutritionHighProtein;

  /// No description provided for @nutritionKeto.
  ///
  /// In en, this message translates to:
  /// **'Ketogenic'**
  String get nutritionKeto;

  /// No description provided for @nutritionVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get nutritionVegetarian;

  /// No description provided for @nutritionVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get nutritionVegan;

  /// No description provided for @onboardingCalculatingLine1.
  ///
  /// In en, this message translates to:
  /// **'Calculating your metabolic rate...'**
  String get onboardingCalculatingLine1;

  /// No description provided for @onboardingCalculatingLine2.
  ///
  /// In en, this message translates to:
  /// **'Optimizing your hypertrophy volume...'**
  String get onboardingCalculatingLine2;

  /// No description provided for @onboardingPlanReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Plan Is Ready, {name}!'**
  String onboardingPlanReadyTitle(String name);

  /// No description provided for @onboardingDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Champion'**
  String get onboardingDefaultName;

  /// No description provided for @onboardingDailyCalories.
  ///
  /// In en, this message translates to:
  /// **'Daily Calories'**
  String get onboardingDailyCalories;

  /// No description provided for @macroProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get macroProtein;

  /// No description provided for @macroCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get macroCarbs;

  /// No description provided for @macroFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get macroFat;

  /// No description provided for @onboardingDaysPerWeekProgram.
  ///
  /// In en, this message translates to:
  /// **'{days} Days / Week Program'**
  String onboardingDaysPerWeekProgram(int days);

  /// No description provided for @onboardingPlanTagline.
  ///
  /// In en, this message translates to:
  /// **'Muscle Hypertrophy & Fat Loss'**
  String get onboardingPlanTagline;

  /// No description provided for @onboardingStartMyPlan.
  ///
  /// In en, this message translates to:
  /// **'Start My Plan'**
  String get onboardingStartMyPlan;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGreetingEvening;

  /// No description provided for @homeDefaultAthleteName.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get homeDefaultAthleteName;

  /// No description provided for @homeReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to get stronger?'**
  String get homeReadySubtitle;

  /// No description provided for @homeCaloriesLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String homeCaloriesLeft(int count);

  /// No description provided for @homeTodaysWorkoutLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S WORKOUT'**
  String get homeTodaysWorkoutLabel;

  /// No description provided for @homeRestDayMessage.
  ///
  /// In en, this message translates to:
  /// **'Rest day today. 🧘'**
  String get homeRestDayMessage;

  /// No description provided for @homeNoWorkoutPlanned.
  ///
  /// In en, this message translates to:
  /// **'No workout planned yet.'**
  String get homeNoWorkoutPlanned;

  /// No description provided for @homeWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'⏱ {minutes} min • 🏋️ {count} exercises'**
  String homeWorkoutSummary(int minutes, int count);

  /// No description provided for @homeStartWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start Workout'**
  String get homeStartWorkout;

  /// No description provided for @homeWeightGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT GOAL'**
  String get homeWeightGoalLabel;

  /// No description provided for @homeWeightRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {kg} kg'**
  String homeWeightRemaining(String kg);

  /// No description provided for @homeQuickActionAddMeal.
  ///
  /// In en, this message translates to:
  /// **'Add Meal'**
  String get homeQuickActionAddMeal;

  /// No description provided for @homeQuickActionLogWeight.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get homeQuickActionLogWeight;

  /// No description provided for @homeQuickActionViewProgress.
  ///
  /// In en, this message translates to:
  /// **'View Progress'**
  String get homeQuickActionViewProgress;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericError(String error);

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @weekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySaturday;

  /// No description provided for @weekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySunday;

  /// No description provided for @workoutsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Routine'**
  String get workoutsScreenTitle;

  /// No description provided for @workoutsAiUpdateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Update with AI'**
  String get workoutsAiUpdateTooltip;

  /// No description provided for @workoutsAiUpdateFailedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'AI couldn\'t update the program: {error}'**
  String workoutsAiUpdateFailedSnackbar(String error);

  /// No description provided for @workoutsFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load program: {error}'**
  String workoutsFailedToLoad(String error);

  /// No description provided for @workoutsOnboardingCta.
  ///
  /// In en, this message translates to:
  /// **'Complete onboarding to generate your personalized routine.'**
  String get workoutsOnboardingCta;

  /// No description provided for @workoutsCreateMyPlan.
  ///
  /// In en, this message translates to:
  /// **'Create My Plan'**
  String get workoutsCreateMyPlan;

  /// No description provided for @activeWorkoutNoExercises.
  ///
  /// In en, this message translates to:
  /// **'No exercises for this day.'**
  String get activeWorkoutNoExercises;

  /// No description provided for @activeWorkoutExerciseCounter.
  ///
  /// In en, this message translates to:
  /// **'Exercise {current} of {total}'**
  String activeWorkoutExerciseCounter(int current, int total);

  /// No description provided for @activeWorkoutSetCounter.
  ///
  /// In en, this message translates to:
  /// **'SET {current} OF {total}'**
  String activeWorkoutSetCounter(int current, int total);

  /// No description provided for @activeWorkoutTarget.
  ///
  /// In en, this message translates to:
  /// **'Target: {weight} kg × {reps} reps'**
  String activeWorkoutTarget(String weight, String reps);

  /// No description provided for @activeWorkoutWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT (KG)'**
  String get activeWorkoutWeightLabel;

  /// No description provided for @activeWorkoutRepsLabel.
  ///
  /// In en, this message translates to:
  /// **'REPS'**
  String get activeWorkoutRepsLabel;

  /// No description provided for @activeWorkoutSkipExercise.
  ///
  /// In en, this message translates to:
  /// **'Skip Exercise'**
  String get activeWorkoutSkipExercise;

  /// No description provided for @activeWorkoutAddSet.
  ///
  /// In en, this message translates to:
  /// **'Add Set'**
  String get activeWorkoutAddSet;

  /// No description provided for @activeWorkoutCompleteSet.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE SET'**
  String get activeWorkoutCompleteSet;

  /// No description provided for @activeWorkoutEndTitle.
  ///
  /// In en, this message translates to:
  /// **'End workout?'**
  String get activeWorkoutEndTitle;

  /// No description provided for @activeWorkoutEndContent.
  ///
  /// In en, this message translates to:
  /// **'Your progress on this session will be lost.'**
  String get activeWorkoutEndContent;

  /// No description provided for @activeWorkoutEndConfirm.
  ///
  /// In en, this message translates to:
  /// **'End Workout'**
  String get activeWorkoutEndConfirm;

  /// No description provided for @workoutDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Workout not found'**
  String get workoutDetailNotFound;

  /// No description provided for @workoutDetailStartButton.
  ///
  /// In en, this message translates to:
  /// **'START WORKOUT'**
  String get workoutDetailStartButton;

  /// No description provided for @workoutSummarySessionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Session not found'**
  String get workoutSummarySessionNotFound;

  /// No description provided for @workoutSummaryComplete.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT COMPLETE 🎉'**
  String get workoutSummaryComplete;

  /// No description provided for @workoutSummaryDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get workoutSummaryDuration;

  /// No description provided for @workoutSummaryTotalVolume.
  ///
  /// In en, this message translates to:
  /// **'Total Volume'**
  String get workoutSummaryTotalVolume;

  /// No description provided for @workoutSummarySetsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Sets Completed'**
  String get workoutSummarySetsCompleted;

  /// No description provided for @workoutSummaryEstCalories.
  ///
  /// In en, this message translates to:
  /// **'Est. Calories'**
  String get workoutSummaryEstCalories;

  /// No description provided for @workoutSummaryNewPr.
  ///
  /// In en, this message translates to:
  /// **'NEW PR! {weight} kg × {reps} reps'**
  String workoutSummaryNewPr(String weight, String reps);

  /// No description provided for @workoutSummaryEncouragement.
  ///
  /// In en, this message translates to:
  /// **'Great work! Your muscles are getting stronger and you\'re one step closer to your goal.'**
  String get workoutSummaryEncouragement;

  /// No description provided for @workoutSummaryFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish & Return Home'**
  String get workoutSummaryFinish;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @nutritionToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get nutritionToday;

  /// No description provided for @nutritionCaloriesProgress.
  ///
  /// In en, this message translates to:
  /// **'{consumed} / {goal} kcal'**
  String nutritionCaloriesProgress(int consumed, int goal);

  /// No description provided for @mealTypeBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealTypeBreakfast;

  /// No description provided for @mealTypeLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealTypeLunch;

  /// No description provided for @mealTypeDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealTypeDinner;

  /// No description provided for @mealTypeSnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get mealTypeSnack;

  /// No description provided for @foodLoggerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to {mealType}'**
  String foodLoggerTitle(String mealType);

  /// No description provided for @foodLoggerSearchTab.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get foodLoggerSearchTab;

  /// No description provided for @foodLoggerQuickAddTab.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get foodLoggerQuickAddTab;

  /// No description provided for @foodLoggerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for food or brand...'**
  String get foodLoggerSearchHint;

  /// No description provided for @barcodeScannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get barcodeScannerTitle;

  /// No description provided for @barcodeScannerHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a product barcode'**
  String get barcodeScannerHint;

  /// No description provided for @barcodeScannerNotFound.
  ///
  /// In en, this message translates to:
  /// **'No product found for that barcode.'**
  String get barcodeScannerNotFound;

  /// No description provided for @foodLoggerNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get foodLoggerNoResultsTitle;

  /// No description provided for @foodLoggerNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term.'**
  String get foodLoggerNoResultsMessage;

  /// No description provided for @foodLoggerNutritionSummary.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal / 100g • P:{protein}g C:{carbs}g F:{fat}g'**
  String foodLoggerNutritionSummary(
      String kcal, String protein, String carbs, String fat);

  /// No description provided for @foodLoggerQuantitySummary.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal — P: {protein}g, C: {carbs}g, F: {fat}g'**
  String foodLoggerQuantitySummary(
      String kcal, String protein, String carbs, String fat);

  /// No description provided for @foodLoggerAiHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 3 eggs, 100g rice, a handful of almonds'**
  String get foodLoggerAiHint;

  /// No description provided for @foodLoggerAiFillButton.
  ///
  /// In en, this message translates to:
  /// **'Fill with AI'**
  String get foodLoggerAiFillButton;

  /// No description provided for @foodLoggerAiParsing.
  ///
  /// In en, this message translates to:
  /// **'Parsing...'**
  String get foodLoggerAiParsing;

  /// No description provided for @foodLoggerOrManualEntry.
  ///
  /// In en, this message translates to:
  /// **'or enter manually'**
  String get foodLoggerOrManualEntry;

  /// No description provided for @foodLoggerAiParseFailedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'AI couldn\'t parse the meal: {error}'**
  String foodLoggerAiParseFailedSnackbar(String error);

  /// No description provided for @quickAddCaloriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get quickAddCaloriesLabel;

  /// No description provided for @quickAddProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein (g)'**
  String get quickAddProteinLabel;

  /// No description provided for @quickAddCarbsLabel.
  ///
  /// In en, this message translates to:
  /// **'Carbs (g)'**
  String get quickAddCarbsLabel;

  /// No description provided for @quickAddFatLabel.
  ///
  /// In en, this message translates to:
  /// **'Fat (g)'**
  String get quickAddFatLabel;

  /// No description provided for @quickAddEntryDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAddEntryDefaultName;

  /// No description provided for @progressScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressScreenTitle;

  /// No description provided for @progressTabWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get progressTabWeight;

  /// No description provided for @progressTabStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get progressTabStrength;

  /// No description provided for @progressTabConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get progressTabConsistency;

  /// No description provided for @progressTabMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Measurements'**
  String get progressTabMeasurements;

  /// No description provided for @progressWeightChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get progressWeightChartTitle;

  /// No description provided for @progressStrengthEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No strength data yet'**
  String get progressStrengthEmptyTitle;

  /// No description provided for @progressStrengthEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete a workout to start tracking your 1RM progression.'**
  String get progressStrengthEmptyMessage;

  /// No description provided for @progressStrengthChartTitle.
  ///
  /// In en, this message translates to:
  /// **'{exercise} Progression'**
  String progressStrengthChartTitle(String exercise);

  /// No description provided for @progressCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get progressCurrentStreak;

  /// No description provided for @progressLongestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get progressLongestStreak;

  /// No description provided for @progressConsistencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get progressConsistencyLabel;

  /// No description provided for @measurementWaist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get measurementWaist;

  /// No description provided for @measurementNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get measurementNeck;

  /// No description provided for @measurementHip.
  ///
  /// In en, this message translates to:
  /// **'Hip'**
  String get measurementHip;

  /// No description provided for @measurementChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get measurementChest;

  /// No description provided for @measurementBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get measurementBiceps;

  /// No description provided for @measurementThigh.
  ///
  /// In en, this message translates to:
  /// **'Thigh'**
  String get measurementThigh;

  /// No description provided for @measurementsBodyFatHint.
  ///
  /// In en, this message translates to:
  /// **'Add your waist and neck measurements to see your body fat percentage.'**
  String get measurementsBodyFatHint;

  /// No description provided for @measurementsBodyFatLabel.
  ///
  /// In en, this message translates to:
  /// **'Body Fat — {category}'**
  String measurementsBodyFatLabel(String category);

  /// No description provided for @bodyFatCategoryEssential.
  ///
  /// In en, this message translates to:
  /// **'Essential Fat'**
  String get bodyFatCategoryEssential;

  /// No description provided for @bodyFatCategoryAthletic.
  ///
  /// In en, this message translates to:
  /// **'Athletic'**
  String get bodyFatCategoryAthletic;

  /// No description provided for @bodyFatCategoryFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get bodyFatCategoryFitness;

  /// No description provided for @bodyFatCategoryAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get bodyFatCategoryAverage;

  /// No description provided for @bodyFatCategoryHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get bodyFatCategoryHigh;

  /// No description provided for @measurementsAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Measurement'**
  String get measurementsAddButton;

  /// No description provided for @measurementsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No measurements yet'**
  String get measurementsEmptyTitle;

  /// No description provided for @measurementsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first measurement to start tracking.'**
  String get measurementsEmptyMessage;

  /// No description provided for @measurementsChartTitle.
  ///
  /// In en, this message translates to:
  /// **'{measurement} (cm)'**
  String measurementsChartTitle(String measurement);

  /// No description provided for @measurementsSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Measurement'**
  String get measurementsSheetTitle;

  /// No description provided for @measurementsFieldHint.
  ///
  /// In en, this message translates to:
  /// **'{measurement} (cm)'**
  String measurementsFieldHint(String measurement);

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreenTitle;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load profile: {error}'**
  String profileLoadError(String error);

  /// No description provided for @profileEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No profile yet'**
  String get profileEmptyTitle;

  /// No description provided for @profileEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete onboarding to build your profile.'**
  String get profileEmptyMessage;

  /// No description provided for @bioAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get bioAge;

  /// No description provided for @bioHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get bioHeight;

  /// No description provided for @bioWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get bioWeight;

  /// No description provided for @bioLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get bioLevel;

  /// No description provided for @profileGoalsTile.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get profileGoalsTile;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @goalsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No goals set'**
  String get goalsEmptyTitle;

  /// No description provided for @goalsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete onboarding to set your goals.'**
  String get goalsEmptyMessage;

  /// No description provided for @goalsCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get goalsCurrentLabel;

  /// No description provided for @goalsTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get goalsTargetLabel;

  /// No description provided for @goalsRemainingLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get goalsRemainingLabel;

  /// No description provided for @goalsWeeklyWorkoutLabel.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY WORKOUT GOAL'**
  String get goalsWeeklyWorkoutLabel;

  /// No description provided for @goalsDailyCalorieLabel.
  ///
  /// In en, this message translates to:
  /// **'DAILY CALORIE GOAL'**
  String get goalsDailyCalorieLabel;

  /// No description provided for @goalsProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'PROTEIN GOAL'**
  String get goalsProteinLabel;

  /// No description provided for @settingsWorkoutSection.
  ///
  /// In en, this message translates to:
  /// **'Workout Settings'**
  String get settingsWorkoutSection;

  /// No description provided for @settingsDefaultRestTime.
  ///
  /// In en, this message translates to:
  /// **'Default Rest Time'**
  String get settingsDefaultRestTime;

  /// No description provided for @settingsAutoStartNextSet.
  ///
  /// In en, this message translates to:
  /// **'Auto-start Next Set'**
  String get settingsAutoStartNextSet;

  /// No description provided for @settingsWeightUnit.
  ///
  /// In en, this message translates to:
  /// **'Weight Unit'**
  String get settingsWeightUnit;

  /// No description provided for @settingsDistanceUnit.
  ///
  /// In en, this message translates to:
  /// **'Distance Unit'**
  String get settingsDistanceUnit;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsHaptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get settingsHaptics;

  /// No description provided for @settingsCountdownBeep.
  ///
  /// In en, this message translates to:
  /// **'Countdown Beep (3-2-1)'**
  String get settingsCountdownBeep;

  /// No description provided for @settingsNutritionSection.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Settings'**
  String get settingsNutritionSection;

  /// No description provided for @settingsAutoCalculateTargets.
  ///
  /// In en, this message translates to:
  /// **'Auto-calculate targets (TDEE)'**
  String get settingsAutoCalculateTargets;

  /// No description provided for @settingsFoodDatabase.
  ///
  /// In en, this message translates to:
  /// **'Food Database'**
  String get settingsFoodDatabase;

  /// No description provided for @settingsFoodDbGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global (All)'**
  String get settingsFoodDbGlobal;

  /// No description provided for @settingsFoodDbTurkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get settingsFoodDbTurkey;

  /// No description provided for @settingsFoodDbGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get settingsFoodDbGermany;

  /// No description provided for @settingsFoodDbUK.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get settingsFoodDbUK;

  /// No description provided for @settingsFoodDbUS.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get settingsFoodDbUS;

  /// No description provided for @settingsFoodDbFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get settingsFoodDbFrance;

  /// No description provided for @settingsManualMacroEditing.
  ///
  /// In en, this message translates to:
  /// **'Manual macro editing: Calories {calories} · Protein {protein}g · Carbs {carbs}g · Fat {fat}g'**
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat);

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsEnableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get settingsEnableNotifications;

  /// No description provided for @settingsAppearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Language'**
  String get settingsAppearanceSection;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account & Support'**
  String get settingsAccountSection;

  /// No description provided for @muscleGroupChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get muscleGroupChest;

  /// No description provided for @muscleGroupBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get muscleGroupBack;

  /// No description provided for @muscleGroupShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get muscleGroupShoulders;

  /// No description provided for @muscleGroupBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get muscleGroupBiceps;

  /// No description provided for @muscleGroupTriceps.
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get muscleGroupTriceps;

  /// No description provided for @muscleGroupLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get muscleGroupLegs;

  /// No description provided for @muscleGroupGlutes.
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get muscleGroupGlutes;

  /// No description provided for @muscleGroupCore.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get muscleGroupCore;

  /// No description provided for @muscleGroupCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get muscleGroupCardio;

  /// No description provided for @muscleGroupFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body'**
  String get muscleGroupFullBody;

  /// No description provided for @settingsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settingsSubscription;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'THRIVE+ Premium'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove ads and unlock AI coaching.'**
  String get paywallSubtitle;

  /// No description provided for @paywallFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get paywallFeatureNoAds;

  /// No description provided for @paywallFeatureAiWorkouts.
  ///
  /// In en, this message translates to:
  /// **'AI-generated workout plans'**
  String get paywallFeatureAiWorkouts;

  /// No description provided for @paywallFeatureAiMeals.
  ///
  /// In en, this message translates to:
  /// **'AI meal-text logging'**
  String get paywallFeatureAiMeals;

  /// No description provided for @paywallSubscribeButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get paywallSubscribeButton;

  /// No description provided for @paywallRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get paywallRestoreButton;

  /// No description provided for @paywallUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions aren\'t available yet — check back soon.'**
  String get paywallUnavailable;

  /// No description provided for @paywallAlreadySubscribed.
  ///
  /// In en, this message translates to:
  /// **'You\'re already Premium. Thank you!'**
  String get paywallAlreadySubscribed;

  /// No description provided for @paywallPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase couldn\'t be completed. Please try again.'**
  String get paywallPurchaseFailed;

  /// No description provided for @paywallRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored.'**
  String get paywallRestoreSuccess;

  /// No description provided for @paywallRestoreNone.
  ///
  /// In en, this message translates to:
  /// **'No previous purchases found for this account.'**
  String get paywallRestoreNone;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get settingsSendFeedback;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get settingsDeleteAccountConfirmTitle;

  /// No description provided for @settingsDeleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account and all your data — workouts, nutrition logs, progress, everything. This cannot be undone.'**
  String get settingsDeleteAccountConfirmMessage;

  /// No description provided for @settingsDeleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get settingsDeleteAccountConfirmButton;

  /// No description provided for @settingsDeleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete your account. Please try again.'**
  String get settingsDeleteAccountFailed;

  /// No description provided for @settingsSecondsFormat.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String settingsSecondsFormat(int seconds);

  /// No description provided for @mealCardNoItems.
  ///
  /// In en, this message translates to:
  /// **'No items logged yet'**
  String get mealCardNoItems;

  /// No description provided for @mealCardAddFood.
  ///
  /// In en, this message translates to:
  /// **'Add Food'**
  String get mealCardAddFood;

  /// No description provided for @workoutCardSummary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min • {count} exercises'**
  String workoutCardSummary(int minutes, int count);

  /// No description provided for @exerciseCardSetsReps.
  ///
  /// In en, this message translates to:
  /// **'{sets} Sets × {reps} Reps'**
  String exerciseCardSetsReps(int sets, int reps);

  /// No description provided for @exerciseCardLastBest.
  ///
  /// In en, this message translates to:
  /// **'Last: {value}'**
  String exerciseCardLastBest(String value);

  /// No description provided for @restTimerLabel.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get restTimerLabel;

  /// No description provided for @restTimerSubtract.
  ///
  /// In en, this message translates to:
  /// **'-15s'**
  String get restTimerSubtract;

  /// No description provided for @restTimerSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip Rest'**
  String get restTimerSkip;

  /// No description provided for @restTimerAdd.
  ///
  /// In en, this message translates to:
  /// **'+30s'**
  String get restTimerAdd;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Train smarter. Get stronger.'**
  String get splashTagline;

  /// No description provided for @lineChartNoData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get lineChartNoData;

  /// No description provided for @weightLogButton.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get weightLogButton;

  /// No description provided for @weightFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightFieldHint;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get navWorkouts;

  /// No description provided for @navNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get navNutrition;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
