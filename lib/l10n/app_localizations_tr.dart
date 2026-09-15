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
  String get authSignUpTitle => 'Hesap Oluştur';

  @override
  String get authSignInTitle => 'Tekrar Hoş Geldin';

  @override
  String get authSignUpSubtitle =>
      'Önce bir hesap oluştur, sonra sana özel planını birlikte hazırlayalım.';

  @override
  String get authSignInSubtitle => 'Giriş yap ve kaldığın yerden devam et.';

  @override
  String get authContinueWithApple => 'Apple ile Devam Et';

  @override
  String get authContinueWithGoogle => 'Google ile Devam Et';

  @override
  String get authOrWithEmail => 'veya e-posta ile';

  @override
  String get authEmailHint => 'E-posta';

  @override
  String get authPasswordHint => 'Şifre';

  @override
  String get authSignUpButton => 'Kayıt Ol';

  @override
  String get authSignInButton => 'Giriş Yap';

  @override
  String get authSwitchToSignIn => 'Zaten hesabın var mı? Giriş Yap';

  @override
  String get authSwitchToSignUp => 'Hesabın yok mu? Kayıt Ol';

  @override
  String get authForgotPassword => 'Şifremi unuttum';

  @override
  String get authResetPasswordTitle => 'Şifreyi Sıfırla';

  @override
  String get authResetPasswordMessage =>
      'E-postanı gir, sana bir sıfırlama linki gönderelim.';

  @override
  String get authResetPasswordSend => 'Sıfırlama Linki Gönder';

  @override
  String get authResetPasswordSent =>
      'Bu e-posta kayıtlıysa bir sıfırlama linki gönderildi.';

  @override
  String get authResetPasswordFailed =>
      'Sıfırlama linki gönderilemedi. Tekrar dene.';

  @override
  String get authNewPasswordTitle => 'Yeni Şifre Belirle';

  @override
  String get authNewPasswordHint => 'Yeni şifre';

  @override
  String get authNewPasswordButton => 'Şifreyi Güncelle';

  @override
  String get authNewPasswordSuccess => 'Şifre güncellendi. Hazırsın.';

  @override
  String authErrorSnackbar(String error) {
    return 'Bir şeyler ters gitti: $error';
  }

  @override
  String get onboardingContinue => 'Devam Et';

  @override
  String get onboardingWelcomeHeadline => 'Zirve formuna ulaş';

  @override
  String get onboardingWelcomeSubtitle =>
      'Kişiselleştirilmiş antrenman ve beslenme planın için birkaç soru soracağız.';

  @override
  String get onboardingGetStarted => 'Başla';

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
  String get onboardingGenderUnspecified => 'Belirtmek İstemiyorum';

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
  String get fitnessIntermediateLabel => 'Orta Seviye';

  @override
  String get fitnessIntermediateSubtitle => 'Düzenli kaldırıyorum (1-3 yıl)';

  @override
  String get fitnessAdvancedLabel => 'İleri Seviye';

  @override
  String get fitnessAdvancedSubtitle =>
      'Ağır antrenman ve periyodizasyon (3+ yıl)';

  @override
  String get onboardingPrimaryGoalTitle => 'Ana hedefin nedir?';

  @override
  String get goalLoseWeight => 'Kilo Vermek';

  @override
  String get goalBuildMuscle => 'Kas Kazanmak';

  @override
  String get goalLoseFat => 'Yağ Oranını Azaltmak';

  @override
  String get goalMaintainFitness => 'Formda Kalmak';

  @override
  String get onboardingDaysPerWeekTitle =>
      'Haftada kaç gün antrenman yapmak istersin?';

  @override
  String get onboardingMostPopular => 'En popüler';

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
  String get locationBoth => 'Her İkisi';

  @override
  String get onboardingEquipmentLabel => 'Ekipman';

  @override
  String get onboardingActivityLevelTitle => 'Günlük aktivite seviyen nedir?';

  @override
  String get activitySedentaryLabel => 'Hareketsiz';

  @override
  String get activitySedentarySubtitle => 'Masa başı iş, az hareket';

  @override
  String get activityModeratelyActiveLabel => 'Orta Aktif';

  @override
  String get activityModeratelyActiveSubtitle => 'Günde ~7.500 adım';

  @override
  String get activityVeryActiveLabel => 'Çok Aktif';

  @override
  String get activityVeryActiveSubtitle => 'Günde 10.000+ adım, fiziksel iş';

  @override
  String get onboardingNutritionPrefTitle => 'Beslenme tercihin nedir?';

  @override
  String get nutritionStandard => 'Standart';

  @override
  String get nutritionHighProtein => 'Yüksek Protein';

  @override
  String get nutritionKeto => 'Ketojenik';

  @override
  String get nutritionVegetarian => 'Vejetaryen';

  @override
  String get nutritionVegan => 'Vegan';

  @override
  String get onboardingCalculatingLine1 =>
      'Metabolizma hızınız hesaplanıyor...';

  @override
  String get onboardingCalculatingLine2 =>
      'Hipertrofi hacminiz optimize ediliyor...';

  @override
  String onboardingPlanReadyTitle(String name) {
    return 'Planın Hazır, $name!';
  }

  @override
  String get onboardingDefaultName => 'Şampiyon';

  @override
  String get onboardingDailyCalories => 'Günlük Kalori';

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Karbonhidrat';

  @override
  String get macroFat => 'Yağ';

  @override
  String onboardingDaysPerWeekProgram(int days) {
    return 'Haftada $days Gün Program';
  }

  @override
  String get onboardingPlanTagline => 'Kas Gelişimi ve Yağ Kaybı';

  @override
  String get onboardingStartMyPlan => 'Planımı Başlat';

  @override
  String get homeGreetingMorning => 'Günaydın';

  @override
  String get homeGreetingAfternoon => 'İyi günler';

  @override
  String get homeGreetingEvening => 'İyi akşamlar';

  @override
  String get homeDefaultAthleteName => 'Sporcu';

  @override
  String get homeReadySubtitle => 'Güçlenmeye hazır mısın?';

  @override
  String homeCaloriesLeft(int count) {
    return '$count kaldı';
  }

  @override
  String get homeTodaysWorkoutLabel => 'BUGÜNÜN ANTRENMANI';

  @override
  String get homeRestDayMessage => 'Bugün dinlenme günü. 🧘';

  @override
  String get homeNoWorkoutPlanned => 'Henüz planlanmış antrenman yok.';

  @override
  String homeWorkoutSummary(int minutes, int count) {
    return '⏱ $minutes dk • 🏋️ $count egzersiz';
  }

  @override
  String get homeStartWorkout => 'Antrenmana Başla';

  @override
  String get homeWeightGoalLabel => 'KİLO HEDEFİ';

  @override
  String homeWeightRemaining(String kg) {
    return 'Kalan: $kg kg';
  }

  @override
  String get homeQuickActionAddMeal => 'Öğün Ekle';

  @override
  String get homeQuickActionLogWeight => 'Kilo Kaydet';

  @override
  String get homeQuickActionViewProgress => 'İlerlemeyi Gör';

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
  String get workoutsScreenTitle => 'Haftalık Program';

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
      'Kişisel rutinini oluşturmak için onboarding\'i tamamla.';

  @override
  String get workoutsCreateMyPlan => 'Planımı Oluştur';

  @override
  String get activeWorkoutNoExercises => 'Bu gün için egzersiz yok.';

  @override
  String activeWorkoutExerciseCounter(int current, int total) {
    return '$total egzersizden $current.';
  }

  @override
  String activeWorkoutSetCounter(int current, int total) {
    return 'SET $current / $total';
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
  String get activeWorkoutSkipExercise => 'Egzersizi Atla';

  @override
  String get activeWorkoutAddSet => 'Set Ekle';

  @override
  String get activeWorkoutCompleteSet => 'SETİ TAMAMLA';

  @override
  String get activeWorkoutEndTitle => 'Antrenmanı bitir?';

  @override
  String get activeWorkoutEndContent => 'Bu seanstaki ilerlemen kaybolacak.';

  @override
  String get activeWorkoutEndConfirm => 'Antrenmanı Bitir';

  @override
  String get workoutDetailNotFound => 'Antrenman bulunamadı';

  @override
  String get workoutDetailStartButton => 'ANTRENMANA BAŞLA';

  @override
  String get workoutSummarySessionNotFound => 'Seans bulunamadı';

  @override
  String get workoutSummaryComplete => 'ANTRENMAN TAMAMLANDI 🎉';

  @override
  String get workoutSummaryDuration => 'Süre';

  @override
  String get workoutSummaryTotalVolume => 'Toplam Hacim';

  @override
  String get workoutSummarySetsCompleted => 'Tamamlanan Set';

  @override
  String get workoutSummaryEstCalories => 'Tahmini Kalori';

  @override
  String workoutSummaryNewPr(String weight, String reps) {
    return 'YENİ REKOR! $weight kg × $reps tekrar';
  }

  @override
  String get workoutSummaryEncouragement =>
      'Harika bir iş çıkardın! Kasların güçleniyor ve hedefine bir adım daha yaklaştın.';

  @override
  String get workoutSummaryFinish => 'Bitir ve Ana Sayfaya Dön';

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
  String get mealTypeLunch => 'Öğle Yemeği';

  @override
  String get mealTypeDinner => 'Akşam Yemeği';

  @override
  String get mealTypeSnack => 'Atıştırmalık';

  @override
  String foodLoggerTitle(String mealType) {
    return '$mealType Ekle';
  }

  @override
  String get foodLoggerSearchTab => 'Ara';

  @override
  String get foodLoggerQuickAddTab => 'Hızlı Ekle';

  @override
  String get foodLoggerSearchHint => 'Yemek veya marka ara...';

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
  String get foodLoggerAiFillButton => 'AI ile Doldur';

  @override
  String get foodLoggerAiParsing => 'Ayrıştırılıyor...';

  @override
  String get foodLoggerOrManualEntry => 'veya manuel gir';

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
  String get quickAddEntryDefaultName => 'Hızlı Ekle';

  @override
  String get progressScreenTitle => 'İlerleme';

  @override
  String get progressTabWeight => 'Kilo';

  @override
  String get progressTabStrength => 'Güç';

  @override
  String get progressTabConsistency => 'Süreklilik';

  @override
  String get progressTabMeasurements => 'Ölçüler';

  @override
  String get progressWeightChartTitle => 'Kilo (kg)';

  @override
  String get progressStrengthEmptyTitle => 'Henüz güç verisi yok';

  @override
  String get progressStrengthEmptyMessage =>
      '1RM ilerlemeni takip etmeye başlamak için bir antrenman tamamla.';

  @override
  String progressStrengthChartTitle(String exercise) {
    return '$exercise İlerlemesi';
  }

  @override
  String get progressCurrentStreak => 'Güncel Seri';

  @override
  String get progressLongestStreak => 'En Uzun Seri';

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
    return 'Vücut Yağı — $category';
  }

  @override
  String get bodyFatCategoryEssential => 'Temel Yağ';

  @override
  String get bodyFatCategoryAthletic => 'Atletik';

  @override
  String get bodyFatCategoryFitness => 'Fit';

  @override
  String get bodyFatCategoryAverage => 'Ortalama';

  @override
  String get bodyFatCategoryHigh => 'Yüksek';

  @override
  String get measurementsAddButton => 'Ölçü Ekle';

  @override
  String get measurementsEmptyTitle => 'Henüz ölçü yok';

  @override
  String get measurementsEmptyMessage => 'İlk ölçünü ekleyerek takibe başla.';

  @override
  String measurementsChartTitle(String measurement) {
    return '$measurement (cm)';
  }

  @override
  String get measurementsSheetTitle => 'Ölçü Ekle';

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
      'Profilini oluşturmak için onboarding\'i tamamla.';

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
  String get profileSignOut => 'Çıkış Yap';

  @override
  String get goalsEmptyTitle => 'Hedef belirlenmemiş';

  @override
  String get goalsEmptyMessage =>
      'Hedeflerini belirlemek için onboarding\'i tamamla.';

  @override
  String get goalsCurrentLabel => 'Şu An';

  @override
  String get goalsTargetLabel => 'Hedef';

  @override
  String get goalsRemainingLabel => 'Kalan';

  @override
  String get goalsWeeklyWorkoutLabel => 'HAFTALIK ANTRENMAN HEDEFİ';

  @override
  String get goalsDailyCalorieLabel => 'GÜNLÜK KALORİ HEDEFİ';

  @override
  String get goalsProteinLabel => 'PROTEİN HEDEFİ';

  @override
  String get settingsWorkoutSection => 'Antrenman Ayarları';

  @override
  String get settingsDefaultRestTime => 'Varsayılan Dinlenme Süresi';

  @override
  String get settingsAutoStartNextSet => 'Sonraki Seti Otomatik Başlat';

  @override
  String get settingsWeightUnit => 'Ağırlık Birimi';

  @override
  String get settingsDistanceUnit => 'Mesafe Birimi';

  @override
  String get settingsSound => 'Ses';

  @override
  String get settingsHaptics => 'Titreşim';

  @override
  String get settingsCountdownBeep => 'Geri Sayım Sesi (3-2-1)';

  @override
  String get settingsNutritionSection => 'Beslenme Ayarları';

  @override
  String get settingsAutoCalculateTargets =>
      'Hedefleri otomatik hesapla (TDEE)';

  @override
  String get settingsFoodDatabase => 'Yemek Veritabanı';

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
  String get settingsEnableNotifications => 'Bildirimleri Etkinleştir';

  @override
  String get settingsAppearanceSection => 'Görünüm ve Dil';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem';

  @override
  String get settingsAccountSection => 'Hesap ve Destek';

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
  String get muscleGroupFullBody => 'Tüm Vücut';

  @override
  String get settingsSubscription => 'Abonelik';

  @override
  String get paywallTitle => 'THRIVE+ Premium';

  @override
  String get paywallSubtitle => 'Reklamları kaldır, AI koçluğunun kilidini aç.';

  @override
  String get paywallFeatureNoAds => 'Reklamsız';

  @override
  String get paywallFeatureAiWorkouts =>
      'AI ile oluşturulan antrenman programları';

  @override
  String get paywallFeatureAiMeals => 'AI ile öğün metni kaydı';

  @override
  String get paywallSubscribeButton => 'Abone Ol';

  @override
  String get paywallRestoreButton => 'Satın Alımları Geri Yükle';

  @override
  String get paywallUnavailable =>
      'Abonelikler henüz aktif değil — yakında tekrar bak.';

  @override
  String get paywallAlreadySubscribed => 'Zaten Premium üyesin. Teşekkürler!';

  @override
  String get paywallPurchaseFailed => 'Satın alma tamamlanamadı. Tekrar dene.';

  @override
  String get paywallRestoreSuccess => 'Satın alımlar geri yüklendi.';

  @override
  String get paywallRestoreNone =>
      'Bu hesap için önceki bir satın alma bulunamadı.';

  @override
  String get settingsSendFeedback => 'Geri Bildirim Gönder';

  @override
  String get settingsPrivacyPolicy => 'Gizlilik Politikası';

  @override
  String get settingsDeleteAccount => 'Hesabı Sil';

  @override
  String get settingsDeleteAccountConfirmTitle =>
      'Hesabını silmek istiyor musun?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Bu işlem hesabını ve tüm verilerini (antrenmanlar, beslenme kayıtları, ilerleme, her şey) kalıcı olarak siler. Geri alınamaz.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Kalıcı Olarak Sil';

  @override
  String get settingsDeleteAccountFailed => 'Hesap silinemedi. Tekrar dene.';

  @override
  String settingsSecondsFormat(int seconds) {
    return '$seconds sn';
  }

  @override
  String get mealCardNoItems => 'Henüz bir şey eklenmedi';

  @override
  String get mealCardAddFood => 'Yemek Ekle';

  @override
  String workoutCardSummary(int minutes, int count) {
    return '$minutes dk • $count egzersiz';
  }

  @override
  String exerciseCardSetsReps(int sets, int reps) {
    return '$sets Set × $reps Tekrar';
  }

  @override
  String exerciseCardLastBest(String value) {
    return 'Son: $value';
  }

  @override
  String get restTimerLabel => 'DİNLENME';

  @override
  String get restTimerSubtract => '-15sn';

  @override
  String get restTimerSkip => 'Dinlenmeyi Atla';

  @override
  String get restTimerAdd => '+30sn';

  @override
  String get splashTagline => 'Daha akıllı antrenman. Daha güçlü ol.';

  @override
  String get lineChartNoData => 'Henüz veri yok';

  @override
  String get weightLogButton => 'Kilo Kaydet';

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
}
