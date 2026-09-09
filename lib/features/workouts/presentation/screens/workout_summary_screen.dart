import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/workout_providers.dart';

class WorkoutSummaryScreen extends ConsumerWidget {
  final String sessionId;
  const WorkoutSummaryScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionByIdProvider(sessionId));

    return Scaffold(
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (session) {
          if (session == null) return const Center(child: Text('Session not found'));
          final estCalories = (session.totalVolumeKg * 0.08).round();
          final prSets = session.sets.where((s) => session.personalRecordSetIds.contains(s.id)).toList();

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              children: [
                const SizedBox(height: AppSpacing.lg),
                Text('WORKOUT COMPLETE 🎉', style: AppTypography.headingLg, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xs),
                Text(session.workoutDayName, style: AppTypography.bodyMd, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xl),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.6,
                  children: [
                    StatCard(icon: '⏱', value: _formatDuration(session.duration), label: 'Duration'),
                    StatCard(icon: '🏋️', value: '${session.totalVolumeKg.round()} kg', label: 'Total Volume'),
                    StatCard(icon: '⚡', value: '${session.completedSetCount} Sets', label: 'Sets Completed'),
                    StatCard(icon: '🔥', value: '$estCalories kcal', label: 'Est. Calories'),
                  ],
                ),
                if (prSets.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  ...prSets.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppCard(
                          accentColor: AppColors.warning,
                          child: Row(
                            children: [
                              const Text('🏆', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  'NEW PR! ${s.actualWeightKg.toStringAsFixed(1)} kg × ${s.actualReps} reps',
                                  style: AppTypography.bodyLg.copyWith(color: AppColors.warning),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
                const SizedBox(height: AppSpacing.xl),
                AppCard(
                  child: Text(
                    'Harika bir iş çıkardın! Kasların güçleniyor ve hedefine bir adım daha yaklaştın.',
                    style: AppTypography.bodyMd,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: 'Finish & Return Home',
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$m:$s';
  }
}
