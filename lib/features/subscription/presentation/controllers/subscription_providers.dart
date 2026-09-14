import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../../core/config/revenuecat_config.dart';

/// Whether the current user has the premium entitlement (ad-free + AI
/// features). Always false when RevenueCat isn't configured yet — see
/// RevenueCatConfig — so the app runs fully in "free" mode until real
/// API keys are supplied.
final subscriptionStatusProvider = FutureProvider<bool>((ref) async {
  if (!RevenueCatConfig.isConfigured) return false;
  try {
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.containsKey(RevenueCatConfig.premiumEntitlementId);
  } catch (_) {
    return false;
  }
});

/// Available subscription packages to show on the paywall. Empty when
/// RevenueCat isn't configured, or if the dashboard has no offerings yet.
final subscriptionOfferingsProvider = FutureProvider<List<Package>>((ref) async {
  if (!RevenueCatConfig.isConfigured) return const [];
  try {
    final offerings = await Purchases.getOfferings();
    return offerings.current?.availablePackages ?? const [];
  } catch (_) {
    return const [];
  }
});
