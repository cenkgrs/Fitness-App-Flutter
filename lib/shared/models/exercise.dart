import 'package:equatable/equatable.dart';
import 'enums.dart';

/// A single planned working set target within an [Exercise].
class ExerciseSet extends Equatable {
  final int setNumber;
  final int targetReps;
  final double targetWeightKg;
  final bool isWarmup;

  const ExerciseSet({
    required this.setNumber,
    required this.targetReps,
    required this.targetWeightKg,
    this.isWarmup = false,
  });

  ExerciseSet copyWith({int? setNumber, int? targetReps, double? targetWeightKg, bool? isWarmup}) {
    return ExerciseSet(
      setNumber: setNumber ?? this.setNumber,
      targetReps: targetReps ?? this.targetReps,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      isWarmup: isWarmup ?? this.isWarmup,
    );
  }

  Map<String, dynamic> toJson() => {
        'setNumber': setNumber,
        'targetReps': targetReps,
        'targetWeightKg': targetWeightKg,
        'isWarmup': isWarmup,
      };

  factory ExerciseSet.fromJson(Map<String, dynamic> json) => ExerciseSet(
        setNumber: json['setNumber'] as int,
        targetReps: json['targetReps'] as int,
        targetWeightKg: (json['targetWeightKg'] as num).toDouble(),
        isWarmup: json['isWarmup'] as bool? ?? false,
      );

  @override
  List<Object?> get props => [setNumber, targetReps, targetWeightKg, isWarmup];
}

/// A planned exercise within a [WorkoutDay]. Extensible: new fields (e.g.
/// tempo, superset group) can be added without breaking existing plans.
class Exercise extends Equatable {
  final String id;
  final String name;
  final MuscleGroup muscleGroup;
  final List<Equipment> equipment;
  final String instructions;
  final String? imageUrl;
  final String? videoUrl;
  final List<ExerciseSet> sets;
  final Duration restDuration;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.instructions,
    this.imageUrl,
    this.videoUrl,
    required this.sets,
    required this.restDuration,
  });

  Exercise copyWith({List<ExerciseSet>? sets, Duration? restDuration}) {
    return Exercise(
      id: id,
      name: name,
      muscleGroup: muscleGroup,
      equipment: equipment,
      instructions: instructions,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      sets: sets ?? this.sets,
      restDuration: restDuration ?? this.restDuration,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'muscleGroup': muscleGroup.name,
        'equipment': equipment.map((e) => e.name).toList(),
        'instructions': instructions,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'sets': sets.map((s) => s.toJson()).toList(),
        'restDurationSeconds': restDuration.inSeconds,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'] as String,
        name: json['name'] as String,
        muscleGroup:
            enumFromString(MuscleGroup.values, json['muscleGroup'] as String?, MuscleGroup.fullBody),
        equipment: (json['equipment'] as List<dynamic>? ?? [])
            .map((e) => enumFromString(Equipment.values, e as String?, Equipment.bodyweight))
            .toList(),
        instructions: json['instructions'] as String? ?? '',
        imageUrl: json['imageUrl'] as String?,
        videoUrl: json['videoUrl'] as String?,
        sets: (json['sets'] as List<dynamic>? ?? [])
            .map((s) => ExerciseSet.fromJson(s as Map<String, dynamic>))
            .toList(),
        restDuration: Duration(seconds: json['restDurationSeconds'] as int? ?? 90),
      );

  @override
  List<Object?> get props =>
      [id, name, muscleGroup, equipment, instructions, imageUrl, videoUrl, sets, restDuration];
}
