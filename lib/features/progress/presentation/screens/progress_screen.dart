import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../shared/models/models.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../../domain/measurement_repository.dart';
import '../controllers/measurement_providers.dart';
import '../controllers/progress_providers.dart';
import '../widgets/consistency_heatmap.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          indicatorColor: AppColors.primary,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Weight'),
            Tab(text: 'Strength'),
            Tab(text: 'Consistency'),
            Tab(text: 'Ölçüler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_WeightTab(), _StrengthTab(), _ConsistencyTab(), _MeasurementsTab()],
      ),
    );
  }
}

class _WeightTab extends ConsumerWidget {
  const _WeightTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(weightChartPointsProvider);
    final goalAsync = ref.watch(activeGoalProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      children: [
        pointsAsync.when(
          loading: () => const LoadingShimmer(height: 220),
          error: (e, st) => Text('Error: $e'),
          data: (points) => LineChartCard(
            title: 'Weight (kg)',
            points: points,
            unit: ' kg',
            targetValue: goalAsync.valueOrNull?.targetWeightKg,
          ),
        ),
      ],
    );
  }
}

class _StrengthTab extends ConsumerWidget {
  const _StrengthTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressionAsync = ref.watch(strengthProgressionProvider);
    final namesAsync = ref.watch(exerciseNameByIdProvider);
    final selectedId = ref.watch(selectedStrengthExerciseProvider);

    return progressionAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.screenMargin),
        child: LoadingShimmer(height: 220),
      ),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (progression) {
        if (progression.isEmpty) {
          return const EmptyState(
            icon: Icons.show_chart,
            title: 'No strength data yet',
            message: 'Complete a workout to start tracking your 1RM progression.',
          );
        }
        final names = namesAsync.valueOrNull ?? {};
        final ids = progression.keys.toList();
        final activeId = selectedId != null && ids.contains(selectedId) ? selectedId : ids.first;

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          children: [
            DropdownButtonFormField<String>(
              initialValue: activeId,
              dropdownColor: AppColors.surface2,
              decoration: const InputDecoration(),
              items: ids
                  .map((id) => DropdownMenuItem(value: id, child: Text(names[id] ?? id)))
                  .toList(),
              onChanged: (v) => ref.read(selectedStrengthExerciseProvider.notifier).state = v,
            ),
            const SizedBox(height: AppSpacing.lg),
            LineChartCard(
              title: '${names[activeId] ?? activeId} Progression',
              points: progression[activeId] ?? const [],
              lineColor: AppColors.protein,
              unit: ' kg',
            ),
          ],
        );
      },
    );
  }
}

class _ConsistencyTab extends ConsumerWidget {
  const _ConsistencyTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(workoutSessionsProvider);
    final consistencyAsync = ref.watch(consistencyProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      children: [
        sessionsAsync.when(
          loading: () => const LoadingShimmer(height: 160),
          error: (e, st) => Text('Error: $e'),
          data: (sessions) => ConsistencyHeatmap(sessions: sessions),
        ),
        const SizedBox(height: AppSpacing.lg),
        consistencyAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (c) => Row(
            children: [
              Expanded(child: StatCard(icon: '🔥', value: '${c.currentStreak}', label: 'Current Streak')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: StatCard(icon: '🏆', value: '${c.longestStreak}', label: 'Longest Streak')),
            ],
          ),
        ),
      ],
    );
  }
}

const _measurementLabels = {
  'waist': 'Bel',
  'neck': 'Boyun',
  'hip': 'Kalça',
  'chest': 'Göğüs',
  'biceps': 'Kol',
  'thigh': 'Bacak',
};

class _MeasurementsTab extends ConsumerStatefulWidget {
  const _MeasurementsTab();

  @override
  ConsumerState<_MeasurementsTab> createState() => _MeasurementsTabState();
}

class _MeasurementsTabState extends ConsumerState<_MeasurementsTab> {
  String _selectedKey = 'waist';

  @override
  Widget build(BuildContext context) {
    final metricsAsync = ref.watch(measurementsProvider);
    final bodyFatAsync = ref.watch(bodyFatResultProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      children: [
        bodyFatAsync.when(
          loading: () => const LoadingShimmer(height: 96),
          error: (e, st) => const SizedBox.shrink(),
          data: (result) => result == null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text(
                    'Vücut yağı yüzdesini görmek için bel ve boyun ölçünü ekle.',
                    style: AppTypography.caption,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: StatCard(
                    icon: '📏',
                    value: '%${result.percent.toStringAsFixed(1)}',
                    label: 'Vücut Yağı — ${result.category}',
                  ),
                ),
        ),
        PrimaryButton(label: 'Ölçü Ekle', onPressed: () => _showAddSheet(context)),
        const SizedBox(height: AppSpacing.lg),
        metricsAsync.when(
          loading: () => const LoadingShimmer(height: 220),
          error: (e, st) => Text('Error: $e'),
          data: (metrics) {
            final byKey = <String, List<ChartPoint>>{};
            for (final key in measurementKeys) {
              byKey[key] = metrics
                  .where((m) => m.metricKey == key)
                  .map((m) => ChartPoint(m.date, m.value))
                  .toList();
            }
            if (metrics.isEmpty) {
              return const EmptyState(
                icon: Icons.straighten,
                title: 'Henüz ölçü yok',
                message: 'İlk ölçünü ekleyerek takibe başla.',
              );
            }
            return Column(
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _selectedKey,
                  dropdownColor: AppColors.surface2,
                  decoration: const InputDecoration(),
                  items: measurementKeys
                      .map((k) => DropdownMenuItem(value: k, child: Text(_measurementLabels[k]!)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedKey = v);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                LineChartCard(
                  title: '${_measurementLabels[_selectedKey]} (cm)',
                  points: byKey[_selectedKey] ?? const [],
                  lineColor: AppColors.carbs,
                  unit: ' cm',
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface1,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const _AddMeasurementSheet(),
    );
  }
}

class _AddMeasurementSheet extends ConsumerStatefulWidget {
  const _AddMeasurementSheet();

  @override
  ConsumerState<_AddMeasurementSheet> createState() => _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends ConsumerState<_AddMeasurementSheet> {
  final _controllers = {for (final k in measurementKeys) k: TextEditingController()};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(measurementControllerProvider);

    ref.listen(measurementControllerProvider, (prev, next) {
      if (!next.isLoading && !next.hasError && prev?.isLoading == true) {
        if (Navigator.canPop(context)) Navigator.pop(context);
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ölçü Ekle', style: AppTypography.headingMd),
          const SizedBox(height: AppSpacing.lg),
          for (final key in measurementKeys) ...[
            TextField(
              controller: _controllers[key],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: '${_measurementLabels[key]} (cm)'),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          const SizedBox(height: AppSpacing.sm),
          PrimaryButton(
            label: 'Kaydet',
            isLoading: state.isLoading,
            onPressed: () {
              final values = <String, double>{};
              for (final key in measurementKeys) {
                final parsed = double.tryParse(_controllers[key]!.text);
                if (parsed != null && parsed > 0) values[key] = parsed;
              }
              if (values.isEmpty) return;
              ref.read(measurementControllerProvider.notifier).addMeasurements(values);
            },
          ),
        ],
      ),
    );
  }
}
