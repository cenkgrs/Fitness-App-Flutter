import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/achievements/presentation/screens/achievements_screen.dart';
import '../../features/coach/presentation/screens/ai_chat_screen.dart';
import '../../features/goals/presentation/screens/goals_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/nutrition/presentation/screens/food_logger_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_screen.dart';
import '../../features/onboarding/presentation/controllers/onboarding_controller.dart';
import '../../features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/settings/presentation/screens/privacy_policy_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/paywall_screen.dart';
import '../../features/workouts/presentation/screens/active_workout_screen.dart';
import '../../features/workouts/presentation/screens/workout_detail_screen.dart';
import '../../features/workouts/presentation/screens/workout_summary_screen.dart';
import '../../features/workouts/presentation/screens/workouts_screen.dart';
import '../widgets/splash_screen.dart';
import 'main_shell.dart';

/// Notifies go_router to re-evaluate `redirect` when auth/onboarding state
/// changes, without rebuilding the [GoRouter] instance itself. Rebuilding
/// GoRouter (e.g. via `ref.watch` inside the provider below) recreates the
/// whole Navigator tree, which wipes any in-progress screen's local state —
/// this bit the onboarding flow, whose step index reset to 0 whenever
/// `onboardingCompleteProvider` was invalidated mid-flow.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(authStateProvider, (_, __) => notifyListeners());
    ref.listen(onboardingCompleteProvider, (_, __) => notifyListeners());
    ref.listen(passwordRecoveryProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (loc == '/splash') return null;

      // A password-recovery deep link takes over regardless of onboarding
      // state — the user must set a new password before doing anything else.
      final isRecovering = ref.read(passwordRecoveryProvider).valueOrNull == true;
      if (isRecovering && loc != '/reset-password') return '/reset-password';
      if (!isRecovering && loc == '/reset-password') return '/home';

      final authState = ref.read(authStateProvider);
      if (authState.isLoading) return null;

      final user = authState.valueOrNull;
      final onboardingDone = ref.read(onboardingCompleteProvider);

      final goingToAuth = loc == '/auth';
      final goingToOnboarding = loc == '/onboarding';

      // Auth comes first: an account must exist before we build a plan for it.
      if (user == null && !goingToAuth) return '/auth';
      if (user != null && !onboardingDone && !goingToOnboarding) return '/onboarding';
      if (user != null && onboardingDone && (goingToAuth || goingToOnboarding)) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingFlowScreen()),
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      GoRoute(path: '/reset-password', builder: (context, state) => const ResetPasswordScreen()),
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
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                  routes: [
                    GoRoute(path: 'privacy-policy', builder: (context, state) => const PrivacyPolicyScreen()),
                    GoRoute(path: 'subscription', builder: (context, state) => const PaywallScreen()),
                  ],
                ),
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
        path: '/coach',
        builder: (context, state) => const AiChatScreen(),
      ),
      GoRoute(
        path: '/achievements',
        builder: (context, state) => const AchievementsScreen(),
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
