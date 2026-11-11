import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../controllers/profile_providers.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../shared/models/models.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(userProfileProvider);
    final user = ref.watch(authStateProvider).valueOrNull;
    final formatter = ref.watch(weightFormatterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileScreenTitle)),
      body: profileAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(children: [LoadingShimmer(height: 120), SizedBox(height: 16), LoadingShimmer(height: 200)]),
        ),
        error: (e, st) => Center(child: Text(l10n.profileLoadError(e.toString()))),
        data: (profile) {
          if (profile == null) {
            return EmptyState(
              icon: AppIcons.user,
              title: l10n.profileEmptyTitle,
              message: l10n.profileEmptyMessage,
            );
          }
          final name = profile.name.isEmpty ? (user?.displayName ?? l10n.homeDefaultAthleteName) : profile.name;
          final level = switch (profile.fitnessLevel) {
            FitnessLevel.beginner => l10n.fitnessBeginnerLabel,
            FitnessLevel.intermediate => l10n.fitnessIntermediateLabel,
            FitnessLevel.advanced => l10n.fitnessAdvancedLabel,
          };
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            children: [
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.surface2, shape: BoxShape.circle),
                    child: Text(
                      name.trim().isEmpty ? '' : name.trim().characters.first.toUpperCase(),
                      style: AppTypography.headingLg,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTypography.headingMd),
                        if (user?.email != null) Text(user!.email!, style: AppTypography.bodyMd),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Row(
                  children: [
                    _BioChip(label: l10n.bioAge, value: '${profile.age}'),
                    _BioChip(label: l10n.bioHeight, value: '${profile.heightCm.round()} cm'),
                    _BioChip(label: l10n.bioWeight, value: formatter.format(profile.weightKg)),
                    _BioChip(label: l10n.bioLevel, value: level),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _NavRow(icon: AppIcons.flag, label: l10n.profileGoalsTile, onTap: () => context.push('/goals')),
                    const Divider(indent: 56),
                    _NavRow(
                      icon: AppIcons.trophy,
                      label: l10n.achievementsTitle,
                      onTap: () => context.push('/achievements'),
                    ),
                    const Divider(indent: 56),
                    _NavRow(
                      icon: AppIcons.gear,
                      label: l10n.settingsScreenTitle,
                      onTap: () => context.push('/profile/settings'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                padding: EdgeInsets.zero,
                child: _NavRow(
                  icon: AppIcons.signOut,
                  label: l10n.profileSignOut,
                  color: AppColors.error,
                  onTap: () => ref.read(authControllerProvider.notifier).signOut(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _NavRow({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color ?? AppColors.textSecondary),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: Text(label, style: AppTypography.bodyLg.copyWith(color: color))),
            if (color == null) const Icon(AppIcons.caretRight, size: 18, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _BioChip extends StatelessWidget {
  final String label;
  final String value;
  const _BioChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTypography.headingSm, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}
