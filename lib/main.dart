import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/controllers/settings_controller.dart';
import 'l10n/app_localizations.dart';
import 'shared/services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  // Guarded so the app still runs (against local/mock repositories) before
  // Supabase credentials are provided via --dart-define.
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.anonKey,
    );
  }
  runApp(const ProviderScope(child: RepwiseApp()));
}

class RepwiseApp extends ConsumerWidget {
  const RepwiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final languageCode = ref.watch(settingsControllerProvider).languageCode;

    return MaterialApp.router(
      title: 'Repwise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // English first: the fallback when the device locale isn't Turkish.
      supportedLocales: AppLocalizations.supportedLocales,
      // 'system' (the default) omits `locale:` entirely so Flutter's own
      // locale resolution matches the device locale against
      // supportedLocales — an explicit 'en'/'tr' forces that choice
      // regardless of device locale.
      locale: languageCode == 'system' ? null : Locale(languageCode),
    );
  }
}
