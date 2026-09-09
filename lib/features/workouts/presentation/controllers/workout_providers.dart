import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
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
