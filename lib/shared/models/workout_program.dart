import 'package:equatable/equatable.dart';
import 'exercise.dart';

/// A single day within a [WorkoutProgram] — either a training day (with
/// exercises) or a rest/recovery day (empty [exercises]).
class WorkoutDay extends Equatable {
  final String id;
  final String name; // e.g. "Push Day", "Rest & Recovery"
  final int dayOfWeek; // 1 = Monday .. 7 = Sunday
  final List<Exercise> exercises;
  final bool isRestDay;
  final Duration estimatedDuration;

  const WorkoutDay({
    required this.id,
    required this.name,
    required this.dayOfWeek,
    required this.exercises,
    this.isRestDay = false,
    required this.estimatedDuration,
  });

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets.length);

  double get estimatedVolumeKg => exercises.fold(
      0.0, (sum, e) => sum + e.sets.fold(0.0, (s, set) => s + set.targetWeightKg * set.targetReps));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dayOfWeek': dayOfWeek,
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'isRestDay': isRestDay,
        'estimatedDurationMinutes': estimatedDuration.inMinutes,
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json) => WorkoutDay(
        id: json['id'] as String,
        name: json['name'] as String,
        dayOfWeek: json['dayOfWeek'] as int,
        exercises: (json['exercises'] as List<dynamic>? ?? [])
            .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        isRestDay: json['isRestDay'] as bool? ?? false,
        estimatedDuration: Duration(minutes: json['estimatedDurationMinutes'] as int? ?? 45),
      );

  @override
  List<Object?> get props => [id, name, dayOfWeek, exercises, isRestDay, estimatedDuration];
}

/// A generated (or user-edited) weekly training program: Program -> Day -> Exercise -> Set.
class WorkoutProgram extends Equatable {
  final String id;
  final String userId;
  final String name; // e.g. "Upper/Lower Split"
  final List<WorkoutDay> days;
  final DateTime createdAt;

  const WorkoutProgram({
    required this.id,
    required this.userId,
    required this.name,
    required this.days,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'days': days.map((d) => d.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) => WorkoutProgram(
        id: json['id'] as String,
        userId: json['userId'] as String,
        name: json['name'] as String,
        days: (json['days'] as List<dynamic>? ?? [])
            .map((d) => WorkoutDay.fromJson(Map<String, dynamic>.from(d as Map)))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [id, userId, name, days, createdAt];
}
