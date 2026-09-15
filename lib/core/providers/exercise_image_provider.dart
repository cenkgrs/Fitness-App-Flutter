import 'package:flutter/widgets.dart' show WidgetsBinding, WidgetsFlutterBinding;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/services/wger_exercise_image_client.dart';

final _wgerClientProvider = Provider<WgerExerciseImageClient>((ref) => WgerExerciseImageClient());

/// Resolves a real exercise photo URL (or null) for [exerciseName], via
/// wger.de — see WgerExerciseImageClient for the matching/caching logic.
/// No-ops under `flutter test` (see notification_scheduler.dart for the
/// same reasoning) so widget tests never make real network calls.
final exerciseImageProvider = FutureProvider.family<String?, String>((ref, exerciseName) {
  if (WidgetsBinding.instance is! WidgetsFlutterBinding) return null;
  return ref.watch(_wgerClientProvider).findImageUrl(exerciseName);
});
