// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'THRIVE+';

  @override
  String get settingsScreenTitle => 'Ajustes';

  @override
  String get authSignUpTitle => 'Crear cuenta';

  @override
  String get authSignInTitle => 'Hola de nuevo';

  @override
  String get authSignUpSubtitle =>
      'Crea una cuenta y preparamos tu plan juntos.';

  @override
  String get authSignInSubtitle => 'Inicia sesión y sigue donde lo dejaste.';

  @override
  String get authContinueWithApple => 'Continuar con Apple';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authOrWithEmail => 'o con correo';

  @override
  String get authEmailHint => 'Correo electrónico';

  @override
  String get authPasswordHint => 'Contraseña';

  @override
  String get authSignUpButton => 'Registrarse';

  @override
  String get authSignInButton => 'Iniciar sesión';

  @override
  String get authSwitchToSignIn => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get authSwitchToSignUp => '¿Eres nuevo? Crea una cuenta';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authResetPasswordTitle => 'Restablecer contraseña';

  @override
  String get authResetPasswordMessage =>
      'Escribe tu correo y te enviaremos un enlace para restablecerla.';

  @override
  String get authResetPasswordSend => 'Enviar enlace';

  @override
  String get authResetPasswordSent =>
      'Si ese correo está registrado, te hemos enviado un enlace.';

  @override
  String get authResetPasswordFailed =>
      'No se pudo enviar el enlace. Inténtalo de nuevo.';

  @override
  String get authNewPasswordTitle => 'Nueva contraseña';

  @override
  String get authNewPasswordHint => 'Nueva contraseña';

  @override
  String get authNewPasswordButton => 'Actualizar contraseña';

  @override
  String get authNewPasswordSuccess => 'Contraseña actualizada.';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingWelcomeHeadline =>
      'Entrenamiento y alimentación, en un solo plan.';

  @override
  String get onboardingWelcomeSubtitle =>
      'Unas preguntas rápidas y preparamos un programa y un objetivo de calorías a tu medida.';

  @override
  String get onboardingGetStarted => 'Empezar';

  @override
  String get onboardingNameTitle => '¿Cómo te llamamos?';

  @override
  String get onboardingNameHint => 'Tu nombre';

  @override
  String get onboardingGenderTitle => '¿Cuál es tu sexo?';

  @override
  String get onboardingGenderMale => 'Hombre';

  @override
  String get onboardingGenderFemale => 'Mujer';

  @override
  String get onboardingGenderUnspecified => 'Prefiero no decirlo';

  @override
  String get onboardingAgeTitle => '¿Cuántos años tienes?';

  @override
  String get onboardingHeightTitle => 'Tu altura (cm)';

  @override
  String get onboardingWeightTitle => 'Tu peso (kg)';

  @override
  String get onboardingTargetWeightTitle => 'Peso objetivo (kg)';

  @override
  String get onboardingFitnessLevelTitle => '¿Cuál es tu nivel?';

  @override
  String get fitnessBeginnerLabel => 'Principiante';

  @override
  String get fitnessBeginnerSubtitle =>
      'Aprendiendo la técnica básica (0-1 año)';

  @override
  String get fitnessIntermediateLabel => 'Intermedio';

  @override
  String get fitnessIntermediateSubtitle =>
      'Entreno con regularidad (1-3 años)';

  @override
  String get fitnessAdvancedLabel => 'Avanzado';

  @override
  String get fitnessAdvancedSubtitle =>
      'Entreno pesado y periodización (3+ años)';

  @override
  String get onboardingPrimaryGoalTitle => '¿Cuál es tu objetivo principal?';

  @override
  String get goalLoseWeight => 'Perder peso';

  @override
  String get goalBuildMuscle => 'Ganar músculo';

  @override
  String get goalLoseFat => 'Perder grasa';

  @override
  String get goalMaintainFitness => 'Mantenerme en forma';

  @override
  String get onboardingDaysPerWeekTitle =>
      '¿Cuántos días a la semana quieres entrenar?';

  @override
  String get onboardingMostPopular => 'El más elegido';

  @override
  String get onboardingDurationTitle =>
      '¿Cuánto deben durar tus entrenamientos?';

  @override
  String onboardingDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get onboardingLocationTitle => '¿Dónde entrenas?';

  @override
  String get locationGym => 'Gimnasio';

  @override
  String get locationHome => 'Casa';

  @override
  String get locationBoth => 'Ambos';

  @override
  String get onboardingEquipmentLabel => 'Material';

  @override
  String get onboardingActivityLevelTitle =>
      '¿Cómo de activo eres en tu día a día?';

  @override
  String get activitySedentaryLabel => 'Sedentario';

  @override
  String get activitySedentarySubtitle => 'Trabajo de oficina, poco movimiento';

  @override
  String get activityModeratelyActiveLabel => 'Moderadamente activo';

  @override
  String get activityModeratelyActiveSubtitle => '~7.500 pasos/día';

  @override
  String get activityVeryActiveLabel => 'Muy activo';

  @override
  String get activityVeryActiveSubtitle =>
      'Más de 10.000 pasos/día, trabajo físico';

  @override
  String get onboardingNutritionPrefTitle =>
      '¿Qué tipo de alimentación sigues?';

  @override
  String get nutritionStandard => 'Estándar';

  @override
  String get nutritionHighProtein => 'Alta en proteína';

  @override
  String get nutritionKeto => 'Cetogénica';

  @override
  String get nutritionVegetarian => 'Vegetariana';

  @override
  String get nutritionVegan => 'Vegana';

  @override
  String get onboardingCalculatingLine1 =>
      'Calculando tus necesidades de calorías…';

  @override
  String get onboardingCalculatingLine2 => 'Preparando tu programa semanal…';

  @override
  String onboardingPlanReadyTitle(String name) {
    return '$name, tu plan está listo';
  }

  @override
  String get onboardingDefaultName => 'Atleta';

  @override
  String get onboardingDailyCalories => 'Calorías diarias';

  @override
  String get macroProtein => 'Proteína';

  @override
  String get macroCarbs => 'Carbohidratos';

  @override
  String get macroFat => 'Grasa';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return '$days días a la semana';
  }

  @override
  String get onboardingPlanTagline => 'Fuerza y composición corporal';

  @override
  String get onboardingStartMyPlan => 'Empezar mi plan';

  @override
  String get homeGreetingMorning => 'Buenos días';

  @override
  String get homeGreetingAfternoon => 'Buenas tardes';

  @override
  String get homeGreetingEvening => 'Buenas noches';

  @override
  String get homeDefaultAthleteName => 'Atleta';

  @override
  String homeCaloriesLeft(int count) {
    return 'quedan $count';
  }

  @override
  String get homeTodaysWorkoutLabel => 'ENTRENAMIENTO DE HOY';

  @override
  String get homeRestDayMessage =>
      'Día de descanso. Recuperar también es parte del plan.';

  @override
  String get homeNoWorkoutPlanned => 'Aún no hay entrenamiento planificado.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '$minutes min · $count ejercicios';
  }

  @override
  String get homeStartWorkout => 'Empezar entrenamiento';

  @override
  String get homeWeightGoalLabel => 'OBJETIVO DE PESO';

  @override
  String homeWeightRemaining(String kg) {
    return 'Faltan $kg kg';
  }

  @override
  String get homeQuickActionAddMeal => 'Comida';

  @override
  String get homeQuickActionLogWeight => 'Peso';

  @override
  String get homeQuickActionViewProgress => 'Progreso';

  @override
  String genericError(String error) {
    return 'Error: $error';
  }

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get weekdayMonday => 'Lunes';

  @override
  String get weekdayTuesday => 'Martes';

  @override
  String get weekdayWednesday => 'Miércoles';

  @override
  String get weekdayThursday => 'Jueves';

  @override
  String get weekdayFriday => 'Viernes';

  @override
  String get weekdaySaturday => 'Sábado';

  @override
  String get weekdaySunday => 'Domingo';

  @override
  String get workoutsScreenTitle => 'Esta semana';

  @override
  String get workoutsAiUpdateTooltip => 'Actualizar con IA';

  @override
  String workoutsAiUpdateFailedSnackbar(String error) {
    return 'La IA no pudo actualizar el programa: $error';
  }

  @override
  String workoutsFailedToLoad(String error) {
    return 'No se pudo cargar el programa: $error';
  }

  @override
  String get workoutsOnboardingCta =>
      'Completa la configuración para generar tu programa semanal.';

  @override
  String get workoutsCreateMyPlan => 'Crear mi plan';

  @override
  String get activeWorkoutNoExercises => 'No hay ejercicios para este día.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return 'Ejercicio $current de $total';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'Serie $current de $total';
  }

  @override
  String activeWorkoutTarget(String weight, String reps) {
    return 'Objetivo: $weight kg × $reps reps';
  }

  @override
  String get activeWorkoutWeightLabel => 'PESO (KG)';

  @override
  String get activeWorkoutRepsLabel => 'REPS';

  @override
  String get activeWorkoutSkipExercise => 'Saltar ejercicio';

  @override
  String get activeWorkoutAddSet => 'Añadir serie';

  @override
  String get activeWorkoutCompleteSet => 'Completar serie';

  @override
  String get activeWorkoutEndTitle => '¿Terminar entrenamiento?';

  @override
  String get activeWorkoutEndContent =>
      'Se perderá el progreso de esta sesión.';

  @override
  String get activeWorkoutEndConfirm => 'Terminar';

  @override
  String get workoutDetailNotFound => 'Entrenamiento no encontrado';

  @override
  String get workoutDetailStartButton => 'Empezar entrenamiento';

  @override
  String get workoutSummarySessionNotFound => 'Sesión no encontrada';

  @override
  String get workoutSummaryComplete => 'Entrenamiento completado';

  @override
  String get workoutSummaryDuration => 'Duración';

  @override
  String get workoutSummaryTotalVolume => 'Volumen total';

  @override
  String get workoutSummarySetsCompleted => 'Series';

  @override
  String get workoutSummaryEstCalories => 'kcal estimadas';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'Nuevo récord: $weight kg × $reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Buena sesión. Cada serie que registras hace más preciso el plan de la próxima semana.';

  @override
  String get workoutSummaryFinish => 'Listo';

  @override
  String get commonAdd => 'Añadir';

  @override
  String get nutritionToday => 'Hoy';

  @override
  String nutritionCaloriesProgress(int consumed, int goal) {
    return '$consumed / $goal kcal';
  }

  @override
  String get mealTypeBreakfast => 'Desayuno';

  @override
  String get mealTypeLunch => 'Almuerzo';

  @override
  String get mealTypeDinner => 'Cena';

  @override
  String get mealTypeSnack => 'Tentempié';

  @override
  String foodLoggerTitle(String mealType) {
    return 'Añadir a $mealType';
  }

  @override
  String get foodLoggerSearchTab => 'Buscar';

  @override
  String get foodLoggerQuickAddTab => 'Añadir rápido';

  @override
  String get foodLoggerSearchHint => 'Busca un alimento o una marca...';

  @override
  String get barcodeScannerTitle => 'Escanear código';

  @override
  String get barcodeScannerHint =>
      'Apunta la cámara al código de barras del producto';

  @override
  String get barcodeScannerNotFound =>
      'No se encontró ningún producto con ese código.';

  @override
  String get aiChatTitle => 'Coach IA';

  @override
  String get aiChatInputHint =>
      'Pregunta sobre entrenamiento, comida o recuperación';

  @override
  String get aiChatEmptyState =>
      'Pregúntame lo que quieras sobre entrenamiento, nutrición o recuperación.';

  @override
  String aiChatRemainingToday(int count) {
    return 'Te quedan $count mensajes hoy';
  }

  @override
  String get aiChatLimitReached =>
      'Has llegado al límite de mensajes de hoy. Se renueva mañana.';

  @override
  String get healthConnectPrompt =>
      'Conecta Apple Salud o Health Connect para ver tus pasos y calorías quemadas';

  @override
  String get healthStepsLabel => 'Pasos';

  @override
  String get healthCaloriesBurnedLabel => 'kcal activas';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total desbloqueados';
  }

  @override
  String get achievementFirstWorkoutTitle => 'Primer paso';

  @override
  String get achievementFirstWorkoutDesc => 'Completa tu primer entrenamiento';

  @override
  String get achievementWorkout5Title => 'En marcha';

  @override
  String get achievementWorkout5Desc => 'Completa 5 entrenamientos';

  @override
  String get achievementWorkout25Title => 'Constante';

  @override
  String get achievementWorkout25Desc => 'Completa 25 entrenamientos';

  @override
  String get achievementWorkout100Title => 'Club de los 100';

  @override
  String get achievementWorkout100Desc => 'Completa 100 entrenamientos';

  @override
  String get achievementFirstPrTitle => 'Nuevo récord';

  @override
  String get achievementFirstPrDesc => 'Consigue tu primer récord personal';

  @override
  String get achievementStreak3Title => 'Con ritmo';

  @override
  String get achievementStreak3Desc => 'Racha de 3 días';

  @override
  String get achievementStreak7Title => 'Una semana fuerte';

  @override
  String get achievementStreak7Desc => 'Racha de 7 días';

  @override
  String get achievementStreak30Title => 'Imparable';

  @override
  String get achievementStreak30Desc => 'Racha de 30 días';

  @override
  String get achievementWeightLogged5Title => 'Al día';

  @override
  String get achievementWeightLogged5Desc => 'Registra tu peso 5 veces';

  @override
  String get achievementWeightLogged30Title => 'Con datos';

  @override
  String get achievementWeightLogged30Desc => 'Registra tu peso 30 veces';

  @override
  String get waterCardTitle => 'Agua';

  @override
  String waterCardAmount(int consumed, int goal) {
    return '$consumed/$goal ml';
  }

  @override
  String get foodLoggerNoResultsTitle => 'Sin resultados';

  @override
  String get foodLoggerNoResultsMessage => 'Prueba con otra búsqueda.';

  @override
  String foodLoggerNutritionSummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal / 100 g • P:$protein g C:$carbs g G:$fat g';
  }

  @override
  String foodLoggerQuantitySummary(
      String kcal, String protein, String carbs, String fat) {
    return '$kcal kcal — P: $protein g, C: $carbs g, G: $fat g';
  }

  @override
  String get foodLoggerAiHint =>
      'p. ej. 3 huevos, 100 g de arroz, un puñado de almendras';

  @override
  String get foodLoggerAiFillButton => 'Rellenar con IA';

  @override
  String get foodLoggerAiParsing => 'Analizando...';

  @override
  String get foodLoggerOrManualEntry => 'o introdúcelo a mano';

  @override
  String foodLoggerAiParseFailedSnackbar(String error) {
    return 'La IA no pudo analizar la comida: $error';
  }

  @override
  String get quickAddCaloriesLabel => 'Calorías';

  @override
  String get quickAddProteinLabel => 'Proteína (g)';

  @override
  String get quickAddCarbsLabel => 'Carbohidratos (g)';

  @override
  String get quickAddFatLabel => 'Grasa (g)';

  @override
  String get quickAddEntryDefaultName => 'Añadido rápido';

  @override
  String get progressScreenTitle => 'Progreso';

  @override
  String get progressTabWeight => 'Peso';

  @override
  String get progressTabStrength => 'Fuerza';

  @override
  String get progressTabConsistency => 'Constancia';

  @override
  String get progressTabMeasurements => 'Medidas';

  @override
  String get progressWeightChartTitle => 'Peso (kg)';

  @override
  String get progressStrengthEmptyTitle => 'Aún no hay datos de fuerza';

  @override
  String get progressStrengthEmptyMessage =>
      'Termina un entrenamiento para empezar a seguir tu 1RM estimado.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise';
  }

  @override
  String get progressCurrentStreak => 'Racha actual';

  @override
  String get progressLongestStreak => 'Racha más larga';

  @override
  String get progressConsistencyLabel => 'Constancia';

  @override
  String get measurementWaist => 'Cintura';

  @override
  String get measurementNeck => 'Cuello';

  @override
  String get measurementHip => 'Cadera';

  @override
  String get measurementChest => 'Pecho';

  @override
  String get measurementBiceps => 'Bíceps';

  @override
  String get measurementThigh => 'Muslo';

  @override
  String get measurementsBodyFatHint =>
      'Añade las medidas de cintura y cuello para ver tu porcentaje de grasa corporal.';

  @override
  String measurementsBodyFatLabel(String category) {
    return 'Grasa corporal · $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Grasa esencial';

  @override
  String get bodyFatCategoryAthletic => 'Atlético';

  @override
  String get bodyFatCategoryFitness => 'En forma';

  @override
  String get bodyFatCategoryAverage => 'Media';

  @override
  String get bodyFatCategoryHigh => 'Alta';

  @override
  String get measurementsAddButton => 'Añadir medida';

  @override
  String get measurementsEmptyTitle => 'Aún no hay medidas';

  @override
  String get measurementsEmptyMessage =>
      'Añade tu primera medida para empezar a hacer seguimiento.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Añadir medida';

  @override
  String measurementsFieldHint(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get commonSave => 'Guardar';

  @override
  String get profileScreenTitle => 'Perfil';

  @override
  String profileLoadError(String error) {
    return 'No se pudo cargar el perfil: $error';
  }

  @override
  String get profileEmptyTitle => 'Aún no hay perfil';

  @override
  String get profileEmptyMessage =>
      'Completa la configuración para crear tu perfil.';

  @override
  String get bioAge => 'Edad';

  @override
  String get bioHeight => 'Altura';

  @override
  String get bioWeight => 'Peso';

  @override
  String get bioLevel => 'Nivel';

  @override
  String get profileGoalsTile => 'Objetivos';

  @override
  String get profileSignOut => 'Cerrar sesión';

  @override
  String get goalsEmptyTitle => 'Sin objetivos';

  @override
  String get goalsEmptyMessage =>
      'Completa la configuración para fijar tus objetivos.';

  @override
  String get goalsCurrentLabel => 'Actual';

  @override
  String get goalsTargetLabel => 'Objetivo';

  @override
  String get goalsRemainingLabel => 'Faltan';

  @override
  String get goalsWeeklyWorkoutLabel => 'ENTRENAMIENTOS POR SEMANA';

  @override
  String get goalsDailyCalorieLabel => 'CALORÍAS DIARIAS';

  @override
  String get goalsProteinLabel => 'PROTEÍNA DIARIA';

  @override
  String get settingsWorkoutSection => 'Entrenamiento';

  @override
  String get settingsDefaultRestTime => 'Descanso predeterminado';

  @override
  String get settingsAutoStartNextSet =>
      'Iniciar la siguiente serie automáticamente';

  @override
  String get settingsWeightUnit => 'Unidad de peso';

  @override
  String get settingsDistanceUnit => 'Unidad de distancia';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsHaptics => 'Vibración';

  @override
  String get settingsCountdownBeep => 'Pitido de cuenta atrás (3-2-1)';

  @override
  String get settingsNutritionSection => 'Nutrición';

  @override
  String get settingsAutoCalculateTargets =>
      'Calcular objetivos automáticamente (TDEE)';

  @override
  String get settingsFoodDatabase => 'Base de datos de alimentos';

  @override
  String get settingsFoodDbGlobal => 'Global (todas)';

  @override
  String get settingsFoodDbTurkey => 'Turquía';

  @override
  String get settingsFoodDbGermany => 'Alemania';

  @override
  String get settingsFoodDbUK => 'Reino Unido';

  @override
  String get settingsFoodDbUS => 'Estados Unidos';

  @override
  String get settingsFoodDbFrance => 'Francia';

  @override
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat) {
    return 'Macros manuales: Calorías $calories · Proteína $protein g · Carbohidratos $carbs g · Grasa $fat g';
  }

  @override
  String get settingsNotificationsSection => 'Notificaciones';

  @override
  String get settingsEnableNotifications => 'Recordatorios';

  @override
  String get settingsAppearanceSection => 'Idioma';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Sistema';

  @override
  String get settingsAccountSection => 'Cuenta y soporte';

  @override
  String get muscleGroupChest => 'Pecho';

  @override
  String get muscleGroupBack => 'Espalda';

  @override
  String get muscleGroupShoulders => 'Hombros';

  @override
  String get muscleGroupBiceps => 'Bíceps';

  @override
  String get muscleGroupTriceps => 'Tríceps';

  @override
  String get muscleGroupLegs => 'Piernas';

  @override
  String get muscleGroupGlutes => 'Glúteos';

  @override
  String get muscleGroupCore => 'Core';

  @override
  String get muscleGroupCardio => 'Cardio';

  @override
  String get muscleGroupFullBody => 'Cuerpo completo';

  @override
  String get settingsSubscription => 'Suscripción';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Sin anuncios y con el coach IA.';

  @override
  String get paywallFeatureNoAds => 'Sin anuncios';

  @override
  String get paywallFeatureAiWorkouts =>
      'Programas de entrenamiento creados con IA';

  @override
  String get paywallFeatureAiMeals => 'Registra comidas escribiéndolas';

  @override
  String get paywallSubscribeButton => 'Suscribirse';

  @override
  String get paywallRestoreButton => 'Restaurar compras';

  @override
  String get paywallUnavailable =>
      'Las suscripciones aún no están disponibles.';

  @override
  String get paywallAlreadySubscribed =>
      'Ya tienes Premium. Gracias por tu apoyo.';

  @override
  String get paywallPurchaseFailed =>
      'No se pudo completar la compra. Inténtalo de nuevo.';

  @override
  String get paywallRestoreSuccess => 'Compras restauradas.';

  @override
  String get paywallRestoreNone => 'No hay compras anteriores en esta cuenta.';

  @override
  String get settingsSendFeedback => 'Enviar comentarios';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountConfirmTitle => '¿Eliminar tu cuenta?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Se eliminarán para siempre tu cuenta y todos tus datos: entrenamientos, registros de comidas, progreso, todo. No se puede deshacer.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Eliminar para siempre';

  @override
  String get settingsDeleteAccountFailed =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '$seconds s';
  }

  @override
  String get mealCardNoItems => 'Aún no has registrado nada';

  @override
  String get mealCardAddFood => 'Añadir alimento';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes min · $count ejercicios';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets × $reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Última: $value';
  }

  @override
  String get restTimerLabel => 'Descanso';

  @override
  String get restTimerSubtract => '-15 s';

  @override
  String get restTimerSkip => 'Saltar descanso';

  @override
  String get restTimerAdd => '+30 s';

  @override
  String get splashTagline =>
      'Entrenamiento, comida y progreso en un solo lugar.';

  @override
  String get lineChartNoData => 'Aún no hay datos';

  @override
  String get weightLogButton => 'Registrar peso';

  @override
  String get weightFieldHint => 'Peso';

  @override
  String get navHome => 'Inicio';

  @override
  String get navWorkouts => 'Entrenar';

  @override
  String get navNutrition => 'Nutrición';

  @override
  String get navProgress => 'Progreso';

  @override
  String get navProfile => 'Perfil';

  @override
  String get weekdayInitials => 'L,M,X,J,V,S,D';

  @override
  String get streakLabel => 'días seguidos';

  @override
  String get authErrorInvalidCredentials =>
      'El correo o la contraseña no son correctos.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Primero confirma tu correo. Revisa tu bandeja de entrada.';

  @override
  String get authErrorUserExists =>
      'Ya existe una cuenta con este correo. Prueba a iniciar sesión.';

  @override
  String get authErrorWeakPassword =>
      'La contraseña es demasiado débil. Usa al menos 6 caracteres.';

  @override
  String get authErrorInvalidEmail => 'Ese correo no parece válido.';

  @override
  String get authErrorRateLimited =>
      'Demasiados intentos. Espera un minuto y vuelve a intentarlo.';

  @override
  String get authErrorNetwork =>
      'Sin conexión. Revisa tu internet y vuelve a intentarlo.';

  @override
  String get authErrorGeneric =>
      'No se pudo iniciar sesión. Inténtalo de nuevo.';

  @override
  String get authErrorMissingFields => 'Introduce tu correo y tu contraseña.';

  @override
  String get authConfirmEmailSent =>
      'Te hemos enviado un enlace de confirmación. Ábrelo para terminar el registro.';

  @override
  String get notifWorkoutTitle => 'Tu entrenamiento te espera';

  @override
  String get notifWorkoutBody =>
      'Hoy aún no has registrado ningún entrenamiento. ¿Tienes 20 minutos?';

  @override
  String get notifMealTitle => 'Registra tu comida';

  @override
  String get notifLunchBody =>
      'Hora del almuerzo. Apunta lo que has comido mientras lo recuerdas.';

  @override
  String get notifDinnerBody =>
      'Hora de cenar. Apunta lo que has comido mientras lo recuerdas.';

  @override
  String get dayFullBodyA => 'Cuerpo completo A';

  @override
  String get dayFullBodyB => 'Cuerpo completo B';

  @override
  String get dayFullBodyC => 'Cuerpo completo C';

  @override
  String get dayFullBody => 'Cuerpo completo';

  @override
  String get dayUpperBodyPower => 'Tren superior · Fuerza';

  @override
  String get dayUpperBodyHypertrophy => 'Tren superior · Volumen';

  @override
  String get dayUpperBody => 'Tren superior';

  @override
  String get dayLowerBodyFocus => 'Tren inferior · Fuerza';

  @override
  String get dayLowerBody => 'Tren inferior';

  @override
  String get dayPush => 'Empuje';

  @override
  String get dayPull => 'Tirón';

  @override
  String get dayLegsCore => 'Piernas y core';

  @override
  String get dayActiveRecovery => 'Recuperación activa';

  @override
  String get dayRest => 'Descanso';

  @override
  String get programFullBody => 'Programa de cuerpo completo';

  @override
  String get programUpperLower => 'Rutina torso/pierna';

  @override
  String get exBenchPress => 'Press de banca';

  @override
  String get exInclineDumbbellPress => 'Press inclinado con mancuernas';

  @override
  String get exOverheadPress => 'Press militar';

  @override
  String get exTricepsPushdown => 'Extensión de tríceps en polea';

  @override
  String get exLateralRaise => 'Elevaciones laterales';

  @override
  String get exDeadlift => 'Peso muerto';

  @override
  String get exPullUp => 'Dominadas';

  @override
  String get exBarbellRow => 'Remo con barra';

  @override
  String get exFacePull => 'Face pull';

  @override
  String get exBicepCurl => 'Curl de bíceps';

  @override
  String get exBackSquat => 'Sentadilla';

  @override
  String get exRomanianDeadlift => 'Peso muerto rumano';

  @override
  String get exLegPress => 'Prensa de piernas';

  @override
  String get exWalkingLunge => 'Zancadas caminando';

  @override
  String get exPlank => 'Plancha';

  @override
  String get exGobletSquat => 'Sentadilla goblet';

  @override
  String get exPushUp => 'Flexiones';

  @override
  String get exDumbbellRow => 'Remo con mancuerna';

  @override
  String activeWorkoutLastTime(String value) {
    return 'La última vez: $value';
  }

  @override
  String get activeWorkoutSetHeader => 'SERIE';

  @override
  String get activeWorkoutPreviousHeader => 'ANTERIOR';

  @override
  String get activeWorkoutExercisesHeader => 'EJERCICIOS';

  @override
  String activeWorkoutCurrentSet(int number) {
    return 'Serie $number';
  }

  @override
  String activeWorkoutRestNext(String label) {
    return 'A continuación: $label';
  }

  @override
  String activeWorkoutFinishContent(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se guardarán las $count series que completaste.',
      one: 'Se guardará la serie que completaste.',
    );
    return '$_temp0';
  }

  @override
  String get activeWorkoutFinishSave => 'Terminar y guardar';

  @override
  String get activeWorkoutDiscard => 'Descartar entrenamiento';

  @override
  String get activeWorkoutKeepGoing => 'Seguir';

  @override
  String get activeWorkoutFinishNow => 'Terminar';

  @override
  String activeWorkoutSetsDone(int done, int total) {
    return '$done/$total series';
  }

  @override
  String workoutSummaryExerciseLine(int sets, String best) {
    String _temp0 = intl.Intl.pluralLogic(
      sets,
      locale: localeName,
      other: '$sets series',
      one: '1 serie',
    );
    return '$_temp0 · mejor $best';
  }

  @override
  String get workoutDetailMuscles => 'Músculos';

  @override
  String workoutDetailRest(int seconds) {
    return '$seconds s de descanso';
  }

  @override
  String get equipmentBarbell => 'Barra';

  @override
  String get equipmentDumbbell => 'Mancuernas';

  @override
  String get equipmentBench => 'Banco';

  @override
  String get equipmentCable => 'Polea';

  @override
  String get equipmentMachine => 'Máquinas';

  @override
  String get equipmentResistanceBand => 'Banda elástica';

  @override
  String get equipmentBodyweight => 'Peso corporal';

  @override
  String get equipmentKettlebell => 'Kettlebell';

  @override
  String get aiChatSuggestion1 => '¿Cuánta proteína necesito al día?';

  @override
  String get aiChatSuggestion2 => '¿Qué debería comer antes de entrenar?';

  @override
  String get aiChatSuggestion3 =>
      'Mi press de banca se ha estancado. ¿Qué cambio?';

  @override
  String get paywallAutoRenewNote =>
      'Se renueva automáticamente hasta que la canceles. Puedes cancelarla cuando quieras en los ajustes de App Store o Google Play.';

  @override
  String get paywallTerms => 'Términos de uso';
}
