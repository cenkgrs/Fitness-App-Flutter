import 'dart:math' as math;
import '../models/enums.dart';

class BodyFatResult {
  final double percent;
  final String category;
  const BodyFatResult({required this.percent, required this.category});
}

/// US Navy circumference method — a widely used, non-invasive body-fat
/// estimate from waist/neck(/hip) circumference plus height. Kept isolated
/// from UI/state so it can be unit-tested, mirroring [CalorieCalculator].
class BodyFatCalculator {
  const BodyFatCalculator();

  /// Returns null when required measurements are missing (hip is required
  /// for the female formula).
  BodyFatResult? calculate({
    required Gender gender,
    required double heightCm,
    required double waistCm,
    required double neckCm,
    double? hipCm,
  }) {
    final isFemale = gender == Gender.female;
    if (isFemale && hipCm == null) return null;

    final percent = isFemale
        ? 495 /
                (1.29579 -
                    0.35004 * _log10(waistCm + hipCm! - neckCm) +
                    0.22100 * _log10(heightCm)) -
            450
        : 495 / (1.0324 - 0.19077 * _log10(waistCm - neckCm) + 0.15456 * _log10(heightCm)) - 450;

    return BodyFatResult(percent: percent.clamp(2, 60), category: _category(isFemale, percent));
  }

  double _log10(double x) => math.log(x) / math.ln10;

  /// ACE body-fat category boundaries, applied per gender (unspecified
  /// falls back to the male formula/thresholds — the Navy method itself
  /// only defines a male and a female variant).
  String _category(bool isFemale, double percent) {
    final thresholds = isFemale ? const [13.0, 20.0, 24.0, 31.0] : const [5.0, 13.0, 17.0, 24.0];
    const labels = ['Temel Yağ', 'Atletik', 'Fit', 'Ortalama', 'Yüksek'];
    for (var i = 0; i < thresholds.length; i++) {
      if (percent < thresholds[i]) return labels[i];
    }
    return labels.last;
  }
}
