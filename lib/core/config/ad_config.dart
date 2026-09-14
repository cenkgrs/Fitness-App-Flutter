import 'dart:io';

/// AdMob wiring. Uses Google's public TEST ad unit IDs by default so the
/// integration can be built/run/tested before a real AdMob account exists —
/// swap [bannerAdUnitId]/[interstitialAdUnitId] (and the AndroidManifest.xml
/// `com.google.android.gms.ads.APPLICATION_ID` meta-data) for the real ones
/// once the account is created. Real ad unit IDs should come from
/// --dart-define, same as the Supabase config, never hardcoded.
class AdConfig {
  static const _envBannerId = String.fromEnvironment('ADMOB_BANNER_UNIT_ID');
  static const _envInterstitialId = String.fromEnvironment('ADMOB_INTERSTITIAL_UNIT_ID');

  static bool get isConfigured => _envBannerId.isNotEmpty;

  static String get bannerAdUnitId {
    if (_envBannerId.isNotEmpty) return _envBannerId;
    // Google's shared test banner unit ID — always fills, never real revenue.
    return Platform.isIOS
        ? 'ca-app-pub-3940256099942544/2934735716'
        : 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    if (_envInterstitialId.isNotEmpty) return _envInterstitialId;
    return Platform.isIOS
        ? 'ca-app-pub-3940256099942544/4411468910'
        : 'ca-app-pub-3940256099942544/1033173712';
  }
}
