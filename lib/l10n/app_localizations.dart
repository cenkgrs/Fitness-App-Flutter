import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
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
  /// **'Create account'**
  String get authSignUpTitle;

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authSignInTitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account and we\'ll set up your plan together.'**
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
  /// **'Sign up'**
  String get authSignUpButton;

  /// No description provided for @authSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInButton;

  /// No description provided for @authSwitchToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authSwitchToSignIn;

  /// No description provided for @authSwitchToSignUp.
  ///
  /// In en, this message translates to:
  /// **'New here? Create an account'**
  String get authSwitchToSignUp;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authResetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authResetPasswordTitle;

  /// No description provided for @authResetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a reset link.'**
  String get authResetPasswordMessage;

  /// No description provided for @authResetPasswordSend.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
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
  /// **'Set a new password'**
  String get authNewPasswordTitle;

  /// No description provided for @authNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authNewPasswordHint;

  /// No description provided for @authNewPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get authNewPasswordButton;

  /// No description provided for @authNewPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get authNewPasswordSuccess;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingWelcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Training and food, in one plan.'**
  String get onboardingWelcomeHeadline;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A few quick questions, then we\'ll build a program and calorie target that fit you.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
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
  /// **'Lose weight'**
  String get goalLoseWeight;

  /// No description provided for @goalBuildMuscle.
  ///
  /// In en, this message translates to:
  /// **'Build muscle'**
  String get goalBuildMuscle;

  /// No description provided for @goalLoseFat.
  ///
  /// In en, this message translates to:
  /// **'Lose fat'**
  String get goalLoseFat;

  /// No description provided for @goalMaintainFitness.
  ///
  /// In en, this message translates to:
  /// **'Stay fit'**
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
  /// **'Moderately active'**
  String get activityModeratelyActiveLabel;

  /// No description provided for @activityModeratelyActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'~7,500 steps/day'**
  String get activityModeratelyActiveSubtitle;

  /// No description provided for @activityVeryActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Very active'**
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
  /// **'High protein'**
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
  /// **'Working out your calorie needs…'**
  String get onboardingCalculatingLine1;

  /// No description provided for @onboardingCalculatingLine2.
  ///
  /// In en, this message translates to:
  /// **'Putting your weekly program together…'**
  String get onboardingCalculatingLine2;

  /// No description provided for @onboardingPlanReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'{name}, your plan is ready'**
  String onboardingPlanReadyTitle(String name);

  /// No description provided for @onboardingDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get onboardingDefaultName;

  /// No description provided for @onboardingDailyCalories.
  ///
  /// In en, this message translates to:
  /// **'Daily calories'**
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
  /// **'{days} days a week'**
  String onboardingDaysPerWeekProgram(int days);

  /// No description provided for @onboardingPlanTagline.
  ///
  /// In en, this message translates to:
  /// **'Strength and body composition'**
  String get onboardingPlanTagline;

  /// No description provided for @onboardingStartMyPlan.
  ///
  /// In en, this message translates to:
  /// **'Start my plan'**
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
  /// **'Rest day. Recovery is part of the plan.'**
  String get homeRestDayMessage;

  /// No description provided for @homeNoWorkoutPlanned.
  ///
  /// In en, this message translates to:
  /// **'No workout planned yet.'**
  String get homeNoWorkoutPlanned;

  /// No description provided for @homeWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {count} exercises'**
  String homeWorkoutSummary(int minutes, int count);

  /// No description provided for @homeStartWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get homeStartWorkout;

  /// No description provided for @homeWeightGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT GOAL'**
  String get homeWeightGoalLabel;

  /// No description provided for @homeWeightRemaining.
  ///
  /// In en, this message translates to:
  /// **'{kg} kg to go'**
  String homeWeightRemaining(String kg);

  /// No description provided for @homeQuickActionAddMeal.
  ///
  /// In en, this message translates to:
  /// **'Add meal'**
  String get homeQuickActionAddMeal;

  /// No description provided for @homeQuickActionLogWeight.
  ///
  /// In en, this message translates to:
  /// **'Log weight'**
  String get homeQuickActionLogWeight;

  /// No description provided for @homeQuickActionViewProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
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
  /// **'This week'**
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
  /// **'Finish setup to generate your weekly program.'**
  String get workoutsOnboardingCta;

  /// No description provided for @workoutsCreateMyPlan.
  ///
  /// In en, this message translates to:
  /// **'Create my plan'**
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
  /// **'Set {current} of {total}'**
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
  /// **'Skip exercise'**
  String get activeWorkoutSkipExercise;

  /// No description provided for @activeWorkoutAddSet.
  ///
  /// In en, this message translates to:
  /// **'Add set'**
  String get activeWorkoutAddSet;

  /// No description provided for @activeWorkoutCompleteSet.
  ///
  /// In en, this message translates to:
  /// **'Complete set'**
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
  /// **'End workout'**
  String get activeWorkoutEndConfirm;

  /// No description provided for @workoutDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Workout not found'**
  String get workoutDetailNotFound;

  /// No description provided for @workoutDetailStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get workoutDetailStartButton;

  /// No description provided for @workoutSummarySessionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Session not found'**
  String get workoutSummarySessionNotFound;

  /// No description provided for @workoutSummaryComplete.
  ///
  /// In en, this message translates to:
  /// **'Workout complete'**
  String get workoutSummaryComplete;

  /// No description provided for @workoutSummaryDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get workoutSummaryDuration;

  /// No description provided for @workoutSummaryTotalVolume.
  ///
  /// In en, this message translates to:
  /// **'Total volume'**
  String get workoutSummaryTotalVolume;

  /// No description provided for @workoutSummarySetsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Sets completed'**
  String get workoutSummarySetsCompleted;

  /// No description provided for @workoutSummaryEstCalories.
  ///
  /// In en, this message translates to:
  /// **'Est. calories'**
  String get workoutSummaryEstCalories;

  /// No description provided for @workoutSummaryNewPr.
  ///
  /// In en, this message translates to:
  /// **'New PR: {weight} kg × {reps}'**
  String workoutSummaryNewPr(String weight, String reps);

  /// No description provided for @workoutSummaryEncouragement.
  ///
  /// In en, this message translates to:
  /// **'Good session. Every set you log makes next week\'s plan more accurate.'**
  String get workoutSummaryEncouragement;

  /// No description provided for @workoutSummaryFinish.
  ///
  /// In en, this message translates to:
  /// **'Done'**
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
  /// **'Quick add'**
  String get foodLoggerQuickAddTab;

  /// No description provided for @foodLoggerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for food or brand...'**
  String get foodLoggerSearchHint;

  /// No description provided for @barcodeScannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan barcode'**
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

  /// No description provided for @aiChatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Coach'**
  String get aiChatTitle;

  /// No description provided for @aiChatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about training, food or recovery'**
  String get aiChatInputHint;

  /// No description provided for @aiChatEmptyState.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything about training, nutrition, or recovery.'**
  String get aiChatEmptyState;

  /// No description provided for @aiChatRemainingToday.
  ///
  /// In en, this message translates to:
  /// **'{count} messages left today'**
  String aiChatRemainingToday(int count);

  /// No description provided for @aiChatLimitReached.
  ///
  /// In en, this message translates to:
  /// **'That\'s today\'s message limit. It resets tomorrow.'**
  String get aiChatLimitReached;

  /// No description provided for @healthConnectPrompt.
  ///
  /// In en, this message translates to:
  /// **'Connect Apple Health or Health Connect to see steps and calories burned'**
  String get healthConnectPrompt;

  /// No description provided for @healthStepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get healthStepsLabel;

  /// No description provided for @healthCaloriesBurnedLabel.
  ///
  /// In en, this message translates to:
  /// **'Active kcal'**
  String get healthCaloriesBurnedLabel;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementsUnlockedCount.
  ///
  /// In en, this message translates to:
  /// **'{unlocked}/{total} unlocked'**
  String achievementsUnlockedCount(int unlocked, int total);

  /// No description provided for @achievementFirstWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get achievementFirstWorkoutTitle;

  /// No description provided for @achievementFirstWorkoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first workout'**
  String get achievementFirstWorkoutDesc;

  /// No description provided for @achievementWorkout5Title.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get achievementWorkout5Title;

  /// No description provided for @achievementWorkout5Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 workouts'**
  String get achievementWorkout5Desc;

  /// No description provided for @achievementWorkout25Title.
  ///
  /// In en, this message translates to:
  /// **'Committed'**
  String get achievementWorkout25Title;

  /// No description provided for @achievementWorkout25Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 25 workouts'**
  String get achievementWorkout25Desc;

  /// No description provided for @achievementWorkout100Title.
  ///
  /// In en, this message translates to:
  /// **'Century Club'**
  String get achievementWorkout100Title;

  /// No description provided for @achievementWorkout100Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 workouts'**
  String get achievementWorkout100Desc;

  /// No description provided for @achievementFirstPrTitle.
  ///
  /// In en, this message translates to:
  /// **'New Record'**
  String get achievementFirstPrTitle;

  /// No description provided for @achievementFirstPrDesc.
  ///
  /// In en, this message translates to:
  /// **'Hit your first personal record'**
  String get achievementFirstPrDesc;

  /// No description provided for @achievementStreak3Title.
  ///
  /// In en, this message translates to:
  /// **'On a Roll'**
  String get achievementStreak3Title;

  /// No description provided for @achievementStreak3Desc.
  ///
  /// In en, this message translates to:
  /// **'3-day workout streak'**
  String get achievementStreak3Desc;

  /// No description provided for @achievementStreak7Title.
  ///
  /// In en, this message translates to:
  /// **'One Week Strong'**
  String get achievementStreak7Title;

  /// No description provided for @achievementStreak7Desc.
  ///
  /// In en, this message translates to:
  /// **'7-day workout streak'**
  String get achievementStreak7Desc;

  /// No description provided for @achievementStreak30Title.
  ///
  /// In en, this message translates to:
  /// **'Unstoppable'**
  String get achievementStreak30Title;

  /// No description provided for @achievementStreak30Desc.
  ///
  /// In en, this message translates to:
  /// **'30-day workout streak'**
  String get achievementStreak30Desc;

  /// No description provided for @achievementWeightLogged5Title.
  ///
  /// In en, this message translates to:
  /// **'Tracking It'**
  String get achievementWeightLogged5Title;

  /// No description provided for @achievementWeightLogged5Desc.
  ///
  /// In en, this message translates to:
  /// **'Log your weight 5 times'**
  String get achievementWeightLogged5Desc;

  /// No description provided for @achievementWeightLogged30Title.
  ///
  /// In en, this message translates to:
  /// **'Data Driven'**
  String get achievementWeightLogged30Title;

  /// No description provided for @achievementWeightLogged30Desc.
  ///
  /// In en, this message translates to:
  /// **'Log your weight 30 times'**
  String get achievementWeightLogged30Desc;

  /// No description provided for @waterCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get waterCardTitle;

  /// No description provided for @waterCardAmount.
  ///
  /// In en, this message translates to:
  /// **'{consumed}/{goal} ml'**
  String waterCardAmount(int consumed, int goal);

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
  /// **'Quick add'**
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
  /// **'Finish a workout to start tracking your estimated 1RM.'**
  String get progressStrengthEmptyMessage;

  /// No description provided for @progressStrengthChartTitle.
  ///
  /// In en, this message translates to:
  /// **'{exercise}'**
  String progressStrengthChartTitle(String exercise);

  /// No description provided for @progressCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get progressCurrentStreak;

  /// No description provided for @progressLongestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
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
  /// **'Body fat · {category}'**
  String measurementsBodyFatLabel(String category);

  /// No description provided for @bodyFatCategoryEssential.
  ///
  /// In en, this message translates to:
  /// **'Essential fat'**
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
  /// **'Add measurement'**
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
  /// **'Add measurement'**
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
  /// **'Finish setup to build your profile.'**
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
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @goalsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No goals set'**
  String get goalsEmptyTitle;

  /// No description provided for @goalsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Finish setup to set your goals.'**
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
  /// **'WEEKLY WORKOUTS'**
  String get goalsWeeklyWorkoutLabel;

  /// No description provided for @goalsDailyCalorieLabel.
  ///
  /// In en, this message translates to:
  /// **'DAILY CALORIES'**
  String get goalsDailyCalorieLabel;

  /// No description provided for @goalsProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'DAILY PROTEIN'**
  String get goalsProteinLabel;

  /// No description provided for @settingsWorkoutSection.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get settingsWorkoutSection;

  /// No description provided for @settingsDefaultRestTime.
  ///
  /// In en, this message translates to:
  /// **'Default rest time'**
  String get settingsDefaultRestTime;

  /// No description provided for @settingsAutoStartNextSet.
  ///
  /// In en, this message translates to:
  /// **'Auto-start next set'**
  String get settingsAutoStartNextSet;

  /// No description provided for @settingsWeightUnit.
  ///
  /// In en, this message translates to:
  /// **'Weight unit'**
  String get settingsWeightUnit;

  /// No description provided for @settingsDistanceUnit.
  ///
  /// In en, this message translates to:
  /// **'Distance unit'**
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
  /// **'Countdown beep (3-2-1)'**
  String get settingsCountdownBeep;

  /// No description provided for @settingsNutritionSection.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get settingsNutritionSection;

  /// No description provided for @settingsAutoCalculateTargets.
  ///
  /// In en, this message translates to:
  /// **'Auto-calculate targets (TDEE)'**
  String get settingsAutoCalculateTargets;

  /// No description provided for @settingsFoodDatabase.
  ///
  /// In en, this message translates to:
  /// **'Food database'**
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
  /// **'Reminders'**
  String get settingsEnableNotifications;

  /// No description provided for @settingsAppearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
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
  /// **'Account & support'**
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
  /// **'Full body'**
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
  /// **'No ads, plus the AI coach.'**
  String get paywallSubtitle;

  /// No description provided for @paywallFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get paywallFeatureNoAds;

  /// No description provided for @paywallFeatureAiWorkouts.
  ///
  /// In en, this message translates to:
  /// **'AI-built workout programs'**
  String get paywallFeatureAiWorkouts;

  /// No description provided for @paywallFeatureAiMeals.
  ///
  /// In en, this message translates to:
  /// **'Log meals by typing them out'**
  String get paywallFeatureAiMeals;

  /// No description provided for @paywallSubscribeButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get paywallSubscribeButton;

  /// No description provided for @paywallRestoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get paywallRestoreButton;

  /// No description provided for @paywallUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions aren\'t available yet.'**
  String get paywallUnavailable;

  /// No description provided for @paywallAlreadySubscribed.
  ///
  /// In en, this message translates to:
  /// **'You\'re on Premium. Thanks for the support.'**
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
  /// **'Send feedback'**
  String get settingsSendFeedback;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
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
  /// **'Delete permanently'**
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
  /// **'Nothing logged yet'**
  String get mealCardNoItems;

  /// No description provided for @mealCardAddFood.
  ///
  /// In en, this message translates to:
  /// **'Add food'**
  String get mealCardAddFood;

  /// No description provided for @workoutCardSummary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {count} exercises'**
  String workoutCardSummary(int minutes, int count);

  /// No description provided for @exerciseCardSetsReps.
  ///
  /// In en, this message translates to:
  /// **'{sets} × {reps}'**
  String exerciseCardSetsReps(int sets, int reps);

  /// No description provided for @exerciseCardLastBest.
  ///
  /// In en, this message translates to:
  /// **'Last: {value}'**
  String exerciseCardLastBest(String value);

  /// No description provided for @restTimerLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get restTimerLabel;

  /// No description provided for @restTimerSubtract.
  ///
  /// In en, this message translates to:
  /// **'-15s'**
  String get restTimerSubtract;

  /// No description provided for @restTimerSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip rest'**
  String get restTimerSkip;

  /// No description provided for @restTimerAdd.
  ///
  /// In en, this message translates to:
  /// **'+30s'**
  String get restTimerAdd;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Training, food and progress in one place.'**
  String get splashTagline;

  /// No description provided for @lineChartNoData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get lineChartNoData;

  /// No description provided for @weightLogButton.
  ///
  /// In en, this message translates to:
  /// **'Log weight'**
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

  /// No description provided for @weekdayInitials.
  ///
  /// In en, this message translates to:
  /// **'M,T,W,T,F,S,S'**
  String get weekdayInitials;

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get streakLabel;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirm your email first. Check your inbox.'**
  String get authErrorEmailNotConfirmed;

  /// No description provided for @authErrorUserExists.
  ///
  /// In en, this message translates to:
  /// **'There\'s already an account with this email. Try signing in.'**
  String get authErrorUserExists;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'That password is too weak. Use at least 6 characters.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'That email address doesn\'t look right.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a minute and try again.'**
  String get authErrorRateLimited;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t sign you in. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @authErrorMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password.'**
  String get authErrorMissingFields;

  /// No description provided for @authConfirmEmailSent.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to your email. Open it to finish signing up.'**
  String get authConfirmEmailSent;

  /// No description provided for @notifWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s workout is waiting'**
  String get notifWorkoutTitle;

  /// No description provided for @notifWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'No workout logged yet today. Got 20 minutes?'**
  String get notifWorkoutBody;

  /// No description provided for @notifMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Log your meal'**
  String get notifMealTitle;

  /// No description provided for @notifLunchBody.
  ///
  /// In en, this message translates to:
  /// **'Lunch time. Add what you ate while you remember it.'**
  String get notifLunchBody;

  /// No description provided for @notifDinnerBody.
  ///
  /// In en, this message translates to:
  /// **'Dinner time. Add what you ate while you remember it.'**
  String get notifDinnerBody;

  /// No description provided for @dayFullBodyA.
  ///
  /// In en, this message translates to:
  /// **'Full Body A'**
  String get dayFullBodyA;

  /// No description provided for @dayFullBodyB.
  ///
  /// In en, this message translates to:
  /// **'Full Body B'**
  String get dayFullBodyB;

  /// No description provided for @dayFullBodyC.
  ///
  /// In en, this message translates to:
  /// **'Full Body C'**
  String get dayFullBodyC;

  /// No description provided for @dayFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body'**
  String get dayFullBody;

  /// No description provided for @dayUpperBodyPower.
  ///
  /// In en, this message translates to:
  /// **'Upper Body · Strength'**
  String get dayUpperBodyPower;

  /// No description provided for @dayUpperBodyHypertrophy.
  ///
  /// In en, this message translates to:
  /// **'Upper Body · Volume'**
  String get dayUpperBodyHypertrophy;

  /// No description provided for @dayUpperBody.
  ///
  /// In en, this message translates to:
  /// **'Upper Body'**
  String get dayUpperBody;

  /// No description provided for @dayLowerBodyFocus.
  ///
  /// In en, this message translates to:
  /// **'Lower Body · Strength'**
  String get dayLowerBodyFocus;

  /// No description provided for @dayLowerBody.
  ///
  /// In en, this message translates to:
  /// **'Lower Body'**
  String get dayLowerBody;

  /// No description provided for @dayPush.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get dayPush;

  /// No description provided for @dayPull.
  ///
  /// In en, this message translates to:
  /// **'Pull'**
  String get dayPull;

  /// No description provided for @dayLegsCore.
  ///
  /// In en, this message translates to:
  /// **'Legs & Core'**
  String get dayLegsCore;

  /// No description provided for @dayActiveRecovery.
  ///
  /// In en, this message translates to:
  /// **'Active recovery'**
  String get dayActiveRecovery;

  /// No description provided for @dayRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get dayRest;

  /// No description provided for @programFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body Program'**
  String get programFullBody;

  /// No description provided for @programUpperLower.
  ///
  /// In en, this message translates to:
  /// **'Upper/Lower Split'**
  String get programUpperLower;

  /// No description provided for @exBenchPress.
  ///
  /// In en, this message translates to:
  /// **'Bench Press'**
  String get exBenchPress;

  /// No description provided for @exInclineDumbbellPress.
  ///
  /// In en, this message translates to:
  /// **'Incline Dumbbell Press'**
  String get exInclineDumbbellPress;

  /// No description provided for @exOverheadPress.
  ///
  /// In en, this message translates to:
  /// **'Overhead Press'**
  String get exOverheadPress;

  /// No description provided for @exTricepsPushdown.
  ///
  /// In en, this message translates to:
  /// **'Triceps Pushdown'**
  String get exTricepsPushdown;

  /// No description provided for @exLateralRaise.
  ///
  /// In en, this message translates to:
  /// **'Lateral Raise'**
  String get exLateralRaise;

  /// No description provided for @exDeadlift.
  ///
  /// In en, this message translates to:
  /// **'Deadlift'**
  String get exDeadlift;

  /// No description provided for @exPullUp.
  ///
  /// In en, this message translates to:
  /// **'Pull-Up'**
  String get exPullUp;

  /// No description provided for @exBarbellRow.
  ///
  /// In en, this message translates to:
  /// **'Barbell Row'**
  String get exBarbellRow;

  /// No description provided for @exFacePull.
  ///
  /// In en, this message translates to:
  /// **'Face Pull'**
  String get exFacePull;

  /// No description provided for @exBicepCurl.
  ///
  /// In en, this message translates to:
  /// **'Biceps Curl'**
  String get exBicepCurl;

  /// No description provided for @exBackSquat.
  ///
  /// In en, this message translates to:
  /// **'Back Squat'**
  String get exBackSquat;

  /// No description provided for @exRomanianDeadlift.
  ///
  /// In en, this message translates to:
  /// **'Romanian Deadlift'**
  String get exRomanianDeadlift;

  /// No description provided for @exLegPress.
  ///
  /// In en, this message translates to:
  /// **'Leg Press'**
  String get exLegPress;

  /// No description provided for @exWalkingLunge.
  ///
  /// In en, this message translates to:
  /// **'Walking Lunge'**
  String get exWalkingLunge;

  /// No description provided for @exPlank.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get exPlank;

  /// No description provided for @exGobletSquat.
  ///
  /// In en, this message translates to:
  /// **'Goblet Squat'**
  String get exGobletSquat;

  /// No description provided for @exPushUp.
  ///
  /// In en, this message translates to:
  /// **'Push-Up'**
  String get exPushUp;

  /// No description provided for @exDumbbellRow.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell Row'**
  String get exDumbbellRow;
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
      <String>['de', 'en', 'es', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
