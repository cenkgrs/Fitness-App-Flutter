import '../../../shared/models/models.dart';

/// Abstraction over workout program + session persistence. Local/Hive
/// implementation today; swappable for a remote backend later.
abstract class WorkoutRepository {
  Future<WorkoutProgram> getOrCreateProgram(UserProfile profile);
  Future<void> saveProgram(WorkoutProgram program);

  Future<List<WorkoutSession>> getSessions(String userId);
  Future<WorkoutSession?> getSession(String sessionId);
  Future<void> saveSession(WorkoutSession session);
}
