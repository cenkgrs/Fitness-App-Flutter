import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Runs the consent steps ads need before the SDK starts: Google's UMP form
/// (GDPR/EEA — only shown where required, using the message configured in
/// AdMob), then Apple's App Tracking Transparency prompt on iOS. Banners
/// wait on [ready] and stay hidden if consent doesn't allow ad requests.
class AdsConsent {
  AdsConsent._();

  static final ValueNotifier<bool> ready = ValueNotifier(false);

  static Future<void> gatherAndStartAds() async {
    try {
      await _requestUmpConsent();
      if (Platform.isIOS &&
          await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
      if (await ConsentInformation.instance.canRequestAds()) {
        await MobileAds.instance.initialize();
        ready.value = true;
      }
    } catch (_) {
      // Ads are best-effort; a consent or SDK failure just means no banners.
    }
  }

  static Future<void> _requestUmpConsent() {
    final done = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () => ConsentForm.loadAndShowConsentFormIfRequired((_) => done.complete()),
      (_) => done.complete(),
    );
    return done.future;
  }
}
