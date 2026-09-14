import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/revenuecat_config.dart';
import 'subscription_providers.dart';

/// Returns true if the caller may proceed with a premium (AI) feature.
///
/// While RevenueCat isn't configured yet ([RevenueCatConfig.isConfigured]
/// is false — no real API key set via --dart-define), this always allows
/// the feature through, matching the Edge Function's own
/// REQUIRE_SUBSCRIPTION=false default: there's no real paywall to send
/// anyone to yet, so gating would just break the feature for everyone.
/// Once a real RevenueCat project exists, non-premium users are routed to
/// the paywall instead of proceeding.
Future<bool> requirePremium(BuildContext context, WidgetRef ref) async {
  if (!RevenueCatConfig.isConfigured) return true;
  final isPremium = await ref.read(subscriptionStatusProvider.future);
  if (isPremium) return true;
  if (context.mounted) context.push('/profile/settings/subscription');
  return false;
}
