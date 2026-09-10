import '../../../shared/models/models.dart';

/// Abstraction over [Goal] persistence — swap the local/Supabase
/// implementation without touching call sites (goal_providers.dart).
abstract class GoalRepository {
  Future<Goal?> getActiveGoal(String userId);
  Future<void> saveGoal(Goal goal);
}
