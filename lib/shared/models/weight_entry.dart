import 'package:equatable/equatable.dart';

/// A single body-weight log point, used to render the weight progress chart
/// and compute goal-progress percentage.
class WeightEntry extends Equatable {
  final String id;
  final String userId;
  final DateTime date;
  final double weightKg;
  final String? note;

  const WeightEntry({
    required this.id,
    required this.userId,
    required this.date,
    required this.weightKg,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'weightKg': weightKg,
        'note': note,
      };

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
        id: json['id'] as String,
        userId: json['userId'] as String,
        date: DateTime.parse(json['date'] as String),
        weightKg: (json['weightKg'] as num).toDouble(),
        note: json['note'] as String?,
      );

  @override
  List<Object?> get props => [id, userId, date, weightKg, note];
}
