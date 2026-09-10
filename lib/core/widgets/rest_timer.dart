import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class RestTimer extends StatelessWidget {
  final Duration remaining;
  final Duration total;
  final VoidCallback onAdd15s;
  final VoidCallback onSubtract15s;
  final VoidCallback onSkip;

  const RestTimer({
    super.key,
    required this.remaining,
    required this.total,
    required this.onAdd15s,
    required this.onSubtract15s,
    required this.onSkip,
  });

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = total.inMilliseconds == 0
        ? 0.0
        : 1 - (remaining.inMilliseconds / total.inMilliseconds).clamp(0.0, 1.0);
    final isWarning = remaining.inSeconds <= 3 && remaining.inSeconds > 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: isWarning ? AppColors.warning : AppColors.surfaceBorder),
      ),
      child: Column(
        children: [
          Text(l10n.restTimerLabel, style: AppTypography.caption),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _format(remaining),
            style: AppTypography.displayMd.copyWith(
              color: isWarning ? AppColors.warning : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.surface2,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: onSubtract15s, child: Text(l10n.restTimerSubtract)),
              TextButton(onPressed: onSkip, child: Text(l10n.restTimerSkip)),
              TextButton(onPressed: onAdd15s, child: Text(l10n.restTimerAdd)),
            ],
          ),
        ],
      ),
    );
  }
}
