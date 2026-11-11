import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/utils/text_case.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Rest countdown shown between sets. Skipping lives in the screen's bottom
/// action, so this card only adjusts the time and says what comes next.
class RestTimer extends StatelessWidget {
  final Duration remaining;
  final Duration total;
  final VoidCallback onAdd30s;
  final VoidCallback onSubtract15s;
  final String? nextLabel;

  const RestTimer({
    super.key,
    required this.remaining,
    required this.total,
    required this.onAdd30s,
    required this.onSubtract15s,
    this.nextLabel,
  });

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString();
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = total.inMilliseconds == 0
        ? 0.0
        : (remaining.inMilliseconds / total.inMilliseconds).clamp(0.0, 1.0);
    final isEnding = remaining.inSeconds <= 3 && remaining.inSeconds > 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: isEnding ? AppColors.primary : AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            upperForLocale(l10n.restTimerLabel, Localizations.localeOf(context).languageCode),
            style: AppTypography.overline,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _format(remaining),
                style: AppTypography.displayLg.copyWith(
                  color: isEnding ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              _AdjustButton(label: l10n.restTimerSubtract, onTap: onSubtract15s),
              const SizedBox(width: AppSpacing.sm),
              _AdjustButton(label: l10n.restTimerAdd, onTap: onAdd30s),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: progress),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: AppColors.surface2,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          if (nextLabel != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.activeWorkoutRestNext(nextLabel!), style: AppTypography.bodyMd),
          ],
        ],
      ),
    );
  }
}

class _AdjustButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _AdjustButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface2,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.full),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Text(label, style: AppTypography.caption.copyWith(color: AppColors.textPrimary)),
        ),
      ),
    );
  }
}
