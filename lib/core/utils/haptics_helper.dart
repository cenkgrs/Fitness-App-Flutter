import 'package:flutter/services.dart';

/// Centralizes haptic feedback rules from the gym-mode ergonomics spec:
/// heavy impact on set completion, selection clicks for the rest-timer
/// countdown, light impact for primary button taps.
class HapticsHelper {
  HapticsHelper._();

  static void buttonTap() => HapticFeedback.lightImpact();

  static void setCompleted() => HapticFeedback.heavyImpact();

  static void restTimerTick() => HapticFeedback.selectionClick();

  static void restTimerFinished() {
    HapticFeedback.vibrate();
    Future.delayed(const Duration(milliseconds: 120), HapticFeedback.vibrate);
  }
}
