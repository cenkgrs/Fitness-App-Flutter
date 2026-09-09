import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/line_chart_card.dart';
import '../../../nutrition/presentation/controllers/nutrition_providers.dart';
import '../../../workouts/presentation/controllers/workout_providers.dart';

final weightChartPointsProvider = FutureProvider<List<ChartPoint>>((ref) async {
  final entries = await ref.watch(weightEntriesProvider.future);
  return entries.map((e) => ChartPoint(e.date, e.weightKg)).toList();
});

/// exerciseName -> chart points, using max weight lifted per completed session.
final strengthProgressionProvider = FutureProvider<Map<String, List<ChartPoint>>>((ref) async {
  final sessions = await ref.watch(workoutSessionsProvider.future);
  final byExercise = <String, Map<DateTime, double>>{};

  for (final session in sessions.where((s) => s.isCompleted)) {
    final date = session.completedAt ?? session.startedAt;
    final dayKey = DateTime(date.year, date.month, date.day);
    for (final set in session.sets.where((s) => s.isCompleted)) {
      final exerciseMap = byExercise.putIfAbsent(set.exerciseId, () => {});
      final current = exerciseMap[dayKey] ?? 0;
      if (set.actualWeightKg > current) exerciseMap[dayKey] = set.actualWeightKg;
    }
  }

  return byExercise.map((exerciseId, dateMap) {
    final sortedDates = dateMap.keys.toList()..sort();
    return MapEntry(exerciseId, sortedDates.map((d) => ChartPoint(d, dateMap[d]!)).toList());
  });
});

final exerciseNameByIdProvider = FutureProvider<Map<String, String>>((ref) async {
  final program = await ref.watch(activeProgramProvider.future);
  if (program == null) return {};
  final map = <String, String>{};
  for (final day in program.days) {
    for (final ex in day.exercises) {
      map[ex.id] = ex.name;
    }
  }
  return map;
});

final selectedStrengthExerciseProvider = StateProvider<String?>((ref) => null);
