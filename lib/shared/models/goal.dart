import 'package:equatable/equatable.dart';
import 'enums.dart';

/// A tracked user goal. Nutrition targets can be auto-calculated or
/// manually overridden (see [isManualNutrition]).
class Goal extends Equatable {
  final String id;
  final String userId;
  final PrimaryGoal type;
  final double? currentWeightKg;
  final double? targetWeightKg;
  final int weeklyWorkoutTarget;
  final int dailyCalorieTarget;
  final int dailyProteinTarget;
  final int dailyCarbsTarget;
  final int dailyFatTarget;
  final bool isManualNutrition;
  final DateTime createdAt;

  const Goal({
    required this.id,
    required this.userId,
    required this.type,
    this.currentWeightKg,
    this.targetWeightKg,
    required this.weeklyWorkoutTarget,
    required this.dailyCalorieTarget,
    required this.dailyProteinTarget,
    required this.dailyCarbsTarget,
    required this.dailyFatTarget,
    this.isManualNutrition = false,
    required this.createdAt,
  });

  Goal copyWith({
    PrimaryGoal? type,
    double? currentWeightKg,
    double? targetWeightKg,
    int? weeklyWorkoutTarget,
    int? dailyCalorieTarget,
    int? dailyProteinTarget,
    int? dailyCarbsTarget,
    int? dailyFatTarget,
    bool? isManualNutrition,
  }) {
    return Goal(
      id: id,
      userId: userId,
      type: type ?? this.type,
      currentWeightKg: currentWeightKg ?? this.currentWeightKg,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      weeklyWorkoutTarget: weeklyWorkoutTarget ?? this.weeklyWorkoutTarget,
      dailyCalorieTarget: dailyCalorieTarget ?? this.dailyCalorieTarget,
      dailyProteinTarget: dailyProteinTarget ?? this.dailyProteinTarget,
      dailyCarbsTarget: dailyCarbsTarget ?? this.dailyCarbsTarget,
      dailyFatTarget: dailyFatTarget ?? this.dailyFatTarget,
      isManualNutrition: isManualNutrition ?? this.isManualNutrition,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type.name,
        'currentWeightKg': currentWeightKg,
        'targetWeightKg': targetWeightKg,
        'weeklyWorkoutTarget': weeklyWorkoutTarget,
        'dailyCalorieTarget': dailyCalorieTarget,
        'dailyProteinTarget': dailyProteinTarget,
        'dailyCarbsTarget': dailyCarbsTarget,
        'dailyFatTarget': dailyFatTarget,
        'isManualNutrition': isManualNutrition,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json['id'] as String,
        userId: json['userId'] as String,
        type: enumFromString(PrimaryGoal.values, json['type'] as String?, PrimaryGoal.buildMuscle),
        currentWeightKg: (json['currentWeightKg'] as num?)?.toDouble(),
        targetWeightKg: (json['targetWeightKg'] as num?)?.toDouble(),
        weeklyWorkoutTarget: json['weeklyWorkoutTarget'] as int? ?? 3,
        dailyCalorieTarget: json['dailyCalorieTarget'] as int? ?? 2000,
        dailyProteinTarget: json['dailyProteinTarget'] as int? ?? 120,
        dailyCarbsTarget: json['dailyCarbsTarget'] as int? ?? 220,
        dailyFatTarget: json['dailyFatTarget'] as int? ?? 65,
        isManualNutrition: json['isManualNutrition'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        currentWeightKg,
        targetWeightKg,
        weeklyWorkoutTarget,
        dailyCalorieTarget,
        dailyProteinTarget,
        dailyCarbsTarget,
        dailyFatTarget,
        isManualNutrition,
        createdAt,
      ];
}
