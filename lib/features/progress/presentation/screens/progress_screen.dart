import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/services/body_fat_calculator.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../../domain/measurement_repository.dart';
import '../controllers/measurement_providers.dart';
import '../controllers/progress_providers.dart';
import '../widgets/consistency_heatmap.dart';

String _bodyFatCategoryLabel(AppLocalizations l10n, BodyFatCategory category) => switch (category) {
      BodyFatCategory.essential => l10n.bodyFatCategoryEssential,
      BodyFatCategory.athletic => l10n.bodyFatCategoryAthletic,
      BodyFatCategory.fitness => l10n.bodyFatCategoryFitness,
      BodyFatCategory.average => l10n.bodyFatCategoryAverage,
      BodyFatCategory.high => l10n.bodyFatCategoryHigh,
    };

String _measurementLabel(AppLocalizations l10n, String key) => switch (key) {
      'waist' => l10n.measurementWaist,
      'neck' => l10n.measurementNeck,
      'hip' => l10n.measurementHip,
      'chest' => l10n.measurementChest,
      'biceps' => l10n.measurementBiceps,
      'thigh' => l10n.measurementThigh,
      _ => key,
    };

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.progressScreenTitle),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          indicatorColor: AppColors.primary,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.progressTabWeight),
            Tab(text: l10n.progressTabStrength),
            Tab(text: l10n.progressTabConsistency),
            Tab(text: l10n.progressTabMeasurements),
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
    final l10n = AppLocalizations.of(context)!;
    final pointsAsync = ref.watch(weightChartPointsProvider);
    final goalAsync = ref.watch(activeGoalProvider);
    final formatter = ref.watch(weightFormatterProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      children: [
        pointsAsync.when(
          loading: () => const LoadingShimmer(height: 220),
          error: (e, st) => Text(l10n.genericError(e.toString())),
          data: (points) => LineChartCard(
            title: l10n.progressWeightChartTitle,
            points: points.map((p) => ChartPoint(p.date, formatter.fromKg(p.value))).toList(),
            unit: ' ${formatter.suffix}',
            targetValue: goalAsync.valueOrNull?.targetWeightKg != null
                ? formatter.fromKg(goalAsync.valueOrNull!.targetWeightKg!)
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: l10n.weightLogButton,
          onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.surface1,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) => const _LogWeightSheet(),
          ),
        ),
      ],
    );
  }
}

class _LogWeightSheet extends ConsumerStatefulWidget {
  const _LogWeightSheet();

  @override
  ConsumerState<_LogWeightSheet> createState() => _LogWeightSheetState();
}

class _LogWeightSheetState extends ConsumerState<_LogWeightSheet> {
  final _weight = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final entered = double.tryParse(_weight.text);
    if (entered == null || entered <= 0) return;
    setState(() => _saving = true);
    final formatter = ref.read(weightFormatterProvider);
    final userId = ref.read(authStateProvider).valueOrNull?.id ?? 'local';
    await ref.read(nutritionRepositoryProvider).addWeightEntry(WeightEntry(
          id: const Uuid().v4(),
          userId: userId,
          date: DateTime.now(),
          weightKg: formatter.toKg(entered),
        ));
    ref.invalidate(weightEntriesProvider);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final formatter = ref.watch(weightFormatterProvider);
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
          Text(l10n.weightLogButton, style: AppTypography.headingMd),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _weight,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(hintText: l10n.weightFieldHint, suffixText: formatter.suffix),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: l10n.commonSave, isLoading: _saving, onPressed: _save),
        ],
      ),
    );
  }
}

class _StrengthTab extends ConsumerWidget {
  const _StrengthTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final progressionAsync = ref.watch(strengthProgressionProvider);
    final namesAsync = ref.watch(exerciseNameByIdProvider);
    final selectedId = ref.watch(selectedStrengthExerciseProvider);
    final formatter = ref.watch(weightFormatterProvider);

