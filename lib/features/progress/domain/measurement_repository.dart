import '../../../shared/models/models.dart';

/// The set of body-measurement metric keys this feature writes/reads via
/// [ProgressMetric.metricKey]. `progress_metrics` is a generic time-series
/// table (also usable for other metrics later, e.g. exercise 1RMs) — this
/// feature only owns the 'waist'/'neck'/... keys.
const measurementKeys = ['waist', 'neck', 'hip', 'chest', 'biceps', 'thigh'];

abstract class MeasurementRepository {
  Future<List<ProgressMetric>> getMeasurements(String userId);
  Future<void> addMeasurement(ProgressMetric metric);
}
