import '../../../shared/models/models.dart';
import '../../../shared/services/local_storage_service.dart';
import '../domain/settings_repository.dart';

class LocalSettingsRepository implements SettingsRepository {
  final LocalStorageService _storage;
  static const _key = 'app_settings';

  LocalSettingsRepository(this._storage);

  @override
  AppSettings getSettings() {
    final raw = _storage.settingsBox.get(_key);
    if (raw == null) return const AppSettings();
    return AppSettings.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _storage.settingsBox.put(_key, settings.toJson());
  }
}
