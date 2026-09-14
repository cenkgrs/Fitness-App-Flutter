/// RevenueCat wiring. Unlike AdMob there's no public "test" API key — the
/// SDK simply isn't configured until a real key is supplied via
/// --dart-define, at which point [isConfigured] flips true and
/// subscriptionStatusProvider starts reflecting real entitlement state.
/// Until then every user is treated as free (no ads/AI gate is enforced).
class RevenueCatConfig {
  static const apiKeyAndroid = String.fromEnvironment('REVENUECAT_API_KEY_ANDROID');
  static const apiKeyIOS = String.fromEnvironment('REVENUECAT_API_KEY_IOS');

  /// The RevenueCat entitlement identifier that unlocks premium (ad-free +
  /// AI features). Must match the entitlement created in the RevenueCat
  /// dashboard once the project exists there.
  static const premiumEntitlementId = 'premium';

  static bool get isConfigured => apiKeyAndroid.isNotEmpty || apiKeyIOS.isNotEmpty;
}
