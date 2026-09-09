import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/services/local_storage_service.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});
