import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/workout_program_generator.dart';
import '../domain/workout_repository.dart';

/// `workout_programs`/`workout_sessions` store `days`/`sets` as JSONB
/// mirroring `WorkoutDay`/`WorkoutSet`'s existing `toJson()`/`fromJson()`
/// shapes exactly — see that migration's comment for why this wasn't
/// normalized into separate tables.
class SupabaseWorkoutRepository implements WorkoutRepository {
  final sb.SupabaseClient _client;
  static const _generator = WorkoutProgramGenerator();

  SupabaseWorkoutRepository(this._client);

  WorkoutProgram _programFromRow(Map<String, dynamic> row) => WorkoutProgram(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        name: row['name'] as String,
        days: (row['days'] as List<dynamic>? ?? [])
            .map((d) => WorkoutDay.fromJson(Map<String, dynamic>.from(d as Map)))
            .toList(),
        createdAt: DateTime.parse(row['created_at'] as String),
      );

  WorkoutSession _sessionFromRow(Map<String, dynamic> row) => WorkoutSession(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        workoutDayId: row['workout_day_id'] as String,
        workoutDayName: row['workout_day_name'] as String,
        status: enumFromString(
            WorkoutSessionStatus.values, row['status'] as String?, WorkoutSessionStatus.notStarted),
        startedAt: DateTime.parse(row['started_at'] as String),
        completedAt:
            row['completed_at'] != null ? DateTime.parse(row['completed_at'] as String) : null,
        sets: (row['sets'] as List<dynamic>? ?? [])
            .map((s) => WorkoutSet.fromJson(Map<String, dynamic>.from(s as Map)))
            .toList(),
        personalRecordSetIds: (row['personal_record_set_ids'] as List<dynamic>? ?? []).cast<String>(),
      );

  @override
  Future<WorkoutProgram> getOrCreateProgram(UserProfile profile) async {
    final rows = await _client
        .from('workout_programs')
        .select()
        .eq('user_id', profile.userId)
        .order('created_at', ascending: false)
        .limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isNotEmpty) return _programFromRow(list.first);

    final program = _generator.generate(profile);
    final inserted = await _client.from('workout_programs').insert({
      'user_id': program.userId,
      'name': program.name,
      'days': program.days.map((d) => d.toJson()).toList(),
    }).select();
    return _programFromRow((inserted as List).cast<Map<String, dynamic>>().first);
  }

  @override
  Future<void> saveProgram(WorkoutProgram program) async {
    // Exactly one active program per user — matches the existing Hive
    // behavior of a single overwritten key, rather than accumulating a
    // program per regeneration.
    await _client.from('workout_programs').delete().eq('user_id', program.userId);
    await _client.from('workout_programs').insert({
      'user_id': program.userId,
      'name': program.name,
      'days': program.days.map((d) => d.toJson()).toList(),
    });
  }

  @override
  Future<List<WorkoutSession>> getSessions(String userId) async {
    final rows = await _client
        .from('workout_sessions')
        .select()
        .eq('user_id', userId)
        .order('started_at', ascending: false);
    return (rows as List).cast<Map<String, dynamic>>().map(_sessionFromRow).toList();
  }

  @override
  Future<WorkoutSession?> getSession(String sessionId) async {
    final rows = await _client.from('workout_sessions').select().eq('id', sessionId).limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isEmpty) return null;
    return _sessionFromRow(list.first);
  }

  @override
  Future<void> saveSession(WorkoutSession session) async {
    await _client.from('workout_sessions').upsert({
      'id': session.id,
      'user_id': session.userId,
      'workout_day_id': session.workoutDayId,
      'workout_day_name': session.workoutDayName,
      'status': session.status.name,
      'started_at': session.startedAt.toIso8601String(),
      'completed_at': session.completedAt?.toIso8601String(),
      'sets': session.sets.map((s) => s.toJson()).toList(),
      'personal_record_set_ids': session.personalRecordSetIds,
    });
  }
}
