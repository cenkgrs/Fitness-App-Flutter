import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/enums.dart';
import '../../../goals/presentation/controllers/goal_providers.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final goalAsync = ref.watch(activeGoalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        children: [
          _SectionHeader('Workout Settings'),
          _DropdownTile<int>(
            label: 'Default Rest Time',
            value: settings.defaultRestTime.inSeconds,
            items: const {60: '60s', 90: '90s', 120: '120s', 180: '180s'},
            onChanged: (v) => controller.setDefaultRestTime(Duration(seconds: v)),
          ),
          _SwitchTile(
            label: 'Auto-start Next Set',
            value: settings.autoStartNextSet,
            onChanged: controller.setAutoStartNextSet,
          ),
          _DropdownTile<WeightUnit>(
            label: 'Weight Unit',
            value: settings.weightUnit,
            items: const {WeightUnit.kg: 'KG', WeightUnit.lbs: 'LBS'},
            onChanged: controller.setWeightUnit,
          ),
          _DropdownTile<DistanceUnit>(
            label: 'Distance Unit',
            value: settings.distanceUnit,
            items: const {DistanceUnit.km: 'KM', DistanceUnit.miles: 'MILES'},
            onChanged: controller.setDistanceUnit,
          ),
          _SwitchTile(label: 'Sound', value: settings.soundEnabled, onChanged: controller.setSoundEnabled),
          _SwitchTile(
              label: 'Haptics', value: settings.hapticsEnabled, onChanged: controller.setHapticsEnabled),
          _SwitchTile(
            label: 'Countdown Beep (3-2-1)',
            value: settings.countdownBeepEnabled,
            onChanged: controller.setCountdownBeepEnabled,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader('Nutrition Settings'),
          _SwitchTile(
            label: 'Auto-calculate targets (TDEE)',
            value: settings.useAutoNutritionCalculation,
            onChanged: controller.setUseAutoNutritionCalculation,
          ),
          _DropdownTile<String>(
            label: 'Yemek Veritabanı',
            value: settings.foodSearchCountry,
            items: const {
              '': 'Global (Tümü)',
              'Turkey': 'Türkiye',
              'Germany': 'Almanya',
              'United Kingdom': 'Birleşik Krallık',
              'United States': 'Amerika Birleşik Devletleri',
              'France': 'Fransa',
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
                  'Manual macro editing: Calories ${goal?.dailyCalorieTarget ?? '-'} · '
                  'Protein ${goal?.dailyProteinTarget ?? '-'}g · '
                  'Carbs ${goal?.dailyCarbsTarget ?? '-'}g · '
                  'Fat ${goal?.dailyFatTarget ?? '-'}g',
                  style: AppTypography.caption,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader('Notifications'),
          _SwitchTile(
            label: 'Enable Notifications',
            value: settings.notificationsEnabled,
            onChanged: controller.setNotificationsEnabled,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader('Appearance & Language'),
          _DropdownTile<String>(
            label: 'Language',
            value: settings.languageCode,
            items: const {'tr': 'Türkçe', 'en': 'English'},
            onChanged: controller.setLanguageCode,
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader('Account & Support'),
          const ListTile(title: Text('Subscription'), trailing: Icon(Icons.chevron_right)),
          const ListTile(title: Text('Send Feedback'), trailing: Icon(Icons.chevron_right)),
          const ListTile(title: Text('Privacy Policy'), trailing: Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
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
