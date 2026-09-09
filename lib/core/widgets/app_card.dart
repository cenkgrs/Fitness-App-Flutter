import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? accentColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorder),
        boxShadow: const [
          BoxShadow(color: Color(0x66000000), blurRadius: 20, offset: Offset(0, 4)),
        ],
      ),
      child: accentColor == null
          ? Padding(padding: padding, child: child)
          : IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadius.lg)),
                    ),
                  ),
                  Expanded(child: Padding(padding: padding, child: child)),
                ],
              ),
            ),
    );

    if (onTap == null) return content;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: content,
    );
  }
}
