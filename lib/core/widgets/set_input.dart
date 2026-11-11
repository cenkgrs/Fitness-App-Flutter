import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/haptics_helper.dart';

/// Large stepper control for Gym Mode — value plus [-]/[+] buttons sized to
/// a minimum 52x52dp touch target for sweaty-hands ergonomics. Tapping the
/// value itself opens [onTapValue] (typically a keypad) for jumps the
/// steppers would make tedious.
class SetInput extends StatelessWidget {
  final String label;
  final String displayValue;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onTapValue;

  const SetInput({
    super.key,
    required this.label,
    required this.displayValue,
    required this.onIncrement,
    required this.onDecrement,
    this.onTapValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.md, AppSpacing.sm, AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.overline),
          const SizedBox(height: AppSpacing.xs),
          // FittedBox scales the whole control (buttons included) down to
          // whatever width it's actually given, instead of relying on a
          // guessed max value width — two of these stepper pairs must fit
          // side-by-side even on the narrowest phones, and a fixed-width
          // guess (e.g. capping the text at 76dp) still overflowed once the
          // weight reached 3 digits ("100.0").
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepButton(icon: AppIcons.minus, onTap: onDecrement),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTapValue,
                  child: SizedBox(
                    width: 92,
                    child: Text(
                      displayValue,
                      textAlign: TextAlign.center,
                      style: AppTypography.displayMd,
                    ),
                  ),
                ),
                _StepButton(icon: AppIcons.plus, onTap: onIncrement),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface2,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          HapticsHelper.buttonTap();
          onTap();
        },
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: AppColors.textPrimary, size: 22),
        ),
      ),
    );
  }
}
