import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/ai/ai_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../../shared/services/consistency_service.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../profile/presentation/controllers/profile_providers.dart';
import '../../data/local_workout_repository.dart';
import '../../domain/workout_repository.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return LocalWorkoutRepository(ref.watch(localStorageServiceProvider));
});

final activeProgramProvider = FutureProvider<WorkoutProgram?>((ref) async {
  final profile = await ref.watch(userProfileProvider.future);
  if (profile == null) return null;
  return ref.watch(workoutRepositoryProvider).getOrCreateProgram(profile);
});

final workoutSessionsProvider = FutureProvider<List<WorkoutSession>>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  return ref.watch(workoutRepositoryProvider).getSessions(user?.id ?? 'local');
});

final consistencyProvider = FutureProvider<WeeklyConsistency>((ref) async {
  final sessions = await ref.watch(workoutSessionsProvider.future);
  return const ConsistencyService().compute(sessions);
});

final todaysWorkoutDayProvider = FutureProvider<WorkoutDay?>((ref) async {
  final program = await ref.watch(activeProgramProvider.future);
  if (program == null) return null;
  final weekday = DateTime.now().weekday; // 1=Mon..7=Sun
  try {
    return program.days.firstWhere((d) => d.dayOfWeek == weekday);
  } catch (_) {
    return null;
  }
});

final sessionByIdProvider = FutureProvider.family<WorkoutSession?, String>((ref, sessionId) async {
  return ref.watch(workoutRepositoryProvider).getSession(sessionId);
});

/// Regenerates the active program via [AIWorkoutCoach] on demand (button
/// tap only — no automatic/scheduled regeneration, per product decision).
class AIProgramRegenerationController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> regenerate() async {
    final coach = ref.read(aiWorkoutCoachProvider);
    if (coach == null) {
      state = AsyncError(StateError('AI is not configured'), StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final profile = await ref.read(userProfileProvider.future);
      if (profile == null) throw StateError('No profile to generate a plan from');
      final program = await coach.generateWorkoutPlan(profile);
      await ref.read(workoutRepositoryProvider).saveProgram(program);
      ref.invalidate(activeProgramProvider);
    });
  }
}

final aiProgramRegenerationControllerProvider =
    AsyncNotifierProvider<AIProgramRegenerationController, void>(AIProgramRegenerationController.new);
