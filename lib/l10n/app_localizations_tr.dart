// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'THRIVE+';

  @override
  String get settingsScreenTitle => 'Ayarlar';

  @override
  String get authSignUpTitle => 'Hesap oluştur';

  @override
  String get authSignInTitle => 'Tekrar hoş geldin';

  @override
  String get authSignUpSubtitle =>
      'Hesabını oluştur, planını birlikte kuralım.';

  @override
  String get authSignInSubtitle => 'Giriş yap ve kaldığın yerden devam et.';

  @override
  String get authContinueWithApple => 'Apple ile devam et';

  @override
  String get authContinueWithGoogle => 'Google ile devam et';

  @override
  String get authOrWithEmail => 'veya e-posta ile';

  @override
  String get authEmailHint => 'E-posta';

  @override
  String get authPasswordHint => 'Şifre';

  @override
  String get authSignUpButton => 'Kayıt ol';

  @override
  String get authSignInButton => 'Giriş yap';

  @override
  String get authSwitchToSignIn => 'Zaten hesabın var mı? Giriş yap';

  @override
  String get authSwitchToSignUp => 'Hesabın yok mu? Kayıt ol';

  @override
  String get authForgotPassword => 'Şifremi unuttum';

  @override
  String get authResetPasswordTitle => 'Şifreyi sıfırla';

  @override
  String get authResetPasswordMessage =>
      'E-postanı gir, sana bir sıfırlama linki gönderelim.';

  @override
  String get authResetPasswordSend => 'Sıfırlama linki gönder';

  @override
  String get authResetPasswordSent =>
      'Bu e-posta kayıtlıysa bir sıfırlama linki gönderildi.';

  @override
  String get authResetPasswordFailed =>
      'Sıfırlama linki gönderilemedi. Tekrar dene.';

  @override
  String get authNewPasswordTitle => 'Yeni şifre belirle';

  @override
  String get authNewPasswordHint => 'Yeni şifre';

  @override
  String get authNewPasswordButton => 'Şifreyi güncelle';

  @override
  String get authNewPasswordSuccess => 'Şifre güncellendi.';

  @override
  String get onboardingContinue => 'Devam et';

  @override
  String get onboardingWelcomeHeadline => 'Antrenman ve beslenme, tek planda.';

  @override
  String get onboardingWelcomeSubtitle =>
      'Birkaç kısa soru soralım, sonra sana uygun bir program ve kalori hedefi çıkaralım.';

  @override
  String get onboardingGetStarted => 'Başlayalım';

  @override
  String get onboardingNameTitle => 'Sana nasıl hitap edelim?';

  @override
  String get onboardingNameHint => 'Adın';

  @override
  String get onboardingGenderTitle => 'Cinsiyetin nedir?';

  @override
  String get onboardingGenderMale => 'Erkek';

  @override
  String get onboardingGenderFemale => 'Kadın';

  @override
  String get onboardingGenderUnspecified => 'Belirtmek istemiyorum';

  @override
  String get onboardingAgeTitle => 'Yaşın kaç?';

  @override
  String get onboardingHeightTitle => 'Boyun (cm)';

  @override
  String get onboardingWeightTitle => 'Kilon (kg)';

  @override
  String get onboardingTargetWeightTitle => 'Hedef kilon (kg)';

  @override
  String get onboardingFitnessLevelTitle => 'Fitness seviyen nedir?';

  @override
  String get fitnessBeginnerLabel => 'Başlangıç';

  @override
  String get fitnessBeginnerSubtitle => 'Temel formları öğreniyorum (0-1 yıl)';

  @override
  String get fitnessIntermediateLabel => 'Orta seviye';

  @override
  String get fitnessIntermediateSubtitle => 'Düzenli kaldırıyorum (1-3 yıl)';

  @override
  String get fitnessAdvancedLabel => 'İleri seviye';

  @override
  String get fitnessAdvancedSubtitle =>
      'Ağır antrenman ve periyodizasyon (3+ yıl)';

  @override
  String get onboardingPrimaryGoalTitle => 'Ana hedefin nedir?';

  @override
  String get goalLoseWeight => 'Kilo vermek';

  @override
  String get goalBuildMuscle => 'Kas kazanmak';

  @override
  String get goalLoseFat => 'Yağ oranını azaltmak';

  @override
  String get goalMaintainFitness => 'Formda kalmak';

  @override
  String get onboardingDaysPerWeekTitle =>
      'Haftada kaç gün antrenman yapmak istersin?';

  @override
  String get onboardingMostPopular => 'En çok seçilen';

  @override
  String get onboardingDurationTitle => 'Antrenman süren ne kadar olsun?';

  @override
  String onboardingDurationMinutes(int minutes) {
    return '$minutes dk';
  }

  @override
  String get onboardingLocationTitle => 'Nerede antrenman yapıyorsun?';

  @override
  String get locationGym => 'Spor Salonu';

  @override
  String get locationHome => 'Ev';

  @override
  String get locationBoth => 'Her ikisi';

  @override
  String get onboardingEquipmentLabel => 'Ekipman';

  @override
  String get onboardingActivityLevelTitle => 'Günlük aktivite seviyen nedir?';

  @override
  String get activitySedentaryLabel => 'Hareketsiz';

  @override
  String get activitySedentarySubtitle => 'Masa başı iş, az hareket';

  @override
  String get activityModeratelyActiveLabel => 'Orta aktif';

  @override
  String get activityModeratelyActiveSubtitle => 'Günde ~7.500 adım';

  @override
  String get activityVeryActiveLabel => 'Çok aktif';

  @override
  String get activityVeryActiveSubtitle => 'Günde 10.000+ adım, fiziksel iş';

  @override
  String get onboardingNutritionPrefTitle => 'Beslenme tercihin nedir?';

  @override
  String get nutritionStandard => 'Standart';

  @override
  String get nutritionHighProtein => 'Yüksek protein';

  @override
  String get nutritionKeto => 'Ketojenik';

  @override
  String get nutritionVegetarian => 'Vejetaryen';

  @override
  String get nutritionVegan => 'Vegan';

  @override
  String get onboardingCalculatingLine1 => 'Kalori ihtiyacın hesaplanıyor…';

  @override
  String get onboardingCalculatingLine2 => 'Haftalık programın hazırlanıyor…';

  @override
  String onboardingPlanReadyTitle(String name) {
    return '$name, planın hazır';
  }

  @override
  String get onboardingDefaultName => 'Sporcu';

  @override
  String get onboardingDailyCalories => 'Günlük kalori';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Karbonhidrat';

  @override
  String get macroFat => 'Yağ';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return 'Haftada $days gün';
  }

  @override
  String get onboardingPlanTagline => 'Kuvvet ve vücut kompozisyonu';

  @override
  String get onboardingStartMyPlan => 'Planıma başla';

  @override
  String get homeGreetingMorning => 'Günaydın';

  @override
  String get homeGreetingAfternoon => 'İyi günler';

  @override
  String get homeGreetingEvening => 'İyi akşamlar';

  @override
  String get homeDefaultAthleteName => 'Sporcu';

  @override
  String homeCaloriesLeft(int count) {
    return '$count kaldı';
  }

  @override
  String get homeTodaysWorkoutLabel => 'BUGÜNÜN ANTRENMANI';

  @override
  String get homeRestDayMessage =>
      'Bugün dinlenme günü. Toparlanma da programın parçası.';

  @override
  String get homeNoWorkoutPlanned => 'Henüz planlanmış antrenman yok.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '$minutes dk · $count egzersiz';
  }

  @override
  String get homeStartWorkout => 'Antrenmana başla';

  @override
  String get homeWeightGoalLabel => 'KİLO HEDEFİ';

  @override
  String homeWeightRemaining(String kg) {
    return 'Hedefe $kg kg kaldı';
  }

  @override
  String get homeQuickActionAddMeal => 'Öğün ekle';

  @override
  String get homeQuickActionLogWeight => 'Kilo gir';

  @override
  String get homeQuickActionViewProgress => 'İlerleme';

  @override
  String genericError(String error) {
    return 'Hata: $error';
  }

  @override
  String get commonCancel => 'İptal';

  @override
  String get weekdayMonday => 'Pazartesi';

  @override
  String get weekdayTuesday => 'Salı';

  @override
  String get weekdayWednesday => 'Çarşamba';

  @override
  String get weekdayThursday => 'Perşembe';

  @override
  String get weekdayFriday => 'Cuma';

  @override
  String get weekdaySaturday => 'Cumartesi';

  @override
  String get weekdaySunday => 'Pazar';

  @override
  String get workoutsScreenTitle => 'Bu hafta';

  @override
  String get workoutsAiUpdateTooltip => 'AI ile Güncelle';

  @override
  String workoutsAiUpdateFailedSnackbar(String error) {
    return 'AI programı güncelleyemedi: $error';
  }

  @override
  String workoutsFailedToLoad(String error) {
    return 'Program yüklenemedi: $error';
  }

  @override
  String get workoutsOnboardingCta =>
      'Haftalık programını oluşturmak için kurulumu tamamla.';

  @override
  String get workoutsCreateMyPlan => 'Planımı oluştur';

  @override
  String get activeWorkoutNoExercises => 'Bu gün için egzersiz yok.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return '$total egzersizden $current.';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'Set $current / $total';
  }

  @override
  String activeWorkoutTarget(String weight, String reps) {
    return 'Hedef: $weight kg × $reps tekrar';
  }

  @override
  String get activeWorkoutWeightLabel => 'AĞIRLIK (KG)';

  @override
  String get activeWorkoutRepsLabel => 'TEKRAR';

  @override
  String get activeWorkoutSkipExercise => 'Egzersizi atla';

  @override
  String get activeWorkoutAddSet => 'Set ekle';

  @override
  String get activeWorkoutCompleteSet => 'Seti tamamla';

  @override
  String get activeWorkoutEndTitle => 'Antrenmanı bitir?';

  @override
  String get activeWorkoutEndContent => 'Bu seanstaki ilerlemen kaybolacak.';

  @override
  String get activeWorkoutEndConfirm => 'Antrenmanı bitir';

  @override
  String get workoutDetailNotFound => 'Antrenman bulunamadı';

  @override
  String get workoutDetailStartButton => 'Antrenmana başla';

  @override
  String get workoutSummarySessionNotFound => 'Seans bulunamadı';

  @override
  String get workoutSummaryComplete => 'Antrenman tamamlandı';

  @override
  String get workoutSummaryDuration => 'Süre';

  @override
  String get workoutSummaryTotalVolume => 'Toplam hacim';

  @override
  String get workoutSummarySetsCompleted => 'Tamamlanan set';

  @override
  String get workoutSummaryEstCalories => 'Tahmini kalori';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'Yeni rekor: $weight kg × $reps';
  }

  @override
  String get workoutSummaryEncouragement =>
      'İyi seanstı. Kaydettiğin her set, gelecek haftanın planını daha isabetli yapıyor.';

  @override
  String get workoutSummaryFinish => 'Bitir';

  @override
  String get commonAdd => 'Ekle';

  @override
  String get nutritionToday => 'Bugün';

  @override
  String nutritionCaloriesProgress(int consumed, int goal) {
    return '$consumed / $goal kcal';
  }

  @override
  String get mealTypeBreakfast => 'Kahvaltı';

  @override
  String get mealTypeLunch => 'Öğle yemeği';

  @override
  String get mealTypeDinner => 'Akşam yemeği';

  @override
  String get mealTypeSnack => 'Atıştırmalık';

  @override
  String foodLoggerTitle(String mealType) {
    return '$mealType Ekle';
  }

  @override
  String get foodLoggerSearchTab => 'Ara';

  @override
  String get foodLoggerQuickAddTab => 'Hızlı ekle';

  @override
  String get foodLoggerSearchHint => 'Yemek veya marka ara...';

  @override
  String get barcodeScannerTitle => 'Barkod tara';

  @override
  String get barcodeScannerHint => 'Kamerayı ürün barkoduna doğrult';

  @override
  String get barcodeScannerNotFound => 'Bu barkoda ait ürün bulunamadı.';

  @override
  String get aiChatTitle => 'AI Koç';

  @override
  String get aiChatInputHint =>
      'Antrenman, beslenme veya toparlanma hakkında sor';

  @override
  String get aiChatEmptyState =>
      'Antrenman, beslenme veya toparlanma hakkında istediğini sor.';

  @override
  String aiChatRemainingToday(int count) {
    return 'Bugün $count mesaj hakkın kaldı';
  }

  @override
  String get aiChatLimitReached =>
      'Bugünkü mesaj hakkın doldu. Yarın yenilenir.';

  @override
  String get healthConnectPrompt =>
      'Adım ve yakılan kaloriyi görmek için Apple Sağlık veya Health Connect\'i bağla';

  @override
  String get healthStepsLabel => 'Adım';

  @override
  String get healthCaloriesBurnedLabel => 'Aktif kcal';

  @override
  String get achievementsTitle => 'Başarılar';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total açıldı';
  }

  @override
  String get achievementFirstWorkoutTitle => 'İlk Adım';

  @override
  String get achievementFirstWorkoutDesc => 'İlk antrenmanını tamamla';

  @override
  String get achievementWorkout5Title => 'Başlangıç';

  @override
  String get achievementWorkout5Desc => '5 antrenman tamamla';

  @override
  String get achievementWorkout25Title => 'Kararlı';

  @override
  String get achievementWorkout25Desc => '25 antrenman tamamla';

  @override
  String get achievementWorkout100Title => 'Yüzler Kulübü';

  @override
  String get achievementWorkout100Desc => '100 antrenman tamamla';

  @override
  String get achievementFirstPrTitle => 'Yeni Rekor';

  @override
  String get achievementFirstPrDesc => 'İlk kişisel rekorunu kır';

  @override
  String get achievementStreak3Title => 'Tempoda';

  @override
  String get achievementStreak3Desc => '3 günlük antrenman serisi';

  @override
  String get achievementStreak7Title => 'Bir Hafta Güçlü';

  @override
  String get achievementStreak7Desc => '7 günlük antrenman serisi';

  @override
  String get achievementStreak30Title => 'Durdurulamaz';

  @override
  String get achievementStreak30Desc => '30 günlük antrenman serisi';

  @override
  String get achievementWeightLogged5Title => 'Takipte';

  @override
  String get achievementWeightLogged5Desc => 'Kilonu 5 kez kaydet';

  @override
  String get achievementWeightLogged30Title => 'Veri Odaklı';

  @override
  String get achievementWeightLogged30Desc => 'Kilonu 30 kez kaydet';

  @override
  String get waterCardTitle => 'Su';

  @override
  String waterCardAmount(int consumed, int goal) {
    return '$consumed/$goal ml';
  }

  @override
  String get foodLoggerNoResultsTitle => 'Sonuç yok';

  @override
  String get foodLoggerNoResultsMessage => 'Farklı bir arama terimi dene.';

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
  String get foodLoggerAiHint => 'Örn: 3 yumurta, 100g pirinç, bir avuç badem';

  @override
  String get foodLoggerAiFillButton => 'AI ile doldur';

  @override
  String get foodLoggerAiParsing => 'Ayrıştırılıyor...';

  @override
  String get foodLoggerOrManualEntry => 'veya elle gir';

  @override
  String foodLoggerAiParseFailedSnackbar(String error) {
    return 'AI yemekleri ayrıştıramadı: $error';
  }

  @override
  String get quickAddCaloriesLabel => 'Kalori';

  @override
  String get quickAddProteinLabel => 'Protein (g)';

  @override
  String get quickAddCarbsLabel => 'Karbonhidrat (g)';

  @override
  String get quickAddFatLabel => 'Yağ (g)';

  @override
  String get quickAddEntryDefaultName => 'Hızlı ekle';

  @override
  String get progressScreenTitle => 'İlerleme';

  @override
  String get progressTabWeight => 'Kilo';

  @override
  String get progressTabStrength => 'Kuvvet';

  @override
  String get progressTabConsistency => 'Süreklilik';

  @override
  String get progressTabMeasurements => 'Ölçüler';

  @override
  String get progressWeightChartTitle => 'Kilo (kg)';

  @override
  String get progressStrengthEmptyTitle => 'Henüz kuvvet verisi yok';

  @override
  String get progressStrengthEmptyMessage =>
      'Tahmini 1RM\'ini takip etmeye başlamak için bir antrenman bitir.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise';
  }

  @override
  String get progressCurrentStreak => 'Güncel seri';

  @override
  String get progressLongestStreak => 'En uzun seri';

  @override
  String get progressConsistencyLabel => 'Süreklilik';

  @override
  String get measurementWaist => 'Bel';

  @override
  String get measurementNeck => 'Boyun';

  @override
  String get measurementHip => 'Kalça';

  @override
  String get measurementChest => 'Göğüs';

  @override
  String get measurementBiceps => 'Kol';

  @override
  String get measurementThigh => 'Bacak';

  @override
  String get measurementsBodyFatHint =>
      'Vücut yağı yüzdesini görmek için bel ve boyun ölçünü ekle.';

  @override
  String measurementsBodyFatLabel(String category) {
    return 'Vücut yağı · $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Temel yağ';

  @override
  String get bodyFatCategoryAthletic => 'Atletik';

  @override
  String get bodyFatCategoryFitness => 'Fit';

  @override
  String get bodyFatCategoryAverage => 'Ortalama';

  @override
  String get bodyFatCategoryHigh => 'Yüksek';

  @override
  String get measurementsAddButton => 'Ölçü ekle';

  @override
  String get measurementsEmptyTitle => 'Henüz ölçü yok';

  @override
  String get measurementsEmptyMessage => 'İlk ölçünü ekleyerek takibe başla.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Ölçü ekle';

  @override
  String measurementsFieldHint(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get commonSave => 'Kaydet';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String profileLoadError(String error) {
    return 'Profil yüklenemedi: $error';
  }

  @override
  String get profileEmptyTitle => 'Henüz profil yok';

  @override
  String get profileEmptyMessage =>
      'Profilini oluşturmak için kurulumu tamamla.';

  @override
  String get bioAge => 'Yaş';

  @override
  String get bioHeight => 'Boy';

  @override
  String get bioWeight => 'Kilo';

  @override
  String get bioLevel => 'Seviye';

  @override
  String get profileGoalsTile => 'Hedefler';

  @override
  String get profileSignOut => 'Çıkış yap';

  @override
  String get goalsEmptyTitle => 'Hedef belirlenmemiş';

  @override
  String get goalsEmptyMessage =>
      'Hedeflerini belirlemek için kurulumu tamamla.';

  @override
  String get goalsCurrentLabel => 'Şu an';

  @override
  String get goalsTargetLabel => 'Hedef';

  @override
  String get goalsRemainingLabel => 'Kalan';

  @override
  String get goalsWeeklyWorkoutLabel => 'HAFTALIK ANTRENMAN';

  @override
  String get goalsDailyCalorieLabel => 'GÜNLÜK KALORİ';

  @override
  String get goalsProteinLabel => 'GÜNLÜK PROTEİN';

  @override
  String get settingsWorkoutSection => 'Antrenman';

  @override
  String get settingsDefaultRestTime => 'Varsayılan dinlenme süresi';

  @override
  String get settingsAutoStartNextSet => 'Sonraki seti otomatik başlat';

  @override
  String get settingsWeightUnit => 'Ağırlık birimi';

  @override
  String get settingsDistanceUnit => 'Mesafe birimi';

  @override
  String get settingsSound => 'Ses';

  @override
  String get settingsHaptics => 'Titreşim';

  @override
  String get settingsCountdownBeep => 'Geri sayım sesi (3-2-1)';

  @override
  String get settingsNutritionSection => 'Beslenme';

  @override
  String get settingsAutoCalculateTargets =>
      'Hedefleri otomatik hesapla (TDEE)';

  @override
  String get settingsFoodDatabase => 'Yemek veritabanı';

  @override
  String get settingsFoodDbGlobal => 'Global (Tümü)';

  @override
  String get settingsFoodDbTurkey => 'Türkiye';

  @override
  String get settingsFoodDbGermany => 'Almanya';

  @override
  String get settingsFoodDbUK => 'Birleşik Krallık';

  @override
  String get settingsFoodDbUS => 'Amerika Birleşik Devletleri';

  @override
  String get settingsFoodDbFrance => 'Fransa';

  @override
  String settingsManualMacroEditing(
      String calories, String protein, String carbs, String fat) {
    return 'Manuel makro düzenleme: Kalori $calories · Protein ${protein}g · Karbonhidrat ${carbs}g · Yağ ${fat}g';
  }

  @override
  String get settingsNotificationsSection => 'Bildirimler';

  @override
  String get settingsEnableNotifications => 'Hatırlatmalar';

  @override
  String get settingsAppearanceSection => 'Dil';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem';

  @override
  String get settingsAccountSection => 'Hesap ve destek';

  @override
  String get muscleGroupChest => 'Göğüs';

  @override
  String get muscleGroupBack => 'Sırt';

  @override
  String get muscleGroupShoulders => 'Omuz';

  @override
  String get muscleGroupBiceps => 'Biceps';

  @override
  String get muscleGroupTriceps => 'Triceps';

  @override
  String get muscleGroupLegs => 'Bacak';

  @override
  String get muscleGroupGlutes => 'Kalça';

  @override
  String get muscleGroupCore => 'Karın';

  @override
  String get muscleGroupCardio => 'Kardiyo';

  @override
  String get muscleGroupFullBody => 'Tüm vücut';

  @override
  String get settingsSubscription => 'Abonelik';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Reklamsız kullanım ve AI koç.';

  @override
  String get paywallFeatureNoAds => 'Reklamsız';

  @override
  String get paywallFeatureAiWorkouts =>
      'AI ile hazırlanan antrenman programları';

  @override
  String get paywallFeatureAiMeals => 'Öğünleri yazarak kaydetme';

  @override
  String get paywallSubscribeButton => 'Abone Ol';

  @override
  String get paywallRestoreButton => 'Satın alımları geri yükle';

  @override
  String get paywallUnavailable => 'Abonelikler henüz aktif değil.';

  @override
  String get paywallAlreadySubscribed =>
      'Premium kullanıyorsun. Desteğin için teşekkürler.';

  @override
  String get paywallPurchaseFailed => 'Satın alma tamamlanamadı. Tekrar dene.';

  @override
  String get paywallRestoreSuccess => 'Satın alımlar geri yüklendi.';

  @override
  String get paywallRestoreNone =>
      'Bu hesap için önceki bir satın alma bulunamadı.';

  @override
  String get settingsSendFeedback => 'Geri bildirim gönder';

  @override
  String get settingsPrivacyPolicy => 'Gizlilik politikası';

  @override
  String get settingsDeleteAccount => 'Hesabı sil';

  @override
  String get settingsDeleteAccountConfirmTitle =>
      'Hesabını silmek istiyor musun?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Bu işlem hesabını ve tüm verilerini (antrenmanlar, beslenme kayıtları, ilerleme, her şey) kalıcı olarak siler. Geri alınamaz.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Kalıcı olarak sil';

  @override
  String get settingsDeleteAccountFailed => 'Hesap silinemedi. Tekrar dene.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '$seconds sn';
  }

  @override
  String get mealCardNoItems => 'Henüz bir şey eklenmedi';

  @override
  String get mealCardAddFood => 'Yemek ekle';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes dk · $count egzersiz';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets × $reps';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Son: $value';
  }

  @override
  String get restTimerLabel => 'Dinlenme';

  @override
  String get restTimerSubtract => '-15sn';

  @override
  String get restTimerSkip => 'Dinlenmeyi atla';

  @override
  String get restTimerAdd => '+30sn';

  @override
  String get splashTagline => 'Antrenman, beslenme ve ilerleme tek yerde.';

  @override
  String get lineChartNoData => 'Henüz veri yok';

  @override
  String get weightLogButton => 'Kilo gir';

  @override
  String get weightFieldHint => 'Kilo';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navWorkouts => 'Antrenmanlar';

  @override
  String get navNutrition => 'Beslenme';

  @override
  String get navProgress => 'İlerleme';

  @override
  String get navProfile => 'Profil';

  @override
  String get weekdayInitials => 'Pt,Sa,Ça,Pe,Cu,Ct,Pz';

  @override
  String get streakLabel => 'gün seri';

  @override
  String get authErrorInvalidCredentials => 'E-posta veya şifre hatalı.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Önce e-postanı onayla. Gelen kutuna bak.';

  @override
  String get authErrorUserExists =>
      'Bu e-postayla zaten bir hesap var. Giriş yapmayı dene.';

  @override
  String get authErrorWeakPassword =>
      'Şifre çok zayıf. En az 6 karakter kullan.';

  @override
  String get authErrorInvalidEmail => 'Bu e-posta adresi geçerli görünmüyor.';

  @override
  String get authErrorRateLimited =>
      'Çok fazla deneme yapıldı. Bir dakika bekleyip tekrar dene.';

  @override
  String get authErrorNetwork =>
      'Bağlantı yok. İnternetini kontrol edip tekrar dene.';

  @override
  String get authErrorGeneric => 'Giriş yapılamadı. Lütfen tekrar dene.';

  @override
  String get authErrorMissingFields => 'E-posta ve şifreni gir.';

  @override
  String get authConfirmEmailSent =>
      'E-postana bir onay linki gönderdik. Kaydı tamamlamak için linke dokun.';

  @override
  String get notifWorkoutTitle => 'Bugünkü antrenmanın seni bekliyor';

  @override
  String get notifWorkoutBody =>
      'Bugün henüz antrenman kaydın yok. 20 dakikan var mı?';

  @override
  String get notifMealTitle => 'Öğününü kaydet';

  @override
  String get notifLunchBody => 'Öğle yemeği vakti. Unutmadan ne yediğini ekle.';

  @override
  String get notifDinnerBody =>
      'Akşam yemeği vakti. Unutmadan ne yediğini ekle.';

  @override
  String get dayFullBodyA => 'Tüm Vücut A';

  @override
  String get dayFullBodyB => 'Tüm Vücut B';

  @override
  String get dayFullBodyC => 'Tüm Vücut C';

  @override
  String get dayFullBody => 'Tüm Vücut';

  @override
  String get dayUpperBodyPower => 'Üst Vücut · Kuvvet';

  @override
  String get dayUpperBodyHypertrophy => 'Üst Vücut · Hacim';

  @override
  String get dayUpperBody => 'Üst Vücut';

  @override
  String get dayLowerBodyFocus => 'Alt Vücut · Kuvvet';

  @override
  String get dayLowerBody => 'Alt Vücut';

  @override
  String get dayPush => 'İtiş';

  @override
  String get dayPull => 'Çekiş';

  @override
  String get dayLegsCore => 'Bacak ve Karın';

  @override
  String get dayActiveRecovery => 'Aktif toparlanma';

  @override
  String get dayRest => 'Dinlenme';

  @override
  String get programFullBody => 'Tüm Vücut Programı';

  @override
  String get programUpperLower => 'Üst/Alt Bölünmüş Program';

  @override
  String get exBenchPress => 'Bench Press';

  @override
  String get exInclineDumbbellPress => 'Eğimli Dambıl Press';

  @override
  String get exOverheadPress => 'Omuz Press';

  @override
  String get exTricepsPushdown => 'Triceps Pushdown';

  @override
  String get exLateralRaise => 'Yana Açış';

  @override
  String get exDeadlift => 'Deadlift';

  @override
  String get exPullUp => 'Barfiks';

  @override
  String get exBarbellRow => 'Barbell Row';

  @override
  String get exFacePull => 'Face Pull';

  @override
  String get exBicepCurl => 'Biceps Curl';

  @override
  String get exBackSquat => 'Squat';

  @override
  String get exRomanianDeadlift => 'Romanian Deadlift';

  @override
  String get exLegPress => 'Leg Press';

  @override
  String get exWalkingLunge => 'Yürüyerek Lunge';

  @override
  String get exPlank => 'Plank';

  @override
  String get exGobletSquat => 'Goblet Squat';

  @override
  String get exPushUp => 'Şınav';

  @override
  String get exDumbbellRow => 'Dambıl Row';

  @override
  String activeWorkoutLastTime(String value) {
    return 'Geçen sefer: $value';
  }

  @override
  String get activeWorkoutSetHeader => 'SET';

  @override
  String get activeWorkoutPreviousHeader => 'ÖNCEKİ';

  @override
  String get activeWorkoutExercisesHeader => 'EGZERSİZLER';

  @override
  String activeWorkoutCurrentSet(int number) {
    return 'Set $number';
  }

  @override
  String activeWorkoutRestNext(String label) {
    return 'Sıradaki: $label';
  }

  @override
  String activeWorkoutFinishContent(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tamamladığın $count set kaydedilecek.',
    );
    return '$_temp0';
  }

  @override
  String get activeWorkoutFinishSave => 'Bitir ve kaydet';

  @override
  String get activeWorkoutDiscard => 'Kaydetmeden çık';

  @override
  String get activeWorkoutKeepGoing => 'Devam et';

  @override
  String get activeWorkoutFinishNow => 'Bitir';

  @override
  String activeWorkoutSetsDone(int done, int total) {
    return '$done/$total set';
  }

  @override
  String workoutSummaryExerciseLine(int sets, String best) {
    return '$sets set · en iyi $best';
  }

  @override
  String get workoutDetailMuscles => 'Kaslar';

  @override
  String workoutDetailRest(int seconds) {
    return '$seconds sn dinlenme';
  }

  @override
  String get equipmentBarbell => 'Halter';

  @override
  String get equipmentDumbbell => 'Dambıl';

  @override
  String get equipmentBench => 'Bench';

  @override
  String get equipmentCable => 'Kablo';

  @override
  String get equipmentMachine => 'Makineler';

  @override
  String get equipmentResistanceBand => 'Direnç bandı';

  @override
  String get equipmentBodyweight => 'Vücut ağırlığı';

  @override
  String get equipmentKettlebell => 'Kettlebell';

  @override
  String get aiChatSuggestion1 => 'Günde ne kadar protein almalıyım?';

  @override
  String get aiChatSuggestion2 => 'Antrenmandan önce ne yemeliyim?';

  @override
  String get aiChatSuggestion3 =>
      'Bench press\'te ilerleyemiyorum. Neyi değiştirmeliyim?';

  @override
  String get paywallAutoRenewNote =>
      'İptal edilene kadar otomatik yenilenir. App Store veya Google Play ayarlarından istediğin zaman iptal edebilirsin.';

  @override
  String get paywallTerms => 'Kullanım Koşulları';
}
