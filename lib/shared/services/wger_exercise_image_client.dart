import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/local_storage_service.dart';

/// Looks up a real exercise photo from wger.de's public, no-key-required
/// exercise database (https://wger.de/api/v2) — matched by free-text name,
/// since AI-generated workout plans produce arbitrary exercise names
/// ("Barbell Bench Press") that don't line up 1:1 with wger's catalog.
///
/// wger has no relevance-ranked search endpoint, so results from its
/// full-text `search` param are re-ranked client-side by word overlap
/// against the query; a weak/no match returns null rather than guessing.
class WgerExerciseImageClient {
  static const _baseUrl = 'https://wger.de/api/v2';
  static const _english = 2; // wger's language id for English

  final http.Client _http;
  final LocalStorageService _storage;

  WgerExerciseImageClient({http.Client? httpClient, LocalStorageService? storage})
      : _http = httpClient ?? http.Client(),
        _storage = storage ?? LocalStorageService();

  static final _stopWords = {'the', 'a', 'an', 'with', 'and', 'to', 'of'};

  Set<String> _wordsOf(String s) => s
      .toLowerCase()
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.isNotEmpty && !_stopWords.contains(w))
      .toSet();

  /// Cached indefinitely per exercise name — wger's catalog and this app's
  /// AI-generated exercise names are both effectively static per name, and
  /// an empty-string cache entry means "looked it up, found nothing" (so we
  /// don't keep re-querying misses every time a card rebuilds).
  Future<String?> findImageUrl(String exerciseName) async {
    final key = exerciseName.trim().toLowerCase();
    if (key.isEmpty) return null;

    final cached = _storage.exerciseImagesBox.get(key) as String?;
    if (cached != null) return cached.isEmpty ? null : cached;

    final url = await _lookup(exerciseName);
    await _storage.exerciseImagesBox.put(key, url ?? '');
    return url;
  }

  Future<String?> _lookup(String exerciseName) async {
    try {
      final queryWords = _wordsOf(exerciseName);
      if (queryWords.isEmpty) return null;

      final searchUri = Uri.parse('$_baseUrl/exercise-translation/').replace(queryParameters: {
        'search': exerciseName,
        'language': '$_english',
        'limit': '10',
        'format': 'json',
      });
      final searchRes = await _http.get(searchUri).timeout(const Duration(seconds: 6));
      if (searchRes.statusCode != 200) return null;
      final results = (jsonDecode(searchRes.body) as Map<String, dynamic>)['results'] as List?;
      if (results == null || results.isEmpty) return null;

      int? bestExerciseId;
      double bestScore = 0;
      for (final r in results) {
        final candidate = r as Map<String, dynamic>;
        final name = candidate['name'] as String? ?? '';
        final candidateWords = _wordsOf(name);
        if (candidateWords.isEmpty) continue;
        final overlap = queryWords.intersection(candidateWords).length;
        final score = overlap / queryWords.length;
        if (score > bestScore) {
          bestScore = score;
          bestExerciseId = candidate['exercise'] as int?;
        }
      }
      // Require at least half the query's meaningful words to match —
      // otherwise this is more likely to attach a misleading photo than a
      // useful one.
      if (bestExerciseId == null || bestScore < 0.5) return null;

      final imagesUri = Uri.parse('$_baseUrl/exerciseimage/').replace(queryParameters: {
        'exercise': '$bestExerciseId',
        'format': 'json',
      });
      final imagesRes = await _http.get(imagesUri).timeout(const Duration(seconds: 6));
      if (imagesRes.statusCode != 200) return null;
      final images = (jsonDecode(imagesRes.body) as Map<String, dynamic>)['results'] as List?;
      if (images == null || images.isEmpty) return null;

      final main = images.cast<Map<String, dynamic>>().firstWhere(
            (i) => i['is_main'] == true,
            orElse: () => images.first as Map<String, dynamic>,
          );
      final thumbnails = main['thumbnails'] as Map<String, dynamic>?;
      return (thumbnails?['medium'] as String?) ?? (main['image'] as String?);
    } catch (_) {
      return null;
    }
  }
}
