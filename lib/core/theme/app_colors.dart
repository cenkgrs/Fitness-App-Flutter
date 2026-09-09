import 'package:flutter/material.dart';

/// Repwise dark, high-contrast "gym mode" color tokens.
class AppColors {
  AppColors._();

  // Backgrounds & Surfaces
  static const Color background = Color(0xFF0D0E11);
  static const Color surface1 = Color(0xFF16181D);
  static const Color surface2 = Color(0xFF20232B);
  static const Color surfaceBorder = Color(0xFF2A2E39);

  // Accent & Brand
  static const Color primary = Color(0xFFCCFF00);
  static const Color primaryDark = Color(0xFFA6D600);
  static const Color primarySoft = Color(0x1ACCFF00);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A5B5);
  static const Color textTertiary = Color(0xFF656B7D);

  // Nutrition semantics
  static const Color protein = Color(0xFF38B6FF);
  static const Color carbs = Color(0xFFFF9F1C);
  static const Color fat = Color(0xFFFF4081);
  static const Color calories = Color(0xFFCCFF00);

  // Status
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFFF3B30);

  // On-color text (used on top of primary/success buttons)
  static const Color onPrimary = background;
}
