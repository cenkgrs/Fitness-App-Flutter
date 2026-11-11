/// Uppercases [text] for small caps-style labels. Dart's toUpperCase isn't
/// locale-aware, so Turkish dotted i would come out as a plain I.
String upperForLocale(String text, String languageCode) =>
    (languageCode == 'tr' ? text.replaceAll('i', 'İ') : text).toUpperCase();
