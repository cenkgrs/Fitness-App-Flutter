import 'package:flutter/services.dart';

/// Centralizes haptic feedback rules from the gym-mode ergonomics spec:
/// heavy impact on set completion, selection clicks for the rest-timer
/// countdown, light impact for primary button taps.
class HapticsHelper {
  HapticsHelper._();

  /// Mirrors the user's Haptics setting; kept in sync by the app root.
  static bool enabled = true;

  static void buttonTap() {
    if (enabled) HapticFeedback.lightImpact();
  }

  static void setCompleted() {
    if (enabled) HapticFeedback.heavyImpact();
  }

  static void restTimerTick() {
    if (enabled) HapticFeedback.selectionClick();
  }

  static void restTimerFinished() {
    if (!enabled) return;
    HapticFeedback.vibrate();
    Future.delayed(const Duration(milliseconds: 120), HapticFeedback.vibrate);
  }
}
