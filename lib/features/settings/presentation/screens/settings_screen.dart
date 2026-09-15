import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/enums.dart';
import '../../../../core/services/notification_service.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final goalAsync = ref.watch(activeGoalProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        children: [
          _SectionHeader(l10n.settingsWorkoutSection),
          _DropdownTile<int>(
            label: l10n.settingsDefaultRestTime,
            value: settings.defaultRestTime.inSeconds,
            items: {
              for (final s in [60, 90, 120, 180]) s: l10n.settingsSecondsFormat(s),
            },
            onChanged: (v) => controller.setDefaultRestTime(Duration(seconds: v)),
          ),
          _SwitchTile(
            label: l10n.settingsAutoStartNextSet,
            value: settings.autoStartNextSet,
            onChanged: controller.setAutoStartNextSet,
          ),
          _DropdownTile<WeightUnit>(
            label: l10n.settingsWeightUnit,
            value: settings.weightUnit,
            items: const {WeightUnit.kg: 'KG', WeightUnit.lbs: 'LBS'},
            onChanged: controller.setWeightUnit,
          ),
          _DropdownTile<DistanceUnit>(
            label: l10n.settingsDistanceUnit,
            value: settings.distanceUnit,
            items: const {DistanceUnit.km: 'KM', DistanceUnit.miles: 'MILES'},
            onChanged: controller.setDistanceUnit,
          ),
          _SwitchTile(label: l10n.settingsSound, value: settings.soundEnabled, onChanged: controller.setSoundEnabled),
          _SwitchTile(
              label: l10n.settingsHaptics, value: settings.hapticsEnabled, onChanged: controller.setHapticsEnabled),
          _SwitchTile(
            label: l10n.settingsCountdownBeep,
            value: settings.countdownBeepEnabled,
            onChanged: controller.setCountdownBeepEnabled,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(l10n.settingsNutritionSection),
          _SwitchTile(
            label: l10n.settingsAutoCalculateTargets,
            value: settings.useAutoNutritionCalculation,
            onChanged: controller.setUseAutoNutritionCalculation,
          ),
          _DropdownTile<String>(
            label: l10n.settingsFoodDatabase,
            value: settings.foodSearchCountry,
            items: {
              '': l10n.settingsFoodDbGlobal,
              'Turkey': l10n.settingsFoodDbTurkey,
              'Germany': l10n.settingsFoodDbGermany,
              'United Kingdom': l10n.settingsFoodDbUK,
              'United States': l10n.settingsFoodDbUS,
              'France': l10n.settingsFoodDbFrance,
            },
            onChanged: controller.setFoodSearchCountry,
          ),
          if (!settings.useAutoNutritionCalculation)
            goalAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (e, st) => const SizedBox.shrink(),
              data: (goal) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin, vertical: AppSpacing.sm),
                child: Text(
                  l10n.settingsManualMacroEditing(
                    '${goal?.dailyCalorieTarget ?? '-'}',
                    '${goal?.dailyProteinTarget ?? '-'}',
                    '${goal?.dailyCarbsTarget ?? '-'}',
                    '${goal?.dailyFatTarget ?? '-'}',
                  ),
                  style: AppTypography.caption,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(l10n.settingsNotificationsSection),
          _SwitchTile(
            label: l10n.settingsEnableNotifications,
            value: settings.notificationsEnabled,
            onChanged: (value) {
              controller.setNotificationsEnabled(value);
              // Covers the case where the user denied the initial app-launch
              // prompt (or is on a fresh install) and only decides they want
              // reminders after finding this toggle.
              if (value) NotificationService.requestPermission();
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(l10n.settingsAppearanceSection),
          _DropdownTile<String>(
            label: l10n.settingsLanguage,
            value: settings.languageCode,
            items: {'system': l10n.settingsLanguageSystem, 'en': 'English', 'tr': 'Türkçe'},
            onChanged: controller.setLanguageCode,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(l10n.settingsAccountSection),
          ListTile(
            title: Text(l10n.settingsSubscription),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profile/settings/subscription'),
          ),
          ListTile(title: Text(l10n.settingsSendFeedback), trailing: const Icon(Icons.chevron_right)),
          ListTile(
            title: Text(l10n.settingsPrivacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profile/settings/privacy-policy'),
          ),
          ListTile(
            title: Text(l10n.settingsDeleteAccount, style: const TextStyle(color: AppColors.error)),
            trailing: const Icon(Icons.chevron_right, color: AppColors.error),
            onTap: () => _confirmDeleteAccount(context, ref),
          ),
        ],
      ),
    );
  }
}

Future<void> _confirmDeleteAccount(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.settingsDeleteAccountConfirmTitle),
      content: Text(l10n.settingsDeleteAccountConfirmMessage),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(l10n.commonCancel)),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(l10n.settingsDeleteAccountConfirmButton, style: const TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  final ok = await ref.read(authControllerProvider.notifier).deleteAccount();
  if (!context.mounted) return;
  if (!ok) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.settingsDeleteAccountFailed)));
  }
  // On success, authStateProvider emits null and the router redirects to
  // /auth on its own — no manual navigation needed here.
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.lg, AppSpacing.screenMargin, AppSpacing.sm),
      child: Text(title.toUpperCase(), style: AppTypography.caption.copyWith(color: AppColors.primary)),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label, style: AppTypography.bodyLg),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
    );
  }
}

class _DropdownTile<T> extends StatelessWidget {
  final String label;
  final T value;
  final Map<T, String> items;
  final ValueChanged<T> onChanged;
  const _DropdownTile({required this.label, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: AppTypography.bodyLg),
      trailing: DropdownButton<T>(
        value: value,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.surface2,
        items: items.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}
