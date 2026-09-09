import 'package:equatable/equatable.dart';
import 'enums.dart';

/// A single logged set during an active/completed workout — the *actual*
/// performance, as opposed to the planned [ExerciseSet] target.
class WorkoutSet extends Equatable {
  final String id;
  final String exerciseId;
  final int setNumber;
  final double targetWeightKg;
  final int targetReps;
  final double actualWeightKg;
  final int actualReps;
  final bool isCompleted;
  final int? rpe; // 1-10, optional
  final DateTime? completedAt;

  const WorkoutSet({
    required this.id,
    required this.exerciseId,
    required this.setNumber,
    required this.targetWeightKg,
    required this.targetReps,
    required this.actualWeightKg,
    required this.actualReps,
    this.isCompleted = false,
    this.rpe,
    this.completedAt,
  });

  bool get isPersonalRecordCandidate => isCompleted && actualWeightKg > 0;

  double get volumeKg => actualWeightKg * actualReps;

  WorkoutSet copyWith({
    double? actualWeightKg,
    int? actualReps,
    bool? isCompleted,
    int? rpe,
    DateTime? completedAt,
  }) {
    return WorkoutSet(
      id: id,
      exerciseId: exerciseId,
      setNumber: setNumber,
      targetWeightKg: targetWeightKg,
      targetReps: targetReps,
      actualWeightKg: actualWeightKg ?? this.actualWeightKg,
      actualReps: actualReps ?? this.actualReps,
      isCompleted: isCompleted ?? this.isCompleted,
      rpe: rpe ?? this.rpe,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseId': exerciseId,
        'setNumber': setNumber,
        'targetWeightKg': targetWeightKg,
        'targetReps': targetReps,
        'actualWeightKg': actualWeightKg,
        'actualReps': actualReps,
        'isCompleted': isCompleted,
        'rpe': rpe,
        'completedAt': completedAt?.toIso8601String(),
      };

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => WorkoutSet(
        id: json['id'] as String,
        exerciseId: json['exerciseId'] as String,
        setNumber: json['setNumber'] as int,
        targetWeightKg: (json['targetWeightKg'] as num).toDouble(),
        targetReps: json['targetReps'] as int,
        actualWeightKg: (json['actualWeightKg'] as num).toDouble(),
        actualReps: json['actualReps'] as int,
        isCompleted: json['isCompleted'] as bool? ?? false,
        rpe: json['rpe'] as int?,
        completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      );

  @override
  List<Object?> get props => [
        id,
        exerciseId,
        setNumber,
        targetWeightKg,
        targetReps,
        actualWeightKg,
        actualReps,
        isCompleted,
        rpe,
        completedAt,
      ];
}

/// A completed or in-progress workout instance, logged against a
/// [WorkoutDay] template. This is the source of truth for consistency
/// streaks, progress charts, and progressive-overload recommendations.
class WorkoutSession extends Equatable {
  final String id;
  final String userId;
  final String workoutDayId;
  final String workoutDayName;
  final WorkoutSessionStatus status;
  final DateTime startedAt;
  final DateTime? completedAt;
  final List<WorkoutSet> sets;
  final List<String> personalRecordSetIds;

  const WorkoutSession({
    required this.id,
    required this.userId,
    required this.workoutDayId,
    required this.workoutDayName,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.sets,
    this.personalRecordSetIds = const [],
  });

  Duration get duration =>
      (completedAt ?? DateTime.now()).difference(startedAt);

  int get completedSetCount => sets.where((s) => s.isCompleted).length;

  double get totalVolumeKg =>
      sets.where((s) => s.isCompleted).fold(0.0, (sum, s) => sum + s.volumeKg);

  bool get isCompleted => status == WorkoutSessionStatus.completed;

  WorkoutSession copyWith({
    WorkoutSessionStatus? status,
    DateTime? completedAt,
    List<WorkoutSet>? sets,
    List<String>? personalRecordSetIds,
  }) {
    return WorkoutSession(
      id: id,
      userId: userId,
      workoutDayId: workoutDayId,
      workoutDayName: workoutDayName,
      status: status ?? this.status,
      startedAt: startedAt,
      completedAt: completedAt ?? this.completedAt,
      sets: sets ?? this.sets,
      personalRecordSetIds: personalRecordSetIds ?? this.personalRecordSetIds,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'workoutDayId': workoutDayId,
        'workoutDayName': workoutDayName,
        'status': status.name,
        'startedAt': startedAt.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
        'sets': sets.map((s) => s.toJson()).toList(),
        'personalRecordSetIds': personalRecordSetIds,
      };

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => WorkoutSession(
        id: json['id'] as String,
        userId: json['userId'] as String,
        workoutDayId: json['workoutDayId'] as String,
        workoutDayName: json['workoutDayName'] as String,
        status: enumFromString(
            WorkoutSessionStatus.values, json['status'] as String?, WorkoutSessionStatus.notStarted),
        startedAt: DateTime.parse(json['startedAt'] as String),
        completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
        sets: (json['sets'] as List<dynamic>? ?? [])
            .map((s) => WorkoutSet.fromJson(s as Map<String, dynamic>))
            .toList(),
        personalRecordSetIds:
            (json['personalRecordSetIds'] as List<dynamic>? ?? []).cast<String>(),
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        workoutDayId,
        workoutDayName,
        status,
        startedAt,
        completedAt,
        sets,
        personalRecordSetIds,
      ];
}
