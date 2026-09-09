import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';

class SettingsRepository {
  final LocalStorageService _storage;
  static const _key = 'app_settings';

  SettingsRepository(this._storage);

  AppSettings getSettings() {
    final raw = _storage.settingsBox.get(_key);
    if (raw == null) return const AppSettings();
    return AppSettings.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _storage.settingsBox.put(_key, settings.toJson());
  }
}
