import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../data/user_profile_repository.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepository(ref.watch(localStorageServiceProvider));
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  final repo = ref.watch(userProfileRepositoryProvider);
  return repo.getProfile(user?.id ?? 'local');
});
