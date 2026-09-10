import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/models/models.dart';
import '../../data/local_user_profile_repository.dart';
import '../../data/supabase_user_profile_repository.dart';
import '../../domain/user_profile_repository.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final local = LocalUserProfileRepository(ref.watch(localStorageServiceProvider));
  if (SupabaseConfig.isConfigured) {
    return SupabaseUserProfileRepository(Supabase.instance.client, local);
  }
  return local;
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(authStateProvider).valueOrNull;
  final repo = ref.watch(userProfileRepositoryProvider);
  return repo.getProfile(user?.id ?? 'local');
});
