import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/goals/presentation/screens/goals_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/nutrition/presentation/screens/food_logger_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_screen.dart';
import '../../features/onboarding/presentation/controllers/onboarding_controller.dart';
import '../../features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/workouts/presentation/screens/active_workout_screen.dart';
import '../../features/workouts/presentation/screens/workout_detail_screen.dart';
import '../../features/workouts/presentation/screens/workout_summary_screen.dart';
import '../../features/workouts/presentation/screens/workouts_screen.dart';
import '../widgets/splash_screen.dart';
import 'main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final onboardingState = ref.watch(onboardingCompleteProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (loc == '/splash') return null;

      final isAuthLoading = authState.isLoading;
      if (isAuthLoading) return null;

      final user = authState.valueOrNull;
      final onboardingDone = onboardingState.valueOrNull ?? false;

      final goingToAuth = loc == '/auth';
      final goingToOnboarding = loc == '/onboarding';

      if (!onboardingDone && !goingToOnboarding) return '/onboarding';
      if (onboardingDone && user == null && !goingToAuth) return '/auth';
      if (onboardingDone && user != null && (goingToAuth || goingToOnboarding)) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingFlowScreen()),
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/workouts',
              builder: (context, state) => const WorkoutsScreen(),
              routes: [
                GoRoute(
                  path: 'day/:dayId',
                  builder: (context, state) =>
                      WorkoutDetailScreen(dayId: state.pathParameters['dayId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/nutrition',
              builder: (context, state) => const NutritionScreen(),
              routes: [
                GoRoute(
                  path: 'log/:mealType',
                  builder: (context, state) =>
                      FoodLoggerScreen(mealType: state.pathParameters['mealType']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/progress', builder: (context, state) => const ProgressScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(path: 'settings', builder: (context, state) => const SettingsScreen()),
              ],
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/workout/active/:dayId',
        builder: (context, state) => ActiveWorkoutScreen(dayId: state.pathParameters['dayId']!),
      ),
      GoRoute(
        path: '/workout/summary/:sessionId',
        builder: (context, state) =>
            WorkoutSummaryScreen(sessionId: state.pathParameters['sessionId']!),
      ),
    ],
  );
});
