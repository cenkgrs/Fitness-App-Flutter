import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../shared/models/models.dart';
import '../domain/user_profile_repository.dart';
import 'local_user_profile_repository.dart';

/// Supabase-backed, with [LocalUserProfileRepository] as a read-through
/// cache — `hasCompletedOnboardingSync` is used by the router's redirect
/// logic and can't tolerate a network round trip, so that one read always
/// comes from the local mirror (kept fresh by every write here, and by the
/// cold-start/sign-in sync in `lib/core/providers/remote_sync.dart`).
class SupabaseUserProfileRepository implements UserProfileRepository {
  final sb.SupabaseClient _client;
  final LocalUserProfileRepository _local;

  SupabaseUserProfileRepository(this._client, this._local);

  UserProfile _fromRow(String userId, Map<String, dynamic> row) => UserProfile(
        userId: userId,
        name: row['name'] as String,
        age: row['age'] as int,
        heightCm: (row['height_cm'] as num).toDouble(),
        weightKg: (row['weight_kg'] as num).toDouble(),
        gender: enumFromString(Gender.values, row['gender'] as String?, Gender.unspecified),
        fitnessLevel:
            enumFromString(FitnessLevel.values, row['fitness_level'] as String?, FitnessLevel.beginner),
        primaryGoal:
            enumFromString(PrimaryGoal.values, row['primary_goal'] as String?, PrimaryGoal.buildMuscle),
        targetWeightKg: (row['target_weight_kg'] as num).toDouble(),
        workoutDaysPerWeek: row['workout_days_per_week'] as int,
        workoutDurationMinutes: row['workout_duration_minutes'] as int,
        workoutLocation:
            enumFromString(WorkoutLocation.values, row['workout_location'] as String?, WorkoutLocation.gym),
        availableEquipment: (row['available_equipment'] as List<dynamic>? ?? [])
            .map((e) => enumFromString(Equipment.values, e as String?, Equipment.bodyweight))
            .toList(),
        activityLevel: enumFromString(
            ActivityLevel.values, row['activity_level'] as String?, ActivityLevel.moderatelyActive),
        nutritionPreference: enumFromString(
            NutritionPreference.values, row['nutrition_preference'] as String?, NutritionPreference.standard),
      );

  Map<String, dynamic> _toRow(UserProfile profile) => {
        'name': profile.name,
        'age': profile.age,
        'height_cm': profile.heightCm,
        'weight_kg': profile.weightKg,
        'gender': profile.gender.name,
        'fitness_level': profile.fitnessLevel.name,
        'primary_goal': profile.primaryGoal.name,
        'target_weight_kg': profile.targetWeightKg,
        'workout_days_per_week': profile.workoutDaysPerWeek,
        'workout_duration_minutes': profile.workoutDurationMinutes,
        'workout_location': profile.workoutLocation.name,
        'available_equipment': profile.availableEquipment.map((e) => e.name).toList(),
        'activity_level': profile.activityLevel.name,
        'nutrition_preference': profile.nutritionPreference.name,
      };

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final rows = await _client.from('profiles').select().eq('id', userId).limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    if (list.isEmpty) return null;
    final profile = _fromRow(userId, list.first);
    await _local.saveProfile(profile);
    return profile;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    // The row already exists (created by the on_auth_user_created trigger
    // at sign-up), so this is always an update, never an insert.
    await _client.from('profiles').update(_toRow(profile)).eq('id', profile.userId);
    await _local.saveProfile(profile);
  }

  @override
  Future<bool> hasCompletedOnboarding(String userId) async {
    final rows = await _client.from('profiles').select('onboarding_complete').eq('id', userId).limit(1);
    final list = (rows as List).cast<Map<String, dynamic>>();
    return list.isEmpty ? false : (list.first['onboarding_complete'] as bool? ?? false);
  }

  @override
  bool hasCompletedOnboardingSync(String userId) => _local.hasCompletedOnboardingSync(userId);

  @override
  Future<void> markOnboardingComplete(String userId) async {
    await _client.from('profiles').update({'onboarding_complete': true}).eq('id', userId);
    await _local.markOnboardingComplete(userId);
  }
}
