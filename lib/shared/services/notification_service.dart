/// Abstraction over local/push notifications. No concrete OS integration is
/// wired up yet (no permissions requested) — this defines the contract so
/// features can schedule reminders now and a real implementation
/// (flutter_local_notifications / FCM) can be dropped in later without
/// touching call sites.
abstract class NotificationService {
  Future<void> requestPermission();

  Future<void> scheduleWorkoutReminder({required DateTime workoutTime, required String workoutName});

  Future<void> sendStreakReminder({required int currentStreak});

  Future<void> sendMacroReminder({required String macroName, required double remainingGrams});

  Future<void> cancelAll();
}

/// No-op/log-only implementation used until a real push provider is wired
/// in. Safe to use in tests and in environments without notification
/// permissions.
class LocalNotificationService implements NotificationService {
  final List<String> sentLog = [];

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> scheduleWorkoutReminder({required DateTime workoutTime, required String workoutName}) async {
    sentLog.add('Your workout "$workoutName" starts in 30 minutes.');
  }

  @override
  Future<void> sendStreakReminder({required int currentStreak}) async {
    sentLog.add("Don't break your streak! You're on $currentStreak days.");
  }

  @override
  Future<void> sendMacroReminder({required String macroName, required double remainingGrams}) async {
    sentLog.add("You're ${remainingGrams.round()}g away from your $macroName goal.");
  }

  @override
  Future<void> cancelAll() async {
    sentLog.clear();
  }
}
