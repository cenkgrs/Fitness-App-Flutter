import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/services/body_fat_calculator.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../profile/presentation/controllers/profile_providers.dart';
import '../../data/local_measurement_repository.dart';
import '../../data/supabase_measurement_repository.dart';
import '../../domain/measurement_repository.dart';

final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  if (SupabaseConfig.isConfigured) {
    return SupabaseMeasurementRepository(Supabase.instance.client);
  }
  return LocalMeasurementRepository(ref.watch(localStorageServiceProvider));
});

final measurementsProvider = FutureProvider<List<ProgressMetric>>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  return ref.watch(measurementRepositoryProvider).getMeasurements(user?.id ?? 'local');
});

/// Most recent value per measurement key (e.g. {'waist': 82.0, 'neck': 38.0}).
final latestMeasurementsProvider = FutureProvider<Map<String, double>>((ref) async {
  final metrics = await ref.watch(measurementsProvider.future);
  final latest = <String, double>{};
  for (final m in metrics) {
    // metrics are sorted ascending by date, so later entries overwrite.
    latest[m.metricKey] = m.value;
  }
  return latest;
});

final bodyFatResultProvider = FutureProvider<BodyFatResult?>((ref) async {
  final profile = await ref.watch(userProfileProvider.future);
  if (profile == null) return null;
  final latest = await ref.watch(latestMeasurementsProvider.future);
  final waist = latest['waist'];
  final neck = latest['neck'];
  if (waist == null || neck == null) return null;

  return const BodyFatCalculator().calculate(
    gender: profile.gender,
    heightCm: profile.heightCm,
    waistCm: waist,
    neckCm: neck,
    hipCm: latest['hip'],
  );
});

class MeasurementController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// [values] maps a measurement key (see [measurementKeys]) to its cm
  /// value; only non-null/non-empty fields the user actually filled in are
  /// saved, each as its own [ProgressMetric] row dated today.
  Future<void> addMeasurements(Map<String, double> values) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userId = ref.read(authStateProvider).valueOrNull?.id ?? 'local';
      final repo = ref.read(measurementRepositoryProvider);
      final now = DateTime.now();
      for (final entry in values.entries) {
        await repo.addMeasurement(ProgressMetric(
          id: const Uuid().v4(),
          userId: userId,
          metricKey: entry.key,
          date: now,
          value: entry.value,
          unit: 'cm',
        ));
      }
      ref.invalidate(measurementsProvider);
    });
  }
}

final measurementControllerProvider =
    AsyncNotifierProvider<MeasurementController, void>(MeasurementController.new);
