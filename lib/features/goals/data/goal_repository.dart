import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';

/// Persists the user's active [Goal] (nutrition + weight + workout targets).
class GoalRepository {
  final LocalStorageService _storage;
  static const _key = 'active_goal';

  GoalRepository(this._storage);

  Future<Goal?> getActiveGoal(String userId) async {
    final raw = _storage.goalsBox.get(_key);
    if (raw == null) return null;
    return Goal.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  Future<void> saveGoal(Goal goal) async {
    await _storage.goalsBox.put(_key, goal.toJson());
  }
}
