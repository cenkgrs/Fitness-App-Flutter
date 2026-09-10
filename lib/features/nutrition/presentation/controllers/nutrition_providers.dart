import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../data/local_nutrition_repository.dart';
import '../../data/supabase_nutrition_repository.dart';
import '../../domain/nutrition_repository.dart';

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  if (SupabaseConfig.isConfigured) {
    return SupabaseNutritionRepository(Supabase.instance.client);
  }
  return LocalNutritionRepository(ref.watch(localStorageServiceProvider));
});

/// The date currently viewed on the Nutrition screen (defaults to today).
final selectedNutritionDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final dailyNutritionProvider = FutureProvider<DailyNutrition>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  final date = ref.watch(selectedNutritionDateProvider);
  final goal = await ref.watch(activeGoalProvider.future);
  final meals = await ref.watch(nutritionRepositoryProvider).getMealsForDate(user?.id ?? 'local', date);

  return DailyNutrition(
    date: date,
    meals: meals,
    calorieGoal: goal?.dailyCalorieTarget ?? 2000,
    proteinGoal: goal?.dailyProteinTarget ?? 120,
    carbsGoal: goal?.dailyCarbsTarget ?? 220,
    fatGoal: goal?.dailyFatTarget ?? 65,
  );
});

final weightEntriesProvider = FutureProvider<List<WeightEntry>>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  return ref.watch(nutritionRepositoryProvider).getWeightEntries(user?.id ?? 'local');
});
