import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/measurement_repository.dart';

class LocalMeasurementRepository implements MeasurementRepository {
  final LocalStorageService _storage;

  LocalMeasurementRepository(this._storage);

  @override
  Future<List<ProgressMetric>> getMeasurements(String userId) async {
    return _storage.metricsBox.values
        .map((raw) => ProgressMetric.fromJson(Map<String, dynamic>.from(raw as Map)))
        .where((m) => m.userId == userId)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Future<void> addMeasurement(ProgressMetric metric) async {
    await _storage.metricsBox.put(metric.id, metric.toJson());
  }
}
