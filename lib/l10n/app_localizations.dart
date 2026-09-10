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
  /// **'Repwise'**
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
