import 'package:flutter/material.dart';
import '../utils/haptics_helper.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Custom leading graphic (e.g. a brand logo) used instead of [icon].
  final Widget? leading;

  const SecondaryButton({super.key, required this.label, required this.onPressed, this.icon, this.leading});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed == null
          ? null
          : () {
              HapticsHelper.buttonTap();
              onPressed!();
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null)
            ...[leading!, const SizedBox(width: 10)]
          else if (icon != null)
            ...[Icon(icon, size: 20), const SizedBox(width: 10)],
          Text(label),
        ],
      ),
    );
  }
}
