import '../../../shared/models/models.dart';

/// Abstraction over [AppSettings] persistence — swap the local/Supabase
/// implementation without touching call sites (SettingsController).
abstract class SettingsRepository {
  /// Synchronous read: [SettingsController.build] needs the initial value
  /// without an async gap.
  AppSettings getSettings();

  Future<void> saveSettings(AppSettings settings);
}
