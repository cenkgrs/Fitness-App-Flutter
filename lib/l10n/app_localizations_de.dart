// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'THRIVE+';

  @override
  String get settingsScreenTitle => 'Einstellungen';

  @override
  String get authSignUpTitle => 'Konto erstellen';

  @override
  String get authSignInTitle => 'Willkommen zurück';

  @override
  String get authSignUpSubtitle =>
      'Erstelle ein Konto, dann stellen wir gemeinsam deinen Plan auf.';

  @override
  String get authSignInSubtitle =>
      'Melde dich an und mach da weiter, wo du aufgehört hast.';

  @override
  String get authContinueWithApple => 'Weiter mit Apple';

  @override
  String get authContinueWithGoogle => 'Weiter mit Google';

  @override
  String get authOrWithEmail => 'oder mit E-Mail';

  @override
  String get authEmailHint => 'E-Mail';

  @override
  String get authPasswordHint => 'Passwort';

  @override
  String get authSignUpButton => 'Registrieren';

  @override
  String get authSignInButton => 'Anmelden';

  @override
  String get authSwitchToSignIn => 'Schon ein Konto? Anmelden';

  @override
  String get authSwitchToSignUp => 'Neu hier? Konto erstellen';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authResetPasswordTitle => 'Passwort zurücksetzen';

  @override
  String get authResetPasswordMessage =>
      'Gib deine E-Mail ein, wir schicken dir einen Link zum Zurücksetzen.';

  @override
  String get authResetPasswordSend => 'Link senden';

  @override
  String get authResetPasswordSent =>
      'Falls die E-Mail registriert ist, wurde ein Link verschickt.';

  @override
  String get authResetPasswordFailed =>
      'Der Link konnte nicht gesendet werden. Bitte versuch es erneut.';

  @override
  String get authNewPasswordTitle => 'Neues Passwort festlegen';

  @override
  String get authNewPasswordHint => 'Neues Passwort';

  @override
  String get authNewPasswordButton => 'Passwort aktualisieren';

  @override
  String get authNewPasswordSuccess => 'Passwort aktualisiert.';

  @override
  String get onboardingContinue => 'Weiter';

  @override
  String get onboardingWelcomeHeadline =>
      'Training und Ernährung in einem Plan.';

  @override
  String get onboardingWelcomeSubtitle =>
      'Ein paar kurze Fragen, dann erstellen wir ein Programm und ein Kalorienziel, die zu dir passen.';

  @override
  String get onboardingGetStarted => 'Los geht\'s';

  @override
  String get onboardingNameTitle => 'Wie sollen wir dich nennen?';

  @override
  String get onboardingNameHint => 'Dein Name';

  @override
  String get onboardingGenderTitle => 'Was ist dein Geschlecht?';

  @override
  String get onboardingGenderMale => 'Männlich';

  @override
  String get onboardingGenderFemale => 'Weiblich';

  @override
  String get onboardingGenderUnspecified => 'Keine Angabe';

  @override
  String get onboardingAgeTitle => 'Wie alt bist du?';

  @override
  String get onboardingHeightTitle => 'Deine Größe (cm)';

  @override
  String get onboardingWeightTitle => 'Dein Gewicht (kg)';

  @override
  String get onboardingTargetWeightTitle => 'Zielgewicht (kg)';

  @override
  String get onboardingFitnessLevelTitle => 'Wie fit bist du?';

  @override
  String get fitnessBeginnerLabel => 'Anfänger';

  @override
  String get fitnessBeginnerSubtitle => 'Lerne die Grundübungen (0–1 Jahr)';

  @override
  String get fitnessIntermediateLabel => 'Fortgeschritten';

  @override
  String get fitnessIntermediateSubtitle => 'Trainiere regelmäßig (1–3 Jahre)';

  @override
  String get fitnessAdvancedLabel => 'Erfahren';

  @override
  String get fitnessAdvancedSubtitle =>
      'Schweres Training & Periodisierung (3+ Jahre)';

  @override
  String get onboardingPrimaryGoalTitle => 'Was ist dein Hauptziel?';

  @override
  String get goalLoseWeight => 'Abnehmen';

  @override
  String get goalBuildMuscle => 'Muskeln aufbauen';

  @override
  String get goalLoseFat => 'Fett verlieren';

  @override
  String get goalMaintainFitness => 'Fit bleiben';

  @override
  String get onboardingDaysPerWeekTitle =>
      'An wie vielen Tagen pro Woche willst du trainieren?';

  @override
  String get onboardingMostPopular => 'Am häufigsten gewählt';

  @override
  String get onboardingDurationTitle => 'Wie lang sollen deine Workouts sein?';

  @override
  String onboardingDurationMinutes(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get onboardingLocationTitle => 'Wo trainierst du?';

  @override
  String get locationGym => 'Studio';

  @override
  String get locationHome => 'Zuhause';

  @override
  String get locationBoth => 'Beides';

  @override
  String get onboardingEquipmentLabel => 'Ausrüstung';

  @override
  String get onboardingActivityLevelTitle => 'Wie aktiv bist du im Alltag?';

  @override
  String get activitySedentaryLabel => 'Wenig aktiv';

  @override
  String get activitySedentarySubtitle => 'Bürojob, wenig Bewegung';

  @override
  String get activityModeratelyActiveLabel => 'Mäßig aktiv';

  @override
  String get activityModeratelyActiveSubtitle => '~7.500 Schritte/Tag';

  @override
  String get activityVeryActiveLabel => 'Sehr aktiv';

  @override
  String get activityVeryActiveSubtitle =>
      '10.000+ Schritte/Tag, körperliche Arbeit';

  @override
  String get onboardingNutritionPrefTitle => 'Wie ernährst du dich?';

  @override
  String get nutritionStandard => 'Standard';

  @override
  String get nutritionHighProtein => 'Proteinreich';

  @override
  String get nutritionKeto => 'Ketogen';

  @override
  String get nutritionVegetarian => 'Vegetarisch';

  @override
  String get nutritionVegan => 'Vegan';

  @override
  String get onboardingCalculatingLine1 =>
      'Dein Kalorienbedarf wird berechnet…';

  @override
  String get onboardingCalculatingLine2 => 'Dein Wochenprogramm wird erstellt…';

  @override
  String onboardingPlanReadyTitle(String name) {
    return '$name, dein Plan ist fertig';
  }

  @override
  String get onboardingDefaultName => 'Sportler';

  @override
  String get onboardingDailyCalories => 'Tägliche Kalorien';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Kohlenhydrate';

  @override
  String get macroFat => 'Fett';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return '$days Tage pro Woche';
  }

  @override
  String get onboardingPlanTagline => 'Kraft und Körperzusammensetzung';

  @override
  String get onboardingStartMyPlan => 'Plan starten';

  @override
  String get homeGreetingMorning => 'Guten Morgen';

  @override
  String get homeGreetingAfternoon => 'Guten Tag';

  @override
  String get homeGreetingEvening => 'Guten Abend';

  @override
  String get homeDefaultAthleteName => 'Sportler';

  @override
  String homeCaloriesLeft(int count) {
    return 'noch $count';
  }

  @override
  String get homeTodaysWorkoutLabel => 'HEUTIGES WORKOUT';

  @override
  String get homeRestDayMessage => 'Ruhetag. Erholung gehört zum Plan.';

  @override
  String get homeNoWorkoutPlanned => 'Noch kein Workout geplant.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '$minutes Min. · $count Übungen';
  }

  @override
  String get homeStartWorkout => 'Workout starten';

  @override
  String get homeWeightGoalLabel => 'GEWICHTSZIEL';

  @override
  String homeWeightRemaining(String kg) {
    return 'Noch $kg kg';
  }

  @override
  String get homeQuickActionAddMeal => 'Mahlzeit';

  @override
  String get homeQuickActionLogWeight => 'Gewicht';

  @override
  String get homeQuickActionViewProgress => 'Fortschritt';

  @override
  String genericError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get weekdayMonday => 'Montag';

  @override
  String get weekdayTuesday => 'Dienstag';

  @override
  String get weekdayWednesday => 'Mittwoch';

  @override
  String get weekdayThursday => 'Donnerstag';

  @override
  String get weekdayFriday => 'Freitag';

  @override
  String get weekdaySaturday => 'Samstag';

  @override
  String get weekdaySunday => 'Sonntag';

  @override
  String get workoutsScreenTitle => 'Diese Woche';

  @override
  String get workoutsAiUpdateTooltip => 'Mit KI aktualisieren';

  @override
  String workoutsAiUpdateFailedSnackbar(String error) {
    return 'Die KI konnte das Programm nicht aktualisieren: $error';
  }

  @override
  String workoutsFailedToLoad(String error) {
    return 'Programm konnte nicht geladen werden: $error';
  }

  @override
  String get workoutsOnboardingCta =>
      'Schließ die Einrichtung ab, um dein Wochenprogramm zu erstellen.';

  @override
  String get workoutsCreateMyPlan => 'Plan erstellen';

  @override
  String get activeWorkoutNoExercises => 'Keine Übungen für diesen Tag.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return 'Übung $current von $total';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'Satz $current von $total';
  }

  @override
  String activeWorkoutTarget(String weight, String reps) {
    return 'Ziel: $weight kg × $reps Wdh.';
  }

  @override
  String get activeWorkoutWeightLabel => 'GEWICHT (KG)';

  @override
  String get activeWorkoutRepsLabel => 'WDH.';

  @override
  String get activeWorkoutSkipExercise => 'Übung überspringen';

  @override
  String get activeWorkoutAddSet => 'Satz hinzufügen';

  @override
  String get activeWorkoutCompleteSet => 'Satz abschließen';

  @override
  String get activeWorkoutEndTitle => 'Workout beenden?';

  @override
  String get activeWorkoutEndContent =>
      'Dein Fortschritt in dieser Einheit geht verloren.';

  @override
  String get activeWorkoutEndConfirm => 'Workout beenden';

  @override
  String get workoutDetailNotFound => 'Workout nicht gefunden';

  @override
  String get workoutDetailStartButton => 'Workout starten';

  @override
  String get workoutSummarySessionNotFound => 'Einheit nicht gefunden';

  @override
  String get workoutSummaryComplete => 'Workout abgeschlossen';

  @override
  String get workoutSummaryDuration => 'Dauer';

  @override
  String get workoutSummaryTotalVolume => 'Gesamtvolumen';

  @override
  String get workoutSummarySetsCompleted => 'Sätze';

  @override
  String get workoutSummaryEstCalories => 'Geschätzte kcal';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'Neue Bestleistung: $weight kg × $reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Gute Einheit. Jeder erfasste Satz macht den Plan für nächste Woche genauer.';

  @override
  String get workoutSummaryFinish => 'Fertig';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get nutritionToday => 'Heute';

  @override
  String nutritionCaloriesProgress(int consumed, int goal) {
    return '$consumed / $goal kcal';
  }

  @override
  String get mealTypeBreakfast => 'Frühstück';

  @override
  String get mealTypeLunch => 'Mittagessen';

  @override
  String get mealTypeDinner => 'Abendessen';

  @override
  String get mealTypeSnack => 'Snack';

  @override
  String foodLoggerTitle(String mealType) {
    return 'Zu $mealType hinzufügen';
  }

  @override
  String get foodLoggerSearchTab => 'Suchen';

  @override
  String get foodLoggerQuickAddTab => 'Schnell hinzufügen';

  @override
  String get foodLoggerSearchHint => 'Lebensmittel oder Marke suchen...';

  @override
  String get barcodeScannerTitle => 'Barcode scannen';

  @override
  String get barcodeScannerHint =>
      'Richte die Kamera auf den Barcode eines Produkts';

  @override
  String get barcodeScannerNotFound =>
      'Zu diesem Barcode wurde kein Produkt gefunden.';

  @override
  String get aiChatTitle => 'KI-Coach';

  @override
  String get aiChatInputHint => 'Frag zu Training, Ernährung oder Erholung';

  @override
  String get aiChatEmptyState =>
      'Frag mich alles zu Training, Ernährung oder Erholung.';

  @override
  String aiChatRemainingToday(int count) {
    return 'Heute noch $count Nachrichten';
  }

  @override
  String get aiChatLimitReached =>
      'Das war das Nachrichtenlimit für heute. Morgen geht\'s weiter.';

  @override
  String get healthConnectPrompt =>
      'Verbinde Apple Health oder Health Connect, um Schritte und verbrannte Kalorien zu sehen';

  @override
  String get healthStepsLabel => 'Schritte';

  @override
  String get healthCaloriesBurnedLabel => 'Aktive kcal';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total freigeschaltet';
  }

  @override
  String get achievementFirstWorkoutTitle => 'Erster Schritt';

  @override
  String get achievementFirstWorkoutDesc => 'Schließ dein erstes Workout ab';

  @override
  String get achievementWorkout5Title => 'Auf dem Weg';

  @override
  String get achievementWorkout5Desc => 'Schließ 5 Workouts ab';

  @override
  String get achievementWorkout25Title => 'Drangeblieben';

  @override
  String get achievementWorkout25Desc => 'Schließ 25 Workouts ab';

  @override
  String get achievementWorkout100Title => 'Hunderter-Club';

  @override
  String get achievementWorkout100Desc => 'Schließ 100 Workouts ab';

  @override
  String get achievementFirstPrTitle => 'Neue Bestleistung';

  @override
  String get achievementFirstPrDesc =>
      'Stell deine erste persönliche Bestleistung auf';

  @override
  String get achievementStreak3Title => 'Im Flow';

  @override
  String get achievementStreak3Desc => '3 Tage Trainingsserie';

  @override
  String get achievementStreak7Title => 'Eine starke Woche';

  @override
  String get achievementStreak7Desc => '7 Tage Trainingsserie';

  @override
  String get achievementStreak30Title => 'Nicht zu stoppen';

  @override
  String get achievementStreak30Desc => '30 Tage Trainingsserie';

  @override
  String get achievementWeightLogged5Title => 'Am Ball';

  @override
  String get achievementWeightLogged5Desc => 'Trag dein Gewicht 5-mal ein';

  @override
  String get achievementWeightLogged30Title => 'Datenprofi';

  @override
  String get achievementWeightLogged30Desc => 'Trag dein Gewicht 30-mal ein';

  @override
  String get waterCardTitle => 'Wasser';

  @override
  String waterCardAmount(int consumed, int goal) {
    return '$consumed/$goal ml';
  }

  @override
  String get foodLoggerNoResultsTitle => 'Keine Ergebnisse';

  @override
  String get foodLoggerNoResultsMessage => 'Versuch einen anderen Suchbegriff.';

  @override
  String foodLoggerNutritionSummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal / 100 g • E:$protein g K:$carbs g F:$fat g';
  }

  @override
  String foodLoggerQuantitySummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal — E: $protein g, K: $carbs g, F: $fat g';
  }

  @override
  String get foodLoggerAiHint =>
      'z. B. 3 Eier, 100 g Reis, eine Handvoll Mandeln';

  @override
  String get foodLoggerAiFillButton => 'Mit KI ausfüllen';

  @override
  String get foodLoggerAiParsing => 'Wird ausgewertet...';

  @override
  String get foodLoggerOrManualEntry => 'oder manuell eingeben';

  @override
  String foodLoggerAiParseFailedSnackbar(String error) {
    return 'Die KI konnte die Mahlzeit nicht auswerten: $error';
  }

  @override
  String get quickAddCaloriesLabel => 'Kalorien';

  @override
  String get quickAddProteinLabel => 'Protein (g)';

  @override
  String get quickAddCarbsLabel => 'Kohlenhydrate (g)';

  @override
  String get quickAddFatLabel => 'Fett (g)';

  @override
  String get quickAddEntryDefaultName => 'Schnell hinzugefügt';

  @override
  String get progressScreenTitle => 'Fortschritt';

  @override
  String get progressTabWeight => 'Gewicht';

  @override
  String get progressTabStrength => 'Kraft';

  @override
  String get progressTabConsistency => 'Beständigkeit';

  @override
  String get progressTabMeasurements => 'Maße';

  @override
  String get progressWeightChartTitle => 'Gewicht (kg)';

  @override
  String get progressStrengthEmptyTitle => 'Noch keine Kraftdaten';

  @override
  String get progressStrengthEmptyMessage =>
      'Schließ ein Workout ab, um dein geschätztes 1RM zu verfolgen.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise';
  }

  @override
  String get progressCurrentStreak => 'Aktuelle Serie';

  @override
  String get progressLongestStreak => 'Längste Serie';

  @override
  String get progressConsistencyLabel => 'Beständigkeit';

  @override
  String get measurementWaist => 'Taille';

  @override
  String get measurementNeck => 'Hals';

  @override
  String get measurementHip => 'Hüfte';

  @override
  String get measurementChest => 'Brust';

  @override
  String get measurementBiceps => 'Bizeps';

  @override
  String get measurementThigh => 'Oberschenkel';

  @override
  String get measurementsBodyFatHint =>
      'Trag Taillen- und Halsumfang ein, um deinen Körperfettanteil zu sehen.';

  @override
  String measurementsBodyFatLabel(String category) {
    return 'Körperfett · $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Essenzielles Fett';

  @override
  String get bodyFatCategoryAthletic => 'Athletisch';

  @override
  String get bodyFatCategoryFitness => 'Fit';

  @override
  String get bodyFatCategoryAverage => 'Durchschnitt';

  @override
  String get bodyFatCategoryHigh => 'Hoch';

  @override
  String get measurementsAddButton => 'Maß hinzufügen';

  @override
  String get measurementsEmptyTitle => 'Noch keine Maße';

  @override
  String get measurementsEmptyMessage =>
      'Füg dein erstes Maß hinzu, um mit dem Tracking zu beginnen.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Maß hinzufügen';

  @override
  String measurementsFieldHint(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get commonSave => 'Speichern';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String profileLoadError(String error) {
    return 'Profil konnte nicht geladen werden: $error';
  }

  @override
  String get profileEmptyTitle => 'Noch kein Profil';

  @override
  String get profileEmptyMessage =>
      'Schließ die Einrichtung ab, um dein Profil anzulegen.';

  @override
  String get bioAge => 'Alter';

  @override
  String get bioHeight => 'Größe';

  @override
  String get bioWeight => 'Gewicht';

  @override
  String get bioLevel => 'Level';

  @override
  String get profileGoalsTile => 'Ziele';

  @override
  String get profileSignOut => 'Abmelden';

  @override
  String get goalsEmptyTitle => 'Keine Ziele festgelegt';

  @override
  String get goalsEmptyMessage =>
      'Schließ die Einrichtung ab, um deine Ziele festzulegen.';

  @override
  String get goalsCurrentLabel => 'Aktuell';

  @override
  String get goalsTargetLabel => 'Ziel';

  @override
  String get goalsRemainingLabel => 'Verbleibend';

  @override
  String get goalsWeeklyWorkoutLabel => 'WORKOUTS PRO WOCHE';

  @override
  String get goalsDailyCalorieLabel => 'KALORIEN PRO TAG';

  @override
  String get goalsProteinLabel => 'PROTEIN PRO TAG';

  @override
  String get settingsWorkoutSection => 'Training';

  @override
  String get settingsDefaultRestTime => 'Standard-Pausenzeit';

  @override
  String get settingsAutoStartNextSet => 'Nächsten Satz automatisch starten';

  @override
  String get settingsWeightUnit => 'Gewichtseinheit';

  @override
  String get settingsDistanceUnit => 'Entfernungseinheit';

  @override
  String get settingsSound => 'Ton';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsCountdownBeep => 'Countdown-Ton (3-2-1)';

  @override
  String get settingsNutritionSection => 'Ernährung';

  @override
  String get settingsAutoCalculateTargets =>
      'Ziele automatisch berechnen (TDEE)';

  @override
  String get settingsFoodDatabase => 'Lebensmitteldatenbank';

  @override
  String get settingsFoodDbGlobal => 'Global (alle)';

  @override
  String get settingsFoodDbTurkey => 'Türkei';

  @override
  String get settingsFoodDbGermany => 'Deutschland';

  @override
  String get settingsFoodDbUK => 'Vereinigtes Königreich';

  @override
  String get settingsFoodDbUS => 'Vereinigte Staaten';

  @override
  String get settingsFoodDbFrance => 'Frankreich';

  @override
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat) {
    return 'Makros manuell: Kalorien $calories · Protein $protein g · Kohlenhydrate $carbs g · Fett $fat g';
  }

  @override
  String get settingsNotificationsSection => 'Benachrichtigungen';

  @override
  String get settingsEnableNotifications => 'Erinnerungen';

  @override
  String get settingsAppearanceSection => 'Sprache';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsAccountSection => 'Konto & Support';

  @override
  String get muscleGroupChest => 'Brust';

  @override
  String get muscleGroupBack => 'Rücken';

  @override
  String get muscleGroupShoulders => 'Schultern';

  @override
  String get muscleGroupBiceps => 'Bizeps';

  @override
  String get muscleGroupTriceps => 'Trizeps';

  @override
  String get muscleGroupLegs => 'Beine';

  @override
  String get muscleGroupGlutes => 'Gesäß';

  @override
  String get muscleGroupCore => 'Rumpf';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Ganzkörper';

  @override
  String get settingsSubscription => 'Abo';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Keine Werbung, dazu der KI-Coach.';

  @override
  String get paywallFeatureNoAds => 'Keine Werbung';

  @override
  String get paywallFeatureAiWorkouts =>
      'Von der KI erstellte Trainingsprogramme';

  @override
  String get paywallFeatureAiMeals => 'Mahlzeiten per Texteingabe erfassen';

  @override
  String get paywallSubscribeButton => 'Abonnieren';

  @override
  String get paywallRestoreButton => 'Käufe wiederherstellen';

  @override
  String get paywallUnavailable => 'Abos sind noch nicht verfügbar.';

  @override
  String get paywallAlreadySubscribed =>
      'Du hast Premium. Danke für deine Unterstützung.';

  @override
  String get paywallPurchaseFailed =>
      'Der Kauf konnte nicht abgeschlossen werden. Bitte versuch es erneut.';

  @override
  String get paywallRestoreSuccess => 'Käufe wiederhergestellt.';

  @override
  String get paywallRestoreNone =>
      'Für dieses Konto wurden keine früheren Käufe gefunden.';

  @override
  String get settingsSendFeedback => 'Feedback senden';

  @override
  String get settingsPrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Konto löschen?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Dein Konto und alle Daten – Workouts, Ernährungseinträge, Fortschritt, alles – werden dauerhaft gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Endgültig löschen';

  @override
  String get settingsDeleteAccountFailed =>
      'Konto konnte nicht gelöscht werden. Bitte versuch es erneut.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '$seconds s';
  }

  @override
  String get mealCardNoItems => 'Noch nichts eingetragen';

  @override
  String get mealCardAddFood => 'Lebensmittel hinzufügen';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes Min. · $count Übungen';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets × $reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Zuletzt: $value';
  }

  @override
  String get restTimerLabel => 'Pause';

  @override
  String get restTimerSubtract => '-15 s';

  @override
  String get restTimerSkip => 'Pause überspringen';

  @override
  String get restTimerAdd => '+30 s';

  @override
  String get splashTagline =>
      'Training, Ernährung und Fortschritt an einem Ort.';

  @override
  String get lineChartNoData => 'Noch keine Daten';

  @override
  String get weightLogButton => 'Gewicht eintragen';

  @override
  String get weightFieldHint => 'Gewicht';

  @override
  String get navHome => 'Start';

  @override
  String get navWorkouts => 'Training';

  @override
  String get navNutrition => 'Ernährung';

  @override
  String get navProgress => 'Fortschritt';

  @override
  String get navProfile => 'Profil';

  @override
  String get weekdayInitials => 'M,D,M,D,F,S,S';

  @override
  String get streakLabel => 'Tage in Folge';

  @override
  String get authErrorInvalidCredentials => 'E-Mail oder Passwort ist falsch.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Bestätige zuerst deine E-Mail. Sieh in deinem Posteingang nach.';

  @override
  String get authErrorUserExists =>
      'Für diese E-Mail gibt es schon ein Konto. Versuch dich anzumelden.';

  @override
  String get authErrorWeakPassword =>
      'Das Passwort ist zu schwach. Nutze mindestens 6 Zeichen.';

  @override
  String get authErrorInvalidEmail =>
      'Diese E-Mail-Adresse sieht nicht richtig aus.';

  @override
  String get authErrorRateLimited =>
      'Zu viele Versuche. Warte eine Minute und versuch es erneut.';

  @override
  String get authErrorNetwork =>
      'Keine Verbindung. Prüf dein Internet und versuch es erneut.';

  @override
  String get authErrorGeneric =>
      'Anmeldung fehlgeschlagen. Bitte versuch es erneut.';

  @override
  String get authErrorMissingFields =>
      'Gib deine E-Mail und dein Passwort ein.';

  @override
  String get authConfirmEmailSent =>
      'Wir haben dir einen Bestätigungslink geschickt. Öffne ihn, um die Registrierung abzuschließen.';

  @override
  String get notifWorkoutTitle => 'Dein Workout wartet';

  @override
  String get notifWorkoutBody =>
      'Heute noch kein Workout eingetragen. Hast du 20 Minuten?';

  @override
  String get notifMealTitle => 'Mahlzeit eintragen';

  @override
  String get notifLunchBody =>
      'Mittagszeit. Trag ein, was du gegessen hast, solange du es noch weißt.';

  @override
  String get notifDinnerBody =>
      'Abendessenszeit. Trag ein, was du gegessen hast, solange du es noch weißt.';

  @override
  String get dayFullBodyA => 'Ganzkörper A';

  @override
  String get dayFullBodyB => 'Ganzkörper B';

  @override
  String get dayFullBodyC => 'Ganzkörper C';

  @override
  String get dayFullBody => 'Ganzkörper';

  @override
  String get dayUpperBodyPower => 'Oberkörper · Kraft';

  @override
  String get dayUpperBodyHypertrophy => 'Oberkörper · Volumen';

  @override
  String get dayUpperBody => 'Oberkörper';

  @override
  String get dayLowerBodyFocus => 'Unterkörper · Kraft';

  @override
  String get dayLowerBody => 'Unterkörper';

  @override
  String get dayPush => 'Push';

  @override
  String get dayPull => 'Pull';

  @override
  String get dayLegsCore => 'Beine & Rumpf';

  @override
  String get dayActiveRecovery => 'Aktive Erholung';

  @override
  String get dayRest => 'Ruhetag';

  @override
  String get programFullBody => 'Ganzkörperprogramm';

  @override
  String get programUpperLower => 'Oberkörper/Unterkörper-Split';

  @override
  String get exBenchPress => 'Bankdrücken';

  @override
  String get exInclineDumbbellPress => 'Schrägbankdrücken mit Kurzhanteln';

  @override
  String get exOverheadPress => 'Schulterdrücken';

  @override
  String get exTricepsPushdown => 'Trizepsdrücken am Kabel';

  @override
  String get exLateralRaise => 'Seitheben';

  @override
  String get exDeadlift => 'Kreuzheben';

  @override
  String get exPullUp => 'Klimmzug';

  @override
  String get exBarbellRow => 'Langhantelrudern';

  @override
  String get exFacePull => 'Face Pull';

  @override
  String get exBicepCurl => 'Bizepscurl';

  @override
  String get exBackSquat => 'Kniebeuge';

  @override
  String get exRomanianDeadlift => 'Rumänisches Kreuzheben';

  @override
  String get exLegPress => 'Beinpresse';

  @override
  String get exWalkingLunge => 'Ausfallschritte im Gehen';

  @override
  String get exPlank => 'Unterarmstütz';

  @override
  String get exGobletSquat => 'Goblet Squat';

  @override
  String get exPushUp => 'Liegestütz';

  @override
  String get exDumbbellRow => 'Kurzhantelrudern';
}
