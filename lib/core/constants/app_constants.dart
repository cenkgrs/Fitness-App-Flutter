/// Non-visual magic numbers shared across features.
class AppConstants {
  AppConstants._();

  static const int onboardingStepCount = 14;
  static const Duration defaultRestDuration = Duration(seconds: 90);
  static const Duration restTimerWarningThreshold = Duration(seconds: 3);
  static const Duration splashMinDuration = Duration(milliseconds: 1200);

  // Progressive overload defaults
  static const double defaultWeightIncrementKg = 2.5;
  static const int repIncrement = 1;
}
