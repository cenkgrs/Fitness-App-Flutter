import '../models/enums.dart';

/// Converts and formats weight values (always stored internally as kg)
/// for display/input according to the user's chosen [WeightUnit].
class WeightFormatter {
  const WeightFormatter(this.unit);

  final WeightUnit unit;

  static const double _kgPerLb = 0.45359237;

  /// kg -> the unit's display value.
  double fromKg(double kg) {
    if (unit == WeightUnit.lbs) return kg / _kgPerLb;
    return kg;
  }

  /// A value entered by the user in the display unit -> kg for storage.
  double toKg(double value) {
    if (unit == WeightUnit.lbs) return value * _kgPerLb;
    return value;
  }

  String get suffix => unit == WeightUnit.lbs ? 'lb' : 'kg';

  /// Formats a stored kg value for display, e.g. "72.4 kg" / "159.7 lb".
  String format(double kg, {int decimals = 1}) {
    return '${fromKg(kg).toStringAsFixed(decimals)} $suffix';
  }
}
