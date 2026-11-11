import 'package:flutter/material.dart';
import 'app_colors.dart';

/// THRIVE+ typography scale, set in Manrope (bundled under assets/fonts).
/// `displayLg`/`displayMd` are reserved for numeric values that must be
/// legible from a distance (active workout, rest timer), so they — and the
/// headings that usually carry numbers — use tabular figures to keep digits
/// from jittering as they change.
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Manrope';
  static const _tabular = [FontFeature.tabularFigures()];

  static const TextStyle displayLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 44,
    fontWeight: FontWeight.w700,
    height: 48 / 44,
    letterSpacing: -1.2,
    color: AppColors.textPrimary,
    fontFeatures: _tabular,
  );

  static const TextStyle displayMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 36 / 32,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
    fontFeatures: _tabular,
  );

  static const TextStyle headingLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 32 / 26,
    letterSpacing: -0.6,
    color: AppColors.textPrimary,
    fontFeatures: _tabular,
  );

  static const TextStyle headingMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 26 / 20,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
    fontFeatures: _tabular,
  );

  static const TextStyle headingSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
    letterSpacing: -0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    color: AppColors.textSecondary,
    fontFeatures: _tabular,
  );

  /// Small uppercase section label ("BUGÜNÜN ANTRENMANI").
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 14 / 11,
    letterSpacing: 1.2,
    color: AppColors.textTertiary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 20 / 16,
  );
}
