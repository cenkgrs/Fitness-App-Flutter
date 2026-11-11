import 'package:flutter/material.dart';

/// THRIVE+ color tokens: warm charcoal surfaces, cream text and a single
/// terracotta accent. Everything else stays neutral so the accent only
/// marks what's actionable or in progress.
class AppColors {
  AppColors._();

  // Backgrounds & Surfaces
  static const Color background = Color(0xFF141210);
  static const Color surface1 = Color(0xFF1C1916);
  static const Color surface2 = Color(0xFF26221E);
  static const Color surfaceBorder = Color(0xFF332E29);

  // Accent & Brand
  static const Color primary = Color(0xFFD06643);
  static const Color primaryDark = Color(0xFFB0532F);
  static const Color primarySoft = Color(0x24D06643);

  // Text
  static const Color textPrimary = Color(0xFFF3EEE7);
  static const Color textSecondary = Color(0xFFA39A8F);
  static const Color textTertiary = Color(0xFF6E665D);

  // Nutrition semantics — one accent plus two earthy neutrals, so the three
  // macros stay distinguishable without turning into a rainbow.
  static const Color protein = primary;
  static const Color carbs = Color(0xFFD6A65C);
  static const Color fat = Color(0xFF8C9F8A);
  static const Color calories = primary;
  static const Color water = Color(0xFF7FA3B8);

  // Status
  static const Color success = Color(0xFF7FA77A);
  static const Color warning = Color(0xFFD9A441);
  static const Color error = Color(0xFFD9483B);

  // On-color text (used on top of primary/success buttons)
  static const Color onPrimary = Color(0xFF17100C);
}
