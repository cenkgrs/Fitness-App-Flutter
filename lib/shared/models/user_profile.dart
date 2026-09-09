import 'package:equatable/equatable.dart';
import 'enums.dart';

/// Fitness profile collected during onboarding. Drives calorie/macro
/// targets and workout program generation.
class UserProfile extends Equatable {
  final String userId;
  final String name;
  final int age;
  final double heightCm;
  final double weightKg;
  final Gender gender;
  final FitnessLevel fitnessLevel;
  final PrimaryGoal primaryGoal;
  final double targetWeightKg;
  final int workoutDaysPerWeek;
  final int workoutDurationMinutes;
  final WorkoutLocation workoutLocation;
  final List<Equipment> availableEquipment;
  final ActivityLevel activityLevel;
  final NutritionPreference nutritionPreference;

  const UserProfile({
    required this.userId,
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.gender,
    required this.fitnessLevel,
    required this.primaryGoal,
    required this.targetWeightKg,
    required this.workoutDaysPerWeek,
    required this.workoutDurationMinutes,
    required this.workoutLocation,
    required this.availableEquipment,
    required this.activityLevel,
    required this.nutritionPreference,
  });

  static UserProfile empty(String userId) => UserProfile(
        userId: userId,
        name: '',
        age: 25,
        heightCm: 175,
        weightKg: 75,
        gender: Gender.unspecified,
        fitnessLevel: FitnessLevel.beginner,
        primaryGoal: PrimaryGoal.buildMuscle,
        targetWeightKg: 75,
        workoutDaysPerWeek: 3,
        workoutDurationMinutes: 45,
        workoutLocation: WorkoutLocation.gym,
        availableEquipment: const [],
        activityLevel: ActivityLevel.moderatelyActive,
        nutritionPreference: NutritionPreference.standard,
      );

  UserProfile copyWith({
    String? name,
    int? age,
    double? heightCm,
    double? weightKg,
    Gender? gender,
    FitnessLevel? fitnessLevel,
    PrimaryGoal? primaryGoal,
    double? targetWeightKg,
    int? workoutDaysPerWeek,
    int? workoutDurationMinutes,
    WorkoutLocation? workoutLocation,
    List<Equipment>? availableEquipment,
    ActivityLevel? activityLevel,
    NutritionPreference? nutritionPreference,
  }) {
    return UserProfile(
      userId: userId,
      name: name ?? this.name,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      gender: gender ?? this.gender,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      workoutDaysPerWeek: workoutDaysPerWeek ?? this.workoutDaysPerWeek,
      workoutDurationMinutes: workoutDurationMinutes ?? this.workoutDurationMinutes,
      workoutLocation: workoutLocation ?? this.workoutLocation,
      availableEquipment: availableEquipment ?? this.availableEquipment,
      activityLevel: activityLevel ?? this.activityLevel,
      nutritionPreference: nutritionPreference ?? this.nutritionPreference,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'gender': gender.name,
        'fitnessLevel': fitnessLevel.name,
        'primaryGoal': primaryGoal.name,
        'targetWeightKg': targetWeightKg,
        'workoutDaysPerWeek': workoutDaysPerWeek,
        'workoutDurationMinutes': workoutDurationMinutes,
        'workoutLocation': workoutLocation.name,
        'availableEquipment': availableEquipment.map((e) => e.name).toList(),
        'activityLevel': activityLevel.name,
        'nutritionPreference': nutritionPreference.name,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json['userId'] as String,
        name: json['name'] as String? ?? '',
        age: json['age'] as int? ?? 25,
        heightCm: (json['heightCm'] as num?)?.toDouble() ?? 175,
        weightKg: (json['weightKg'] as num?)?.toDouble() ?? 75,
        gender: enumFromString(Gender.values, json['gender'] as String?, Gender.unspecified),
        fitnessLevel: enumFromString(
            FitnessLevel.values, json['fitnessLevel'] as String?, FitnessLevel.beginner),
        primaryGoal: enumFromString(
            PrimaryGoal.values, json['primaryGoal'] as String?, PrimaryGoal.buildMuscle),
        targetWeightKg: (json['targetWeightKg'] as num?)?.toDouble() ?? 75,
        workoutDaysPerWeek: json['workoutDaysPerWeek'] as int? ?? 3,
        workoutDurationMinutes: json['workoutDurationMinutes'] as int? ?? 45,
        workoutLocation: enumFromString(
            WorkoutLocation.values, json['workoutLocation'] as String?, WorkoutLocation.gym),
        availableEquipment: (json['availableEquipment'] as List<dynamic>? ?? [])
            .map((e) => enumFromString(Equipment.values, e as String?, Equipment.bodyweight))
            .toList(),
        activityLevel: enumFromString(ActivityLevel.values, json['activityLevel'] as String?,
            ActivityLevel.moderatelyActive),
        nutritionPreference: enumFromString(NutritionPreference.values,
            json['nutritionPreference'] as String?, NutritionPreference.standard),
      );

  @override
  List<Object?> get props => [
        userId,
        name,
        age,
        heightCm,
        weightKg,
        gender,
        fitnessLevel,
        primaryGoal,
        targetWeightKg,
        workoutDaysPerWeek,
        workoutDurationMinutes,
        workoutLocation,
        availableEquipment,
        activityLevel,
        nutritionPreference,
      ];
}
