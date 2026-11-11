// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'THRIVE+';

  @override
  String get settingsScreenTitle => 'Réglages';

  @override
  String get authSignUpTitle => 'Créer un compte';

  @override
  String get authSignInTitle => 'Bon retour';

  @override
  String get authSignUpSubtitle =>
      'Crée un compte, puis on prépare ton plan ensemble.';

  @override
  String get authSignInSubtitle =>
      'Connecte-toi et reprends là où tu t\'es arrêté.';

  @override
  String get authContinueWithApple => 'Continuer avec Apple';

  @override
  String get authContinueWithGoogle => 'Continuer avec Google';

  @override
  String get authOrWithEmail => 'ou avec un e-mail';

  @override
  String get authEmailHint => 'E-mail';

  @override
  String get authPasswordHint => 'Mot de passe';

  @override
  String get authSignUpButton => 'S\'inscrire';

  @override
  String get authSignInButton => 'Se connecter';

  @override
  String get authSwitchToSignIn => 'Déjà un compte ? Se connecter';

  @override
  String get authSwitchToSignUp => 'Nouveau ? Créer un compte';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authResetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get authResetPasswordMessage =>
      'Saisis ton e-mail, on t\'envoie un lien de réinitialisation.';

  @override
  String get authResetPasswordSend => 'Envoyer le lien';

  @override
  String get authResetPasswordSent =>
      'Si cet e-mail existe, un lien a été envoyé.';

  @override
  String get authResetPasswordFailed =>
      'Impossible d\'envoyer le lien. Réessaie.';

  @override
  String get authNewPasswordTitle => 'Nouveau mot de passe';

  @override
  String get authNewPasswordHint => 'Nouveau mot de passe';

  @override
  String get authNewPasswordButton => 'Mettre à jour';

  @override
  String get authNewPasswordSuccess => 'Mot de passe mis à jour.';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingWelcomeHeadline =>
      'Entraînement et alimentation, dans un seul plan.';

  @override
  String get onboardingWelcomeSubtitle =>
      'Quelques questions rapides, puis on crée un programme et un objectif calorique qui te correspondent.';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboardingNameTitle => 'Comment on t\'appelle ?';

  @override
  String get onboardingNameHint => 'Ton prénom';

  @override
  String get onboardingGenderTitle => 'Quel est ton sexe ?';

  @override
  String get onboardingGenderMale => 'Homme';

  @override
  String get onboardingGenderFemale => 'Femme';

  @override
  String get onboardingGenderUnspecified => 'Je préfère ne pas répondre';

  @override
  String get onboardingAgeTitle => 'Quel âge as-tu ?';

  @override
  String get onboardingHeightTitle => 'Ta taille (cm)';

  @override
  String get onboardingWeightTitle => 'Ton poids (kg)';

  @override
  String get onboardingTargetWeightTitle => 'Poids cible (kg)';

  @override
  String get onboardingFitnessLevelTitle => 'Quel est ton niveau ?';

  @override
  String get fitnessBeginnerLabel => 'Débutant';

  @override
  String get fitnessBeginnerSubtitle =>
      'J\'apprends les mouvements de base (0-1 an)';

  @override
  String get fitnessIntermediateLabel => 'Intermédiaire';

  @override
  String get fitnessIntermediateSubtitle =>
      'Je m\'entraîne régulièrement (1-3 ans)';

  @override
  String get fitnessAdvancedLabel => 'Avancé';

  @override
  String get fitnessAdvancedSubtitle =>
      'Charges lourdes et périodisation (3 ans et +)';

  @override
  String get onboardingPrimaryGoalTitle => 'Quel est ton objectif principal ?';

  @override
  String get goalLoseWeight => 'Perdre du poids';

  @override
  String get goalBuildMuscle => 'Prendre du muscle';

  @override
  String get goalLoseFat => 'Perdre du gras';

  @override
  String get goalMaintainFitness => 'Rester en forme';

  @override
  String get onboardingDaysPerWeekTitle =>
      'Combien de jours par semaine veux-tu t\'entraîner ?';

  @override
  String get onboardingMostPopular => 'Le plus choisi';

  @override
  String get onboardingDurationTitle =>
      'Combien de temps doivent durer tes séances ?';

  @override
  String onboardingDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get onboardingLocationTitle => 'Où t\'entraînes-tu ?';

  @override
  String get locationGym => 'Salle';

  @override
  String get locationHome => 'Maison';

  @override
  String get locationBoth => 'Les deux';

  @override
  String get onboardingEquipmentLabel => 'Matériel';

  @override
  String get onboardingActivityLevelTitle =>
      'Quel est ton niveau d\'activité au quotidien ?';

  @override
  String get activitySedentaryLabel => 'Sédentaire';

  @override
  String get activitySedentarySubtitle => 'Travail de bureau, peu de mouvement';

  @override
  String get activityModeratelyActiveLabel => 'Modérément actif';

  @override
  String get activityModeratelyActiveSubtitle => '~7 500 pas/jour';

  @override
  String get activityVeryActiveLabel => 'Très actif';

  @override
  String get activityVeryActiveSubtitle => '10 000+ pas/jour, travail physique';

  @override
  String get onboardingNutritionPrefTitle => 'Quelle est ton alimentation ?';

  @override
  String get nutritionStandard => 'Classique';

  @override
  String get nutritionHighProtein => 'Riche en protéines';

  @override
  String get nutritionKeto => 'Cétogène';

  @override
  String get nutritionVegetarian => 'Végétarienne';

  @override
  String get nutritionVegan => 'Végane';

  @override
  String get onboardingCalculatingLine1 => 'Calcul de tes besoins caloriques…';

  @override
  String get onboardingCalculatingLine2 =>
      'Préparation de ton programme de la semaine…';

  @override
  String onboardingPlanReadyTitle(String name) {
    return '$name, ton plan est prêt';
  }

  @override
  String get onboardingDefaultName => 'Athlète';

  @override
  String get onboardingDailyCalories => 'Calories par jour';

  @override
  String get macroProtein => 'Protéines';

  @override
  String get macroCarbs => 'Glucides';

  @override
  String get macroFat => 'Lipides';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return '$days jours par semaine';
  }

  @override
  String get onboardingPlanTagline => 'Force et composition corporelle';

  @override
  String get onboardingStartMyPlan => 'Démarrer mon plan';

  @override
  String get homeGreetingMorning => 'Bonjour';

  @override
  String get homeGreetingAfternoon => 'Bon après-midi';

  @override
  String get homeGreetingEvening => 'Bonsoir';

  @override
  String get homeDefaultAthleteName => 'Athlète';

  @override
  String homeCaloriesLeft(int count) {
    return 'encore $count';
  }

  @override
  String get homeTodaysWorkoutLabel => 'SÉANCE DU JOUR';

  @override
  String get homeRestDayMessage =>
      'Jour de repos. La récupération fait partie du plan.';

  @override
  String get homeNoWorkoutPlanned => 'Aucune séance prévue pour l\'instant.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '$minutes min · $count exercices';
  }

  @override
  String get homeStartWorkout => 'Commencer la séance';

  @override
  String get homeWeightGoalLabel => 'OBJECTIF DE POIDS';

  @override
  String homeWeightRemaining(String kg) {
    return 'Encore $kg kg';
  }

  @override
  String get homeQuickActionAddMeal => 'Repas';

  @override
  String get homeQuickActionLogWeight => 'Poids';

  @override
  String get homeQuickActionViewProgress => 'Progrès';

  @override
  String genericError(String error) {
    return 'Erreur : $error';
  }

  @override
  String get commonCancel => 'Annuler';

  @override
  String get weekdayMonday => 'Lundi';

  @override
  String get weekdayTuesday => 'Mardi';

  @override
  String get weekdayWednesday => 'Mercredi';

  @override
  String get weekdayThursday => 'Jeudi';

  @override
  String get weekdayFriday => 'Vendredi';

  @override
  String get weekdaySaturday => 'Samedi';

  @override
  String get weekdaySunday => 'Dimanche';

  @override
  String get workoutsScreenTitle => 'Cette semaine';

  @override
  String get workoutsAiUpdateTooltip => 'Mettre à jour avec l\'IA';

  @override
  String workoutsAiUpdateFailedSnackbar(String error) {
    return 'L\'IA n\'a pas pu mettre à jour le programme : $error';
  }

  @override
  String workoutsFailedToLoad(String error) {
    return 'Impossible de charger le programme : $error';
  }

  @override
  String get workoutsOnboardingCta =>
      'Termine la configuration pour générer ton programme de la semaine.';

  @override
  String get workoutsCreateMyPlan => 'Créer mon plan';

  @override
  String get activeWorkoutNoExercises => 'Aucun exercice ce jour-là.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return 'Exercice $current sur $total';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'Série $current sur $total';
  }

  @override
  String activeWorkoutTarget(String weight, String reps) {
    return 'Objectif : $weight kg × $reps rép.';
  }

  @override
  String get activeWorkoutWeightLabel => 'POIDS (KG)';

  @override
  String get activeWorkoutRepsLabel => 'RÉP.';

  @override
  String get activeWorkoutSkipExercise => 'Passer l\'exercice';

  @override
  String get activeWorkoutAddSet => 'Ajouter une série';

  @override
  String get activeWorkoutCompleteSet => 'Valider la série';

  @override
  String get activeWorkoutEndTitle => 'Terminer la séance ?';

  @override
  String get activeWorkoutEndContent =>
      'Ta progression sur cette séance sera perdue.';

  @override
  String get activeWorkoutEndConfirm => 'Terminer la séance';

  @override
  String get workoutDetailNotFound => 'Séance introuvable';

  @override
  String get workoutDetailStartButton => 'Commencer la séance';

  @override
  String get workoutSummarySessionNotFound => 'Séance introuvable';

  @override
  String get workoutSummaryComplete => 'Séance terminée';

  @override
  String get workoutSummaryDuration => 'Durée';

  @override
  String get workoutSummaryTotalVolume => 'Volume total';

  @override
  String get workoutSummarySetsCompleted => 'Séries';

  @override
  String get workoutSummaryEstCalories => 'kcal estimées';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'Nouveau record : $weight kg × $reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Bonne séance. Chaque série enregistrée rend le plan de la semaine prochaine plus précis.';

  @override
  String get workoutSummaryFinish => 'Terminé';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get nutritionToday => 'Aujourd\'hui';

  @override
  String nutritionCaloriesProgress(int consumed, int goal) {
    return '$consumed / $goal kcal';
  }

  @override
  String get mealTypeBreakfast => 'Petit-déjeuner';

  @override
  String get mealTypeLunch => 'Déjeuner';

  @override
  String get mealTypeDinner => 'Dîner';

  @override
  String get mealTypeSnack => 'Collation';

  @override
  String foodLoggerTitle(String mealType) {
    return 'Ajouter au $mealType';
  }

  @override
  String get foodLoggerSearchTab => 'Rechercher';

  @override
  String get foodLoggerQuickAddTab => 'Ajout rapide';

  @override
  String get foodLoggerSearchHint => 'Rechercher un aliment ou une marque...';

  @override
  String get barcodeScannerTitle => 'Scanner un code-barres';

  @override
  String get barcodeScannerHint =>
      'Vise le code-barres du produit avec l\'appareil photo';

  @override
  String get barcodeScannerNotFound =>
      'Aucun produit trouvé pour ce code-barres.';

  @override
  String get aiChatTitle => 'Coach IA';

  @override
  String get aiChatInputHint =>
      'Pose une question sur l\'entraînement, l\'alimentation ou la récupération';

  @override
  String get aiChatEmptyState =>
      'Pose-moi tes questions sur l\'entraînement, la nutrition ou la récupération.';

  @override
  String aiChatRemainingToday(int count) {
    return 'Encore $count messages aujourd\'hui';
  }

  @override
  String get aiChatLimitReached =>
      'Tu as atteint la limite de messages du jour. Elle se réinitialise demain.';

  @override
  String get healthConnectPrompt =>
      'Connecte Apple Santé ou Health Connect pour voir tes pas et calories brûlées';

  @override
  String get healthStepsLabel => 'Pas';

  @override
  String get healthCaloriesBurnedLabel => 'kcal actives';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total débloqués';
  }

  @override
  String get achievementFirstWorkoutTitle => 'Premier pas';

  @override
  String get achievementFirstWorkoutDesc => 'Termine ta première séance';

  @override
  String get achievementWorkout5Title => 'C\'est parti';

  @override
  String get achievementWorkout5Desc => 'Termine 5 séances';

  @override
  String get achievementWorkout25Title => 'Régulier';

  @override
  String get achievementWorkout25Desc => 'Termine 25 séances';

  @override
  String get achievementWorkout100Title => 'Club des 100';

  @override
  String get achievementWorkout100Desc => 'Termine 100 séances';

  @override
  String get achievementFirstPrTitle => 'Nouveau record';

  @override
  String get achievementFirstPrDesc => 'Bats ton premier record personnel';

  @override
  String get achievementStreak3Title => 'Sur la lancée';

  @override
  String get achievementStreak3Desc => '3 jours d\'affilée';

  @override
  String get achievementStreak7Title => 'Une semaine solide';

  @override
  String get achievementStreak7Desc => '7 jours d\'affilée';

  @override
  String get achievementStreak30Title => 'Inarrêtable';

  @override
  String get achievementStreak30Desc => '30 jours d\'affilée';

  @override
  String get achievementWeightLogged5Title => 'Bien suivi';

  @override
  String get achievementWeightLogged5Desc => 'Enregistre ton poids 5 fois';

  @override
  String get achievementWeightLogged30Title => 'Accro aux données';

  @override
  String get achievementWeightLogged30Desc => 'Enregistre ton poids 30 fois';

  @override
  String get waterCardTitle => 'Eau';

  @override
  String waterCardAmount(int consumed, int goal) {
    return '$consumed/$goal ml';
  }

  @override
  String get foodLoggerNoResultsTitle => 'Aucun résultat';

  @override
  String get foodLoggerNoResultsMessage =>
      'Essaie un autre terme de recherche.';

  @override
  String foodLoggerNutritionSummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal / 100 g • P:$protein g G:$carbs g L:$fat g';
  }

  @override
  String foodLoggerQuantitySummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal — P : $protein g, G : $carbs g, L : $fat g';
  }

  @override
  String get foodLoggerAiHint =>
      'ex. 3 œufs, 100 g de riz, une poignée d\'amandes';

  @override
  String get foodLoggerAiFillButton => 'Remplir avec l\'IA';

  @override
  String get foodLoggerAiParsing => 'Analyse...';

  @override
  String get foodLoggerOrManualEntry => 'ou saisir manuellement';

  @override
  String foodLoggerAiParseFailedSnackbar(String error) {
    return 'L\'IA n\'a pas pu analyser le repas : $error';
  }

  @override
  String get quickAddCaloriesLabel => 'Calories';

  @override
  String get quickAddProteinLabel => 'Protéines (g)';

  @override
  String get quickAddCarbsLabel => 'Glucides (g)';

  @override
  String get quickAddFatLabel => 'Lipides (g)';

  @override
  String get quickAddEntryDefaultName => 'Ajout rapide';

  @override
  String get progressScreenTitle => 'Progrès';

  @override
  String get progressTabWeight => 'Poids';

  @override
  String get progressTabStrength => 'Force';

  @override
  String get progressTabConsistency => 'Régularité';

  @override
  String get progressTabMeasurements => 'Mensurations';

  @override
  String get progressWeightChartTitle => 'Poids (kg)';

  @override
  String get progressStrengthEmptyTitle => 'Pas encore de données de force';

  @override
  String get progressStrengthEmptyMessage =>
      'Termine une séance pour suivre ton 1RM estimé.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise';
  }

  @override
  String get progressCurrentStreak => 'Série en cours';

  @override
  String get progressLongestStreak => 'Plus longue série';

  @override
  String get progressConsistencyLabel => 'Régularité';

  @override
  String get measurementWaist => 'Taille';

  @override
  String get measurementNeck => 'Cou';

  @override
  String get measurementHip => 'Hanches';

  @override
  String get measurementChest => 'Poitrine';

  @override
  String get measurementBiceps => 'Biceps';

  @override
  String get measurementThigh => 'Cuisse';

  @override
  String get measurementsBodyFatHint =>
      'Ajoute ton tour de taille et de cou pour voir ton taux de masse grasse.';

  @override
  String measurementsBodyFatLabel(String category) {
    return 'Masse grasse · $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Graisse essentielle';

  @override
  String get bodyFatCategoryAthletic => 'Athlétique';

  @override
  String get bodyFatCategoryFitness => 'En forme';

  @override
  String get bodyFatCategoryAverage => 'Moyenne';

  @override
  String get bodyFatCategoryHigh => 'Élevée';

  @override
  String get measurementsAddButton => 'Ajouter une mesure';

  @override
  String get measurementsEmptyTitle => 'Pas encore de mesures';

  @override
  String get measurementsEmptyMessage =>
      'Ajoute ta première mesure pour commencer le suivi.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Ajouter une mesure';

  @override
  String measurementsFieldHint(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String profileLoadError(String error) {
    return 'Impossible de charger le profil : $error';
  }

  @override
  String get profileEmptyTitle => 'Pas encore de profil';

  @override
  String get profileEmptyMessage =>
      'Termine la configuration pour créer ton profil.';

  @override
  String get bioAge => 'Âge';

  @override
  String get bioHeight => 'Taille';

  @override
  String get bioWeight => 'Poids';

  @override
  String get bioLevel => 'Niveau';

  @override
  String get profileGoalsTile => 'Objectifs';

  @override
  String get profileSignOut => 'Se déconnecter';

  @override
  String get goalsEmptyTitle => 'Aucun objectif';

  @override
  String get goalsEmptyMessage =>
      'Termine la configuration pour définir tes objectifs.';

  @override
  String get goalsCurrentLabel => 'Actuel';

  @override
  String get goalsTargetLabel => 'Objectif';

  @override
  String get goalsRemainingLabel => 'Restant';

  @override
  String get goalsWeeklyWorkoutLabel => 'SÉANCES PAR SEMAINE';

  @override
  String get goalsDailyCalorieLabel => 'CALORIES PAR JOUR';

  @override
  String get goalsProteinLabel => 'PROTÉINES PAR JOUR';

  @override
  String get settingsWorkoutSection => 'Entraînement';

  @override
  String get settingsDefaultRestTime => 'Temps de repos par défaut';

  @override
  String get settingsAutoStartNextSet =>
      'Lancer la série suivante automatiquement';

  @override
  String get settingsWeightUnit => 'Unité de poids';

  @override
  String get settingsDistanceUnit => 'Unité de distance';

  @override
  String get settingsSound => 'Son';

  @override
  String get settingsHaptics => 'Vibrations';

  @override
  String get settingsCountdownBeep => 'Bip de compte à rebours (3-2-1)';

  @override
  String get settingsNutritionSection => 'Nutrition';

  @override
  String get settingsAutoCalculateTargets =>
      'Calculer les objectifs automatiquement (TDEE)';

  @override
  String get settingsFoodDatabase => 'Base d\'aliments';

  @override
  String get settingsFoodDbGlobal => 'Mondiale (toutes)';

  @override
  String get settingsFoodDbTurkey => 'Turquie';

  @override
  String get settingsFoodDbGermany => 'Allemagne';

  @override
  String get settingsFoodDbUK => 'Royaume-Uni';

  @override
  String get settingsFoodDbUS => 'États-Unis';

  @override
  String get settingsFoodDbFrance => 'France';

  @override
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat) {
    return 'Macros manuelles : Calories $calories · Protéines $protein g · Glucides $carbs g · Lipides $fat g';
  }

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsEnableNotifications => 'Rappels';

  @override
  String get settingsAppearanceSection => 'Langue';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Système';

  @override
  String get settingsAccountSection => 'Compte et assistance';

  @override
  String get muscleGroupChest => 'Pectoraux';

  @override
  String get muscleGroupBack => 'Dos';

  @override
  String get muscleGroupShoulders => 'Épaules';

  @override
  String get muscleGroupBiceps => 'Biceps';

  @override
  String get muscleGroupTriceps => 'Triceps';

  @override
  String get muscleGroupLegs => 'Jambes';

  @override
  String get muscleGroupGlutes => 'Fessiers';

  @override
  String get muscleGroupCore => 'Gainage';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Corps entier';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Sans publicité, avec le coach IA.';

  @override
  String get paywallFeatureNoAds => 'Sans publicité';

  @override
  String get paywallFeatureAiWorkouts =>
      'Programmes d\'entraînement créés par l\'IA';

  @override
  String get paywallFeatureAiMeals => 'Saisis tes repas en les décrivant';

  @override
  String get paywallSubscribeButton => 'S\'abonner';

  @override
  String get paywallRestoreButton => 'Restaurer les achats';

  @override
  String get paywallUnavailable =>
      'Les abonnements ne sont pas encore disponibles.';

  @override
  String get paywallAlreadySubscribed =>
      'Tu as déjà Premium. Merci pour ton soutien.';

  @override
  String get paywallPurchaseFailed => 'L\'achat n\'a pas pu aboutir. Réessaie.';

  @override
  String get paywallRestoreSuccess => 'Achats restaurés.';

  @override
  String get paywallRestoreNone =>
      'Aucun achat précédent trouvé pour ce compte.';

  @override
  String get settingsSendFeedback => 'Envoyer un avis';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Supprimer ton compte ?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Ton compte et toutes tes données (séances, repas, progrès, tout) seront supprimés définitivement. Cette action est irréversible.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Supprimer définitivement';

  @override
  String get settingsDeleteAccountFailed =>
      'Impossible de supprimer le compte. Réessaie.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '$seconds s';
  }

  @override
  String get mealCardNoItems => 'Rien d\'enregistré pour l\'instant';

  @override
  String get mealCardAddFood => 'Ajouter un aliment';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes min · $count exercices';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets × $reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Dernière : $value';
  }

  @override
  String get restTimerLabel => 'Repos';

  @override
  String get restTimerSubtract => '-15 s';

  @override
  String get restTimerSkip => 'Passer le repos';

  @override
  String get restTimerAdd => '+30 s';

  @override
  String get splashTagline =>
      'Entraînement, alimentation et progrès au même endroit.';

  @override
  String get lineChartNoData => 'Pas encore de données';

  @override
  String get weightLogButton => 'Enregistrer le poids';

  @override
  String get weightFieldHint => 'Poids';

  @override
  String get navHome => 'Accueil';

  @override
  String get navWorkouts => 'Séances';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navProgress => 'Progrès';

  @override
  String get navProfile => 'Profil';

  @override
  String get weekdayInitials => 'L,M,M,J,V,S,D';

  @override
  String get streakLabel => 'jours d\'affilée';

  @override
  String get authErrorInvalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirme d\'abord ton e-mail. Regarde ta boîte de réception.';

  @override
  String get authErrorUserExists =>
      'Un compte existe déjà avec cet e-mail. Essaie de te connecter.';

  @override
  String get authErrorWeakPassword =>
      'Mot de passe trop faible. Utilise au moins 6 caractères.';

  @override
  String get authErrorInvalidEmail =>
      'Cette adresse e-mail ne semble pas valide.';

  @override
  String get authErrorRateLimited =>
      'Trop de tentatives. Attends une minute et réessaie.';

  @override
  String get authErrorNetwork =>
      'Pas de connexion. Vérifie ton internet et réessaie.';

  @override
  String get authErrorGeneric => 'Connexion impossible. Réessaie.';

  @override
  String get authErrorMissingFields => 'Saisis ton e-mail et ton mot de passe.';

  @override
  String get authConfirmEmailSent =>
      'On t\'a envoyé un lien de confirmation par e-mail. Ouvre-le pour finaliser l\'inscription.';

  @override
  String get notifWorkoutTitle => 'Ta séance t\'attend';

  @override
  String get notifWorkoutBody =>
      'Aucune séance enregistrée aujourd\'hui. Tu as 20 minutes ?';

  @override
  String get notifMealTitle => 'Enregistre ton repas';

  @override
  String get notifLunchBody =>
      'C\'est l\'heure du déjeuner. Note ce que tu as mangé tant que tu t\'en souviens.';

  @override
  String get notifDinnerBody =>
      'C\'est l\'heure du dîner. Note ce que tu as mangé tant que tu t\'en souviens.';

  @override
  String get dayFullBodyA => 'Full body A';

  @override
  String get dayFullBodyB => 'Full body B';

  @override
  String get dayFullBodyC => 'Full body C';

  @override
  String get dayFullBody => 'Full body';

  @override
  String get dayUpperBodyPower => 'Haut du corps · Force';

  @override
  String get dayUpperBodyHypertrophy => 'Haut du corps · Volume';

  @override
  String get dayUpperBody => 'Haut du corps';

  @override
  String get dayLowerBodyFocus => 'Bas du corps · Force';

  @override
  String get dayLowerBody => 'Bas du corps';

  @override
  String get dayPush => 'Poussée';

  @override
  String get dayPull => 'Tirage';

  @override
  String get dayLegsCore => 'Jambes et gainage';

  @override
  String get dayActiveRecovery => 'Récupération active';

  @override
  String get dayRest => 'Repos';

  @override
  String get programFullBody => 'Programme full body';

  @override
  String get programUpperLower => 'Split haut/bas';

  @override
  String get exBenchPress => 'Développé couché';

  @override
  String get exInclineDumbbellPress => 'Développé incliné haltères';

  @override
  String get exOverheadPress => 'Développé militaire';

  @override
  String get exTricepsPushdown => 'Extension triceps à la poulie';

  @override
  String get exLateralRaise => 'Élévations latérales';

  @override
  String get exDeadlift => 'Soulevé de terre';

  @override
  String get exPullUp => 'Tractions';

  @override
  String get exBarbellRow => 'Rowing barre';

  @override
  String get exFacePull => 'Face pull';

  @override
  String get exBicepCurl => 'Curl biceps';

  @override
  String get exBackSquat => 'Squat';

  @override
  String get exRomanianDeadlift => 'Soulevé de terre roumain';

  @override
  String get exLegPress => 'Presse à cuisses';

  @override
  String get exWalkingLunge => 'Fentes marchées';

  @override
  String get exPlank => 'Gainage';

  @override
  String get exGobletSquat => 'Goblet squat';

  @override
  String get exPushUp => 'Pompes';

  @override
  String get exDumbbellRow => 'Rowing haltère';

  @override
  String activeWorkoutLastTime(String value) {
    return 'La dernière fois : $value';
  }

  @override
  String get activeWorkoutSetHeader => 'SÉRIE';

  @override
  String get activeWorkoutPreviousHeader => 'PRÉCÉDENT';

  @override
  String get activeWorkoutExercisesHeader => 'EXERCICES';

  @override
  String activeWorkoutCurrentSet(int number) {
    return 'Série $number';
  }

  @override
  String activeWorkoutRestNext(String label) {
    return 'Ensuite : $label';
  }

  @override
  String activeWorkoutFinishContent(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tes $count séries terminées seront enregistrées.',
      one: 'Ta série terminée sera enregistrée.',
    );
    return '$_temp0';
  }

  @override
  String get activeWorkoutFinishSave => 'Terminer et enregistrer';

  @override
  String get activeWorkoutDiscard => 'Abandonner la séance';

  @override
  String get activeWorkoutKeepGoing => 'Continuer';

  @override
  String get activeWorkoutFinishNow => 'Terminer';

  @override
  String activeWorkoutSetsDone(int done, int total) {
    return '$done/$total séries';
  }

  @override
  String workoutSummaryExerciseLine(int sets, String best) {
    String _temp0 = intl.Intl.pluralLogic(
      sets,
      locale: localeName,
      other: '$sets séries',
      one: '1 série',
    );
    return '$_temp0 · meilleure $best';
  }

  @override
  String get workoutDetailMuscles => 'Muscles';

  @override
  String workoutDetailRest(int seconds) {
    return '$seconds s de repos';
  }

  @override
  String get equipmentBarbell => 'Barre';

  @override
  String get equipmentDumbbell => 'Haltères';

  @override
  String get equipmentBench => 'Banc';

  @override
  String get equipmentCable => 'Poulie';

  @override
  String get equipmentMachine => 'Machines';

  @override
  String get equipmentResistanceBand => 'Élastique';

  @override
  String get equipmentBodyweight => 'Poids du corps';

  @override
  String get equipmentKettlebell => 'Kettlebell';

  @override
  String get aiChatSuggestion1 =>
      'De combien de protéines ai-je besoin par jour ?';

  @override
  String get aiChatSuggestion2 => 'Que manger avant l\'entraînement ?';

  @override
  String get aiChatSuggestion3 =>
      'Je stagne au développé couché. Que changer ?';

  @override
  String get paywallAutoRenewNote =>
      'Renouvellement automatique jusqu\'à résiliation. Tu peux résilier à tout moment dans les réglages de l\'App Store ou de Google Play.';

  @override
  String get paywallTerms => 'Conditions d\'utilisation';
}
