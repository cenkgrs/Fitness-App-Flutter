import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/subscription_providers.dart';
import '../../../../core/theme/app_icons.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  bool _busy = false;

  Future<void> _purchase(Package package) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _busy = true);
    try {
      await Purchases.purchasePackage(package);
      ref.invalidate(subscriptionStatusProvider);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.paywallPurchaseFailed)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _busy = true);
    try {
      final info = await Purchases.restorePurchases();
      ref.invalidate(subscriptionStatusProvider);
      if (!mounted) return;
      final restored = info.entitlements.active.isNotEmpty;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(restored ? l10n.paywallRestoreSuccess : l10n.paywallRestoreNone)),
      );
    } catch (_) {
      // Silently ignore — restore failing (e.g. offline) isn't worth a
      // scary error for what's essentially a best-effort action.
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusAsync = ref.watch(subscriptionStatusProvider);
    final offeringsAsync = ref.watch(subscriptionOfferingsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: statusAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (e, st) => Center(child: Text(l10n.genericError(e.toString()))),
            data: (isPremium) {
              if (isPremium) {
                return Center(
                  child: Text(l10n.paywallAlreadySubscribed, style: AppTypography.headingSm, textAlign: TextAlign.center),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                      children: [
                        TextSpan(text: 'THRIVE', style: TextStyle(color: AppColors.textPrimary)),
                        TextSpan(text: '+ ', style: TextStyle(color: AppColors.primary)),
                        TextSpan(text: 'Premium', style: TextStyle(color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.paywallSubtitle, style: AppTypography.bodyLg.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: AppSpacing.xl),
                  _FeatureRow(icon: AppIcons.prohibit, label: l10n.paywallFeatureNoAds),
                  _FeatureRow(icon: AppIcons.barbell, label: l10n.paywallFeatureAiWorkouts),
                  _FeatureRow(icon: AppIcons.forkKnife, label: l10n.paywallFeatureAiMeals),
                  _FeatureRow(icon: AppIcons.chatCircleText, label: l10n.aiChatTitle),
                  const Spacer(),
                  offeringsAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                    error: (e, st) => Text(l10n.paywallUnavailable, style: AppTypography.bodyMd),
                    data: (packages) {
                      if (packages.isEmpty) {
                        return Text(l10n.paywallUnavailable, style: AppTypography.bodyMd);
                      }
                      return Column(
                        children: [
                          for (final package in packages)
                            Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                              child: PrimaryButton(
                                label: '${l10n.paywallSubscribeButton} · ${package.storeProduct.priceString}',
                                isLoading: _busy,
                                onPressed: () => _purchase(package),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.paywallAutoRenewNote, style: AppTypography.caption, textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _busy ? null : _restore,
                        child: Text(l10n.paywallRestoreButton, style: AppTypography.caption),
                      ),
                      TextButton(
                        onPressed: () => launchUrl(
                          Uri.parse('https://www.apple.com/legal/internet-services/itunes/dev/stdeula/'),
                          mode: LaunchMode.inAppBrowserView,
                        ),
                        child: Text(l10n.paywallTerms, style: AppTypography.caption),
                      ),
                      TextButton(
                        onPressed: () => context.push('/profile/settings/privacy-policy'),
                        child: Text(l10n.settingsPrivacyPolicy, style: AppTypography.caption),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: AppTypography.bodyLg)),
        ],
      ),
    );
  }
}
