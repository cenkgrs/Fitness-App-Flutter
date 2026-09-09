import 'package:equatable/equatable.dart';

/// A generic time-series data point used for strength progression and other
/// analytics charts (e.g. estimated 1RM for a given exercise over time).
class ProgressMetric extends Equatable {
  final String id;
  final String userId;
  final String metricKey; // e.g. "exercise:bench_press_1rm"
  final DateTime date;
  final double value;
  final String unit; // "kg", "cm", "%"

  const ProgressMetric({
    required this.id,
    required this.userId,
    required this.metricKey,
    required this.date,
    required this.value,
    required this.unit,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'metricKey': metricKey,
        'date': date.toIso8601String(),
        'value': value,
        'unit': unit,
      };

  factory ProgressMetric.fromJson(Map<String, dynamic> json) => ProgressMetric(
        id: json['id'] as String,
        userId: json['userId'] as String,
        metricKey: json['metricKey'] as String,
        date: DateTime.parse(json['date'] as String),
        value: (json['value'] as num).toDouble(),
        unit: json['unit'] as String,
      );

  @override
  List<Object?> get props => [id, userId, metricKey, date, value, unit];
}
