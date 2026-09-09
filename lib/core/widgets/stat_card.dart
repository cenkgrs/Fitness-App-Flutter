import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

class StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final String? delta;

  const StatCard({super.key, required this.icon, required this.value, required this.label, this.delta});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.headingMd),
          Text(label, style: AppTypography.caption),
          if (delta != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(delta!, style: AppTypography.caption.copyWith(color: AppColors.success)),
          ],
        ],
      ),
    );
  }
}
