import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/measurement_repository.dart';

class SupabaseMeasurementRepository implements MeasurementRepository {
  final sb.SupabaseClient _client;

  SupabaseMeasurementRepository(this._client);

  ProgressMetric _fromRow(Map<String, dynamic> row) => ProgressMetric(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        metricKey: row['metric_key'] as String,
        date: DateTime.parse(row['date'] as String),
        value: (row['value'] as num).toDouble(),
        unit: row['unit'] as String,
      );

  @override
  Future<List<ProgressMetric>> getMeasurements(String userId) async {
    final rows = await _client
        .from('progress_metrics')
        .select()
        .eq('user_id', userId)
        .inFilter('metric_key', measurementKeys)
        .order('date');
    return (rows as List).cast<Map<String, dynamic>>().map(_fromRow).toList();
  }

  @override
  Future<void> addMeasurement(ProgressMetric metric) async {
    await _client.from('progress_metrics').insert({
      'user_id': metric.userId,
      'metric_key': metric.metricKey,
      'date':
          '${metric.date.year.toString().padLeft(4, '0')}-${metric.date.month.toString().padLeft(2, '0')}-${metric.date.day.toString().padLeft(2, '0')}',
      'value': metric.value,
      'unit': metric.unit,
    });
  }
}
