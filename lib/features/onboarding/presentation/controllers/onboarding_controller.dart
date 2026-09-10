import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/models.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../profile/presentation/controllers/profile_providers.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../../../../shared/services/nutrition_calculator.dart';

/// Draft answers collected across the onboarding flow. Mutable-by-copy;
/// becomes a real [UserProfile] once the flow completes.
class OnboardingDraft {
  final String name;
  final int age;
  final double heightCm;
  final double weightKg;
  final Gender gender;
  final FitnessLevel fitnessLevel;
  final PrimaryGoal primaryGoal;
  final double targetWeightKg;
  final int workoutDaysPerWeek;
  final int workoutDurationMinutes;
  final WorkoutLocation workoutLocation;
  final List<Equipment> availableEquipment;
  final ActivityLevel activityLevel;
  final NutritionPreference nutritionPreference;

  const OnboardingDraft({
    this.name = '',
    this.age = 25,
    this.heightCm = 175,
    this.weightKg = 75,
    this.gender = Gender.unspecified,
    this.fitnessLevel = FitnessLevel.beginner,
    this.primaryGoal = PrimaryGoal.buildMuscle,
    this.targetWeightKg = 72,
    this.workoutDaysPerWeek = 4,
    this.workoutDurationMinutes = 45,
    this.workoutLocation = WorkoutLocation.gym,
    this.availableEquipment = const [],
    this.activityLevel = ActivityLevel.moderatelyActive,
    this.nutritionPreference = NutritionPreference.standard,
  });

  OnboardingDraft copyWith({
    String? name,
    int? age,
    double? heightCm,
    double? weightKg,
    Gender? gender,
    FitnessLevel? fitnessLevel,
    PrimaryGoal? primaryGoal,
    double? targetWeightKg,
    int? workoutDaysPerWeek,
    int? workoutDurationMinutes,
    WorkoutLocation? workoutLocation,
    List<Equipment>? availableEquipment,
    ActivityLevel? activityLevel,
    NutritionPreference? nutritionPreference,
  }) {
    return OnboardingDraft(
      name: name ?? this.name,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      gender: gender ?? this.gender,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      workoutDaysPerWeek: workoutDaysPerWeek ?? this.workoutDaysPerWeek,
      workoutDurationMinutes: workoutDurationMinutes ?? this.workoutDurationMinutes,
      workoutLocation: workoutLocation ?? this.workoutLocation,
      availableEquipment: availableEquipment ?? this.availableEquipment,
      activityLevel: activityLevel ?? this.activityLevel,
      nutritionPreference: nutritionPreference ?? this.nutritionPreference,
    );
  }

  UserProfile toProfile(String userId) => UserProfile(
        userId: userId,
        name: name,
        age: age,
        heightCm: heightCm,
        weightKg: weightKg,
        gender: gender,
        fitnessLevel: fitnessLevel,
        primaryGoal: primaryGoal,
        targetWeightKg: targetWeightKg,
        workoutDaysPerWeek: workoutDaysPerWeek,
        workoutDurationMinutes: workoutDurationMinutes,
        workoutLocation: workoutLocation,
        availableEquipment: availableEquipment,
        activityLevel: activityLevel,
        nutritionPreference: nutritionPreference,
      );
}

class OnboardingController extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void update(OnboardingDraft Function(OnboardingDraft) updater) {
    state = updater(state);
  }

  /// Persists the profile, computed nutrition goal, and onboarding-complete
  /// flag. Called from the "Your Plan Is Ready" screen's Start button, by
  /// which point the router has already required a signed-in account.
  Future<void> completeOnboarding() async {
    final userId = ref.read(authStateProvider).valueOrNull?.id ?? 'local';
    final profile = state.toProfile(userId);
    await ref.read(userProfileRepositoryProvider).saveProfile(profile);
    await ref.read(userProfileRepositoryProvider).markOnboardingComplete(userId);

    final macros = const NutritionCalculator().calculate(profile);
    await ref.read(goalRepositoryProvider).saveGoal(Goal(
          id: userId,
          userId: userId,
          type: profile.primaryGoal,
          currentWeightKg: profile.weightKg,
          targetWeightKg: profile.targetWeightKg,
          weeklyWorkoutTarget: profile.workoutDaysPerWeek,
          dailyCalorieTarget: macros.calories,
          dailyProteinTarget: macros.proteinG,
          dailyCarbsTarget: macros.carbsG,
          dailyFatTarget: macros.fatG,
          createdAt: DateTime.now(),
        ));

    ref.invalidate(onboardingCompleteProvider);
    ref.invalidate(userProfileProvider);
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingDraft>(OnboardingController.new);

/// Synchronous by design (Hive reads don't need to be async) so the
/// router's redirect logic can read it without an AsyncLoading gap.
final onboardingCompleteProvider = Provider<bool>((ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.id;
  if (userId == null) return false;
  final repo = ref.watch(userProfileRepositoryProvider);
  return repo.hasCompletedOnboardingSync(userId);
});
