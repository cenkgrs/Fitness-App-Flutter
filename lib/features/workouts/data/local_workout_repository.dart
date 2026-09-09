import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/workout_program_generator.dart';
import '../domain/workout_repository.dart';

class LocalWorkoutRepository implements WorkoutRepository {
  final LocalStorageService _storage;
  static const _programKey = 'active_program';
  static const _generator = WorkoutProgramGenerator();

  LocalWorkoutRepository(this._storage);

  @override
  Future<WorkoutProgram> getOrCreateProgram(UserProfile profile) async {
    final raw = _storage.programsBox.get(_programKey);
    if (raw != null) {
      return WorkoutProgram.fromJson(Map<String, dynamic>.from(raw as Map));
    }
    final program = _generator.generate(profile);
    await saveProgram(program);
    return program;
  }

  @override
  Future<void> saveProgram(WorkoutProgram program) async {
    await _storage.programsBox.put(_programKey, program.toJson());
  }

  @override
  Future<List<WorkoutSession>> getSessions(String userId) async {
    return _storage.sessionsBox.values
        .map((raw) => WorkoutSession.fromJson(Map<String, dynamic>.from(raw as Map)))
        .where((s) => s.userId == userId)
        .toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
  }

  @override
  Future<WorkoutSession?> getSession(String sessionId) async {
    final raw = _storage.sessionsBox.get(sessionId);
    if (raw == null) return null;
    return WorkoutSession.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  @override
  Future<void> saveSession(WorkoutSession session) async {
    await _storage.sessionsBox.put(session.id, session.toJson());
  }
}
