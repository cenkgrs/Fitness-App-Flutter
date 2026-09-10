import 'dart:ui' as ui;

/// Resolves an [AppSettings.languageCode] value ('system' | 'en' | 'tr') to
/// a concrete 'en'/'tr' code — used where a `BuildContext` (and therefore
/// `Localizations.localeOf`) isn't available, e.g. server request payloads
/// built from a plain Dart class.
String resolveLanguageCode(String settingLanguageCode) {
  if (settingLanguageCode == 'en' || settingLanguageCode == 'tr') return settingLanguageCode;
  return ui.PlatformDispatcher.instance.locale.languageCode == 'tr' ? 'tr' : 'en';
}
