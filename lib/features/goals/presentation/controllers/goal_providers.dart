import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/goal_repository.dart';

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepository(ref.watch(localStorageServiceProvider));
});

final activeGoalProvider = FutureProvider<Goal?>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  return ref.watch(goalRepositoryProvider).getActiveGoal(user?.id ?? 'local');
});
