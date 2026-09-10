import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Persisted user preferences (Settings screen). Nutrition/workout defaults
/// here are used as fallbacks and overridden by [Goal] where applicable.
class AppSettings extends Equatable {
  final WeightUnit weightUnit;
  final DistanceUnit distanceUnit;
  final Duration defaultRestTime;
  final bool autoStartNextSet;
  final bool soundEnabled;
  final bool hapticsEnabled;
  final bool countdownBeepEnabled;
  final bool notificationsEnabled;
  /// 'system' (follow device locale, falling back to English) | 'en' | 'tr'.
  final String languageCode;
  final bool useAutoNutritionCalculation;
  /// Open Food Facts country tag (e.g. 'Turkey', 'Germany') to restrict food
  /// search results to; '' means no filter (global catalog).
  final String foodSearchCountry;

  const AppSettings({
    this.weightUnit = WeightUnit.kg,
    this.distanceUnit = DistanceUnit.km,
    this.defaultRestTime = const Duration(seconds: 90),
    this.autoStartNextSet = false,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
    this.countdownBeepEnabled = true,
    this.notificationsEnabled = true,
    this.languageCode = 'system',
    this.useAutoNutritionCalculation = true,
    this.foodSearchCountry = '',
  });

  AppSettings copyWith({
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    Duration? defaultRestTime,
    bool? autoStartNextSet,
    bool? soundEnabled,
    bool? hapticsEnabled,
    bool? countdownBeepEnabled,
    bool? notificationsEnabled,
    String? languageCode,
    bool? useAutoNutritionCalculation,
    String? foodSearchCountry,
  }) {
    return AppSettings(
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      defaultRestTime: defaultRestTime ?? this.defaultRestTime,
      autoStartNextSet: autoStartNextSet ?? this.autoStartNextSet,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      countdownBeepEnabled: countdownBeepEnabled ?? this.countdownBeepEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      languageCode: languageCode ?? this.languageCode,
      useAutoNutritionCalculation:
          useAutoNutritionCalculation ?? this.useAutoNutritionCalculation,
      foodSearchCountry: foodSearchCountry ?? this.foodSearchCountry,
    );
  }

  Map<String, dynamic> toJson() => {
        'weightUnit': weightUnit.name,
        'distanceUnit': distanceUnit.name,
        'defaultRestTimeSeconds': defaultRestTime.inSeconds,
        'autoStartNextSet': autoStartNextSet,
        'soundEnabled': soundEnabled,
        'hapticsEnabled': hapticsEnabled,
        'countdownBeepEnabled': countdownBeepEnabled,
        'notificationsEnabled': notificationsEnabled,
        'languageCode': languageCode,
        'useAutoNutritionCalculation': useAutoNutritionCalculation,
        'foodSearchCountry': foodSearchCountry,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        weightUnit: enumFromString(WeightUnit.values, json['weightUnit'] as String?, WeightUnit.kg),
        distanceUnit:
            enumFromString(DistanceUnit.values, json['distanceUnit'] as String?, DistanceUnit.km),
        defaultRestTime: Duration(seconds: json['defaultRestTimeSeconds'] as int? ?? 90),
        autoStartNextSet: json['autoStartNextSet'] as bool? ?? false,
        soundEnabled: json['soundEnabled'] as bool? ?? true,
        hapticsEnabled: json['hapticsEnabled'] as bool? ?? true,
        countdownBeepEnabled: json['countdownBeepEnabled'] as bool? ?? true,
        notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
        languageCode: json['languageCode'] as String? ?? 'system',
        useAutoNutritionCalculation: json['useAutoNutritionCalculation'] as bool? ?? true,
        foodSearchCountry: json['foodSearchCountry'] as String? ?? '',
      );

  @override
  List<Object?> get props => [
        weightUnit,
        distanceUnit,
        defaultRestTime,
        autoStartNextSet,
        soundEnabled,
        hapticsEnabled,
        countdownBeepEnabled,
        notificationsEnabled,
        languageCode,
        useAutoNutritionCalculation,
        foodSearchCountry,
      ];
}
