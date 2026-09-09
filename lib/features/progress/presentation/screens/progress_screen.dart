import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';
import '../controllers/progress_providers.dart';
import '../widgets/consistency_heatmap.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

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
          tabs: const [Tab(text: 'Weight'), Tab(text: 'Strength'), Tab(text: 'Consistency')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_WeightTab(), _StrengthTab(), _ConsistencyTab()],
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
              value: activeId,
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
