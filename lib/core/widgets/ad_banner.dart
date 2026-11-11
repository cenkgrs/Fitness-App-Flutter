import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/ad_config.dart';
import '../services/ads_consent.dart';

/// A standard-size AdMob banner. Renders nothing until the ad actually
/// loads, so it never reserves blank space or shifts layout while loading
/// or if the ad fails (offline, no fill, etc).
class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    if (AdsConsent.ready.value) {
      _load();
    } else {
      AdsConsent.ready.addListener(_onConsentReady);
    }
  }

  void _onConsentReady() {
    if (!AdsConsent.ready.value) return;
    AdsConsent.ready.removeListener(_onConsentReady);
    if (mounted) _load();
  }

  void _load() {
    final ad = BannerAd(
      size: AdSize.banner,
      adUnitId: AdConfig.bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _bannerAd = ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    ad.load();
  }

  @override
  void dispose() {
    AdsConsent.ready.removeListener(_onConsentReady);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;
    if (ad == null) return const SizedBox.shrink();
    return SizedBox(
      width: ad.size.width.toDouble(),
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
