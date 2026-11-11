import 'dart:ui' as ui;

import '../../l10n/app_localizations.dart';

/// Resolves an [AppSettings.languageCode] value ('system' or a language
/// code) to one the app actually ships — the same choice MaterialApp makes,
/// falling back to English. Used where a `BuildContext` (and therefore
/// `Localizations.localeOf`) isn't available, e.g. server request payloads
/// and scheduled notifications.
String resolveLanguageCode(String settingLanguageCode) {
  final requested =
      settingLanguageCode == 'system' ? ui.PlatformDispatcher.instance.locale.languageCode : settingLanguageCode;
  final supported = AppLocalizations.supportedLocales.map((l) => l.languageCode);
  return supported.contains(requested) ? requested : 'en';
}
