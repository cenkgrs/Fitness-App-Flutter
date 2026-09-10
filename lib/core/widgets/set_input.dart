import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/haptics_helper.dart';

/// Large stepper control for Gym Mode — value plus [-]/[+] buttons sized to
/// a minimum 56x56dp touch target for sweaty-hands ergonomics.
class SetInput extends StatelessWidget {
  final String label;
  final String displayValue;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const SetInput({
    super.key,
    required this.label,
    required this.displayValue,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTypography.caption),
        const SizedBox(height: AppSpacing.sm),
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
              _StepButton(icon: Icons.remove, onTap: onDecrement),
              const SizedBox(width: AppSpacing.xs),
              SizedBox(
                width: 90,
                child: Text(
                  displayValue,
                  textAlign: TextAlign.center,
                  style: AppTypography.displayMd,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              _StepButton(icon: Icons.add, onTap: onIncrement),
            ],
          ),
        ),
      ],
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
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () {
          HapticsHelper.buttonTap();
          onTap();
        },
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: AppColors.textPrimary, size: 24),
        ),
      ),
    );
  }
}
