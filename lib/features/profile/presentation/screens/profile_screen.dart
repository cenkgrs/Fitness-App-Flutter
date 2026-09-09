import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final user = ref.watch(authStateProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: profileAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.screenMargin),
          child: Column(children: [LoadingShimmer(height: 120), SizedBox(height: 16), LoadingShimmer(height: 200)]),
        ),
        error: (e, st) => Center(child: Text('Couldn\'t load profile: $e')),
        data: (profile) {
          if (profile == null) {
            return const EmptyState(
              icon: Icons.person_outline,
              title: 'No profile yet',
              message: 'Complete onboarding to build your profile.',
            );
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenMargin),
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 32, backgroundColor: AppColors.surface2, child: Icon(Icons.person, size: 32)),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name.isEmpty ? (user?.displayName ?? 'Athlete') : profile.name,
                            style: AppTypography.headingMd),
                        Text(user?.email ?? 'REPWISE', style: AppTypography.caption),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                child: Row(
                  children: [
                    _BioChip(label: 'Age', value: '${profile.age}'),
                    _BioChip(label: 'Height', value: '${profile.heightCm.round()} cm'),
                    _BioChip(label: 'Weight', value: '${profile.weightKg.toStringAsFixed(1)} kg'),
                    _BioChip(label: 'Level', value: profile.fitnessLevel.name),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ListTile(
                tileColor: AppColors.surface1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/profile/settings'),
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                tileColor: AppColors.surface1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Goals'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/goals'),
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                tileColor: AppColors.surface1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text('Sign Out', style: TextStyle(color: AppColors.error)),
                onTap: () => ref.read(authControllerProvider.notifier).signOut(),
              ),
            ],
          );
        },
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
          Text(value, style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600)),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}