    return progressionAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.screenMargin),
        child: LoadingShimmer(height: 220),
      ),
      error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
      data: (progression) {
        if (progression.isEmpty) {
          return EmptyState(
            icon: Icons.show_chart,
            title: l10n.progressStrengthEmptyTitle,
            message: l10n.progressStrengthEmptyMessage,
          );
        }
        final names = namesAsync.valueOrNull ?? {};
        // Sets logged against an exercise id that no longer exists in the
        // active program (e.g. history from before an AI regeneration, or
        // a regeneration that renamed the exercise) can't be labeled —
        // showing the raw id is worse than hiding that orphaned entry.
        final ids = progression.keys.where(names.containsKey).toList();
        if (ids.isEmpty) {
          return EmptyState(
            icon: Icons.show_chart,
            title: l10n.progressStrengthEmptyTitle,
            message: l10n.progressStrengthEmptyMessage,
          );
        }
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
              title: l10n.progressStrengthChartTitle(names[activeId] ?? activeId),
              points: (progression[activeId] ?? const [])
                  .map((p) => ChartPoint(p.date, formatter.fromKg(p.value)))
                  .toList(),
              lineColor: AppColors.protein,
              unit: ' ${formatter.suffix}',
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
    final l10n = AppLocalizations.of(context)!;
    final sessionsAsync = ref.watch(workoutSessionsProvider);
    final consistencyAsync = ref.watch(consistencyProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenMargin),
      children: [
        sessionsAsync.when(
          loading: () => const LoadingShimmer(height: 160),
          error: (e, st) => Text(l10n.genericError(e.toString())),
          data: (sessions) => ConsistencyHeatmap(sessions: sessions),
        ),
        const SizedBox(height: AppSpacing.lg),
        consistencyAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (c) => Row(
            children: [
              Expanded(child: StatCard(icon: '🔥', value: '${c.currentStreak}', label: l10n.progressCurrentStreak)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: StatCard(icon: '🏆', value: '${c.longestStreak}', label: l10n.progressLongestStreak)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MeasurementsTab extends ConsumerStatefulWidget {
  const _MeasurementsTab();

  @override
  ConsumerState<_MeasurementsTab> createState() => _MeasurementsTabState();
}

class _MeasurementsTabState extends ConsumerState<_MeasurementsTab> {
  String _selectedKey = 'waist';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.measurementsBodyFatHint,
                    style: AppTypography.caption,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: StatCard(
                    icon: '📏',
                    value: '%${result.percent.toStringAsFixed(1)}',
                    label: l10n.measurementsBodyFatLabel(_bodyFatCategoryLabel(l10n, result.category)),
                  ),
                ),
        ),
        PrimaryButton(label: l10n.measurementsAddButton, onPressed: () => _showAddSheet(context)),
        const SizedBox(height: AppSpacing.lg),
        metricsAsync.when(
          loading: () => const LoadingShimmer(height: 220),
          error: (e, st) => Text(l10n.genericError(e.toString())),
          data: (metrics) {
            final byKey = <String, List<ChartPoint>>{};
            for (final key in measurementKeys) {
              byKey[key] = metrics
                  .where((m) => m.metricKey == key)
                  .map((m) => ChartPoint(m.date, m.value))
                  .toList();
            }
            if (metrics.isEmpty) {
              return EmptyState(
                icon: Icons.straighten,
                title: l10n.measurementsEmptyTitle,
                message: l10n.measurementsEmptyMessage,
              );
            }
            return Column(
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _selectedKey,
                  dropdownColor: AppColors.surface2,
                  decoration: const InputDecoration(),
                  items: measurementKeys
                      .map((k) => DropdownMenuItem(value: k, child: Text(_measurementLabel(l10n, k))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedKey = v);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                LineChartCard(
                  title: l10n.measurementsChartTitle(_measurementLabel(l10n, _selectedKey)),
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
    final l10n = AppLocalizations.of(context)!;
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
          Text(l10n.measurementsSheetTitle, style: AppTypography.headingMd),
          const SizedBox(height: AppSpacing.lg),
          for (final key in measurementKeys) ...[
            TextField(
              controller: _controllers[key],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(hintText: l10n.measurementsFieldHint(_measurementLabel(l10n, key))),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          const SizedBox(height: AppSpacing.sm),
          PrimaryButton(
            label: l10n.commonSave,
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
