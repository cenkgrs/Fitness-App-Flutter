// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Repwise';

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
}
