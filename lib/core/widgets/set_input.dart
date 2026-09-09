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
      children: [
        Text(label, style: AppTypography.caption),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StepButton(icon: Icons.remove, onTap: onDecrement),
            SizedBox(
              width: 100,
              child: Text(
                displayValue,
                textAlign: TextAlign.center,
                style: AppTypography.displayMd,
              ),
            ),
            _StepButton(icon: Icons.add, onTap: onIncrement),
          ],
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
