import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/subscription_providers.dart';

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
      appBar: AppBar(title: Text(l10n.paywallTitle)),
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
                  Text(l10n.paywallSubtitle, style: AppTypography.bodyLg),
                  const SizedBox(height: AppSpacing.xl),
                  _FeatureRow(icon: Icons.block, label: l10n.paywallFeatureNoAds),
                  _FeatureRow(icon: Icons.fitness_center, label: l10n.paywallFeatureAiWorkouts),
                  _FeatureRow(icon: Icons.restaurant, label: l10n.paywallFeatureAiMeals),
                  const SizedBox(height: AppSpacing.xl),
                  Expanded(
                    child: offeringsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                      error: (e, st) => Center(child: Text(l10n.paywallUnavailable)),
                      data: (packages) {
                        if (packages.isEmpty) {
                          return Center(child: Text(l10n.paywallUnavailable, textAlign: TextAlign.center));
                        }
                        return ListView.separated(
                          itemCount: packages.length,
                          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                          itemBuilder: (context, i) {
                            final package = packages[i];
                            return PrimaryButton(
                              label: '${l10n.paywallSubscribeButton} — ${package.storeProduct.priceString}',
                              isLoading: _busy,
                              onPressed: () => _purchase(package),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: _busy ? null : _restore,
                      child: Text(l10n.paywallRestoreButton),
                    ),
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
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: AppTypography.bodyMd),
        ],
      ),
    );
  }
}
