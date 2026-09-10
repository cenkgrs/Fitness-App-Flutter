import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/local_goal_repository.dart';
import '../../data/supabase_goal_repository.dart';
import '../../domain/goal_repository.dart';

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  if (SupabaseConfig.isConfigured) {
    return SupabaseGoalRepository(Supabase.instance.client);
  }
  return LocalGoalRepository(ref.watch(localStorageServiceProvider));
});

final activeGoalProvider = FutureProvider<Goal?>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  return ref.watch(goalRepositoryProvider).getActiveGoal(user?.id ?? 'local');
});
