import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Stable notification ids — one per reminder "slot" so scheduling a new
/// one-shot for today naturally replaces yesterday's (same id).
class NotificationIds {
  static const workoutReminder = 1001;
  static const lunchReminder = 1002;
  static const dinnerReminder = 1003;
}

/// Thin wrapper around flutter_local_notifications. Reminders are scheduled
/// as one-shot notifications for "the next occurrence of this time" rather
/// than an OS-level daily repeat, because whether a reminder should fire at
/// all depends on same-day app state (did the user already work out / log
/// that meal) — something a purely local, ahead-of-time-scheduled
/// notification can't evaluate for itself. See
/// core/providers/notification_scheduler.dart for the reschedule-on-state-
/// change logic that keeps these one-shots up to date.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  // Platform channel calls that never get a response (e.g. no real plugin
  // implementation registered — widget tests, or a misbehaving OEM ROM)
  // would otherwise hang indefinitely; every call into the plugin goes
  // through this so a stuck channel degrades to a no-op instead of hanging
  // the caller (and, in tests, the whole run).
  static Future<T?> _guarded<T>(Future<T> Function() call) async {
    try {
      return await call().timeout(const Duration(seconds: 5));
    } catch (_) {
      return null;
    }
  }

  static Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _guarded(() => _plugin.initialize(initSettings));
    _initialized = true;
  }

  static Future<bool> requestPermission() async {
    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl == null) return true;
    final granted = await _guarded(() => androidImpl.requestNotificationsPermission());
    return granted ?? true;
  }

  /// Schedules a one-shot notification for the next time [hour]:[minute]
  /// occurs (today if that time hasn't passed yet, otherwise tomorrow).
  /// Reuses [id] so calling this again for the same slot replaces the
  /// previous schedule instead of stacking duplicates.
  static Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await init();
    // Computed from Dart's own DateTime (which already knows the device's
    // local offset) rather than a named tz.Location, so this doesn't depend
    // on any platform plugin resolving the device's IANA timezone name —
    // tz.UTC combined with an absolute instant is timezone-name-agnostic
    // and still fires at the correct local wall-clock moment.
    final localNow = DateTime.now();
    var localTarget = DateTime(localNow.year, localNow.month, localNow.day, hour, minute);
    if (localTarget.isBefore(localNow)) {
      localTarget = localTarget.add(const Duration(days: 1));
    }
    final scheduled = tz.TZDateTime.from(localTarget.toUtc(), tz.UTC);
    await _guarded(() => _plugin.zonedSchedule(
          id,
          title,
          body,
          scheduled,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_reminders',
              'Daily reminders',
              importance: Importance.defaultImportance,
              priority: Priority.defaultPriority,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        ));
  }

  static Future<void> cancel(int id) => _guarded(() => _plugin.cancel(id));

  static Future<void> cancelAll() => _guarded(() => _plugin.cancelAll());
}
