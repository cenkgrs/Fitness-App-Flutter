import 'dart:ui';

import 'package:flutter/widgets.dart' show WidgetsBinding, WidgetsFlutterBinding;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/nutrition/presentation/controllers/nutrition_providers.dart';
import '../../features/settings/presentation/controllers/settings_controller.dart';
import '../../features/workouts/presentation/controllers/workout_providers.dart';
import '../../shared/models/models.dart';
import '../services/notification_service.dart';

const _workoutReminderHour = 18;
const _lunchReminderHour = 12;
const _lunchReminderMinute = 30;
const _dinnerReminderHour = 19;

// Kept as plain string tables (not routed through .arb/AppLocalizations)
// because this runs from a Riverpod provider with no BuildContext to read
// localizations from — same reasoning as the static privacy policy screen.
const _strings = {
  'en': (
    workoutTitle: "Don't skip today",
    workoutBody: "You haven't logged a workout today — got 20 minutes?",
    mealTitle: 'Log your meal',
    lunchBody: 'Lunch time — add what you ate to stay on track.',
    dinnerBody: 'Dinner time — add what you ate to stay on track.',
  ),
  'tr': (
    workoutTitle: 'Bugünü atlama',
    workoutBody: 'Bugün antrenman kaydın yok — 20 dakikan var mı?',
    mealTitle: 'Öğününü kaydet',
    lunchBody: 'Öğle yemeği vakti — ne yediğini eklemeyi unutma.',
    dinnerBody: 'Akşam yemeği vakti — ne yediğini eklemeyi unutma.',
  ),
};

bool _isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year && date.month == now.month && date.day == now.day;
}

/// Re-evaluates the three daily reminder slots (workout / lunch / dinner)
/// against today's actual state and reschedules or cancels each
/// accordingly. Cheap to call repeatedly — flutter_local_notifications
/// scheduling the same id again simply replaces the pending one.
Future<void> refreshDailyReminders(Ref ref) async {
  final settings = ref.read(settingsControllerProvider);
  final lang = settings.languageCode == 'system'
      ? (PlatformDispatcher.instance.locale.languageCode == 'tr' ? 'tr' : 'en')
      : (settings.languageCode == 'tr' ? 'tr' : 'en');
  final t = _strings[lang]!;
  if (!settings.notificationsEnabled) {
    await NotificationService.cancelAll();
    return;
  }

  final userId = ref.read(authStateProvider).valueOrNull?.id;
  if (userId == null) return;

  // Workout reminder: skip if any session was completed today.
  final sessions = await ref.read(workoutSessionsProvider.future);
  final workedOutToday = sessions.any((s) => s.isCompleted && _isToday(s.completedAt ?? s.startedAt));
  if (workedOutToday) {
    await NotificationService.cancel(NotificationIds.workoutReminder);
  } else {
    await NotificationService.scheduleDaily(
      id: NotificationIds.workoutReminder,
      title: t.workoutTitle,
      body: t.workoutBody,
      hour: _workoutReminderHour,
      minute: 0,
    );
  }

  // Meal reminders: skip whichever of lunch/dinner is already logged today.
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final meals = await ref
      .read(nutritionRepositoryProvider)
      .getMealsForDate(userId, todayDate);
  final loggedTypes = meals.map((m) => m.type).toSet();

  if (loggedTypes.contains(MealType.lunch)) {
    await NotificationService.cancel(NotificationIds.lunchReminder);
  } else {
    await NotificationService.scheduleDaily(
      id: NotificationIds.lunchReminder,
      title: t.mealTitle,
      body: t.lunchBody,
      hour: _lunchReminderHour,
      minute: _lunchReminderMinute,
    );
  }

  if (loggedTypes.contains(MealType.dinner)) {
    await NotificationService.cancel(NotificationIds.dinnerReminder);
  } else {
    await NotificationService.scheduleDaily(
      id: NotificationIds.dinnerReminder,
      title: t.mealTitle,
      body: t.dinnerBody,
      hour: _dinnerReminderHour,
      minute: 0,
    );
  }
}

/// Watched once from RepwiseApp.build() (same pattern as authSyncProvider) —
/// re-runs refreshDailyReminders whenever the inputs it depends on change,
/// so reminders stay in sync with real app state without every call site
/// (completing a workout, saving a meal) having to remember to trigger it.
final notificationSchedulerProvider = Provider<void>((ref) {
  // WidgetsFlutterBinding only backs the real running app — under
  // `flutter test` the binding is TestWidgetsFlutterBinding instead.
  // Bailing out before any ref.listen() below matters: listening to a
  // provider evaluates it immediately (whether or not the callback itself
  // ever runs), and widget tests that pump the full app from a signed-out
  // state (see test/widget_test.dart) have no real backend behind
  // workoutSessionsProvider/dailyNutritionProvider for that eager
  // evaluation to safely resolve. Real devices are unaffected.
  if (WidgetsBinding.instance is! WidgetsFlutterBinding) return;

  // Bounded end-to-end: refreshDailyReminders reads several other providers
  // (workout sessions, meals) before it ever touches the notification
  // plugin — if any of those hang (a slow/broken backend), this must still
  // give up rather than leaving a dangling Future behind.
  void refresh() {
    refreshDailyReminders(ref).timeout(const Duration(seconds: 8)).catchError((_) {});
  }

  ref.listen(authStateProvider, (_, __) => refresh());
  ref.listen(settingsControllerProvider, (_, __) => refresh());
  ref.listen(workoutSessionsProvider, (_, __) => refresh());
  ref.listen(dailyNutritionProvider, (_, __) => refresh());

  refresh();
});
