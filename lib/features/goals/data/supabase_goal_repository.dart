import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/goal_repository.dart';

/// The `goals` table is append-only by design (see its migration) — saving
/// a new goal just inserts a row, and "active" is always whichever is most
/// recent. Matches the existing single-active-goal behavior without needing
/// update/delete logic.
class SupabaseGoalRepository implements GoalRepository {
  final sb.SupabaseClient _client;

  SupabaseGoalRepository(this._client);

  Goal _fromRow(Map<String, dynamic> row) => Goal(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        type: enumFromString(PrimaryGoal.values, row['type'] as String?, PrimaryGoal.buildMuscle),
        currentWeightKg: (row['current_weight_kg'] as num?)?.toDouble(),
        targetWeightKg: (row['target_weight_kg'] as num?)?.toDouble(),
        weeklyWorkoutTarget: row['weekly_workout_target'] as int,
        dailyCalorieTarget: row['daily_calorie_target'] as int,
        dailyProteinTarget: row['daily_protein_target'] as int,
        dailyCarbsTarget: row['daily_carbs_target'] as int,
        dailyFatTarget: row['daily_fat_target'] as int,
        isManualNutrition: row['is_manual_nutrition'] as bool,
        createdAt: DateTime.parse(row['created_at'] as String),
      );

  @override
  Future<Goal?> getActiveGoal(String userId) async {
    final rows = await _client
        .from('goals')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isEmpty) return null;
    return _fromRow(list.first);
  }

  @override
  Future<void> saveGoal(Goal goal) async {
    await _client.from('goals').insert({
      'user_id': goal.userId,
      'type': goal.type.name,
      'current_weight_kg': goal.currentWeightKg,
      'target_weight_kg': goal.targetWeightKg,
      'weekly_workout_target': goal.weeklyWorkoutTarget,
      'daily_calorie_target': goal.dailyCalorieTarget,
      'daily_protein_target': goal.dailyProteinTarget,
      'daily_carbs_target': goal.dailyCarbsTarget,
      'daily_fat_target': goal.dailyFatTarget,
      'is_manual_nutrition': goal.isManualNutrition,
    });
  }
}
