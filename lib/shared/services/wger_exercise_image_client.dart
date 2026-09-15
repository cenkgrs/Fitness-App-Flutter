import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/local_storage_service.dart';

/// Looks up a real exercise photo from wger.de's free, no-key exercise
/// database (https://wger.de/api/v2) — matched by free-text name, since
/// AI-generated workout plans produce arbitrary exercise names ("Barbell
/// Bench Press") that don't line up 1:1 with wger's catalog.
///
/// wger's `exercise-translation` endpoint has no working relevance search
/// (its `search` query param is silently ignored server-side — verified
/// empirically, not documented), so this fetches the full English exercise
/// name catalog once (~3300 entries, a few paginated requests), caches it
/// locally, and does the fuzzy word-overlap matching itself.
class WgerExerciseImageClient {
  static const _baseUrl = 'https://wger.de/api/v2';
  static const _english = 2; // wger's language id for English
  static const _catalogCacheKey = '_catalog_v1';
  // Bump this when the matching/probing logic changes, so previously
  // cached "no image found" misses (from a weaker version of this logic)
  // don't shadow a match the improved version would now find.
  static const _lookupCacheVersion = 'v2';

  final http.Client _http;
  final LocalStorageService _storage;

  WgerExerciseImageClient({http.Client? httpClient, LocalStorageService? storage})
      : _http = httpClient ?? http.Client(),
        _storage = storage ?? LocalStorageService();

  static List<Map<String, dynamic>>? _catalogMemoryCache;

  static final _stopWords = {'the', 'a', 'an', 'with', 'and', 'to', 'of'};

  Set<String> _wordsOf(String s) => s
      .toLowerCase()
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.isNotEmpty && !_stopWords.contains(w))
      .toSet();

  /// Cached indefinitely per exercise name — an empty-string cache entry
  /// means "looked it up, found nothing" (so we don't keep re-querying
  /// misses every time a card rebuilds).
  Future<String?> findImageUrl(String exerciseName) async {
    final trimmed = exerciseName.trim().toLowerCase();
    if (trimmed.isEmpty) return null;
    final key = '$_lookupCacheVersion:$trimmed';

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

      final catalog = await _catalog();
      if (catalog.isEmpty) return null;

      // Require at least half the query's meaningful words to match —
      // otherwise this is more likely to attach a misleading photo than a
      // useful one. Many exercise name variants tie on word-overlap score
      // (e.g. "Triceps Pushdown", "Tricep Pushdown on Cable", "Triceps
      // Pushdown Isometric" for a "Triceps Cable Pushdown" query) and not
      // every wger entry actually has a photo — so this ranks ALL
      // qualifying candidates and tries them best-first instead of
      // committing to a single top match that might turn out to be a dud.
      final scored = <MapEntry<double, int>>[];
      for (final entry in catalog) {
        final candidateWords = entry['words'] as Set<String>;
        if (candidateWords.isEmpty) continue;
        final overlap = queryWords.intersection(candidateWords).length;
        final score = overlap / queryWords.length;
        if (score >= 0.5) {
          scored.add(MapEntry(score, entry['exercise'] as int));
        }
      }
      if (scored.isEmpty) return null;
      scored.sort((a, b) => b.key.compareTo(a.key));

      // Cap how many candidates we'll probe — bounds worst-case network
      // calls for an exercise name with many tied, imageless matches.
      // Ties are common (multiple close-enough name variants) and most
      // wger entries have zero photos, so this needs real headroom — 5 was
      // too tight and missed valid photographed matches sitting just past
      // the cutoff.
      for (final candidate in scored.take(20)) {
        final imagesUri = Uri.parse('$_baseUrl/exerciseimage/').replace(queryParameters: {
          'exercise': '${candidate.value}',
          'format': 'json',
        });
        final imagesRes = await _http.get(imagesUri).timeout(const Duration(seconds: 6));
        if (imagesRes.statusCode != 200) continue;
        final images = (jsonDecode(imagesRes.body) as Map<String, dynamic>)['results'] as List?;
        if (images == null || images.isEmpty) continue;

        final main = images.cast<Map<String, dynamic>>().firstWhere(
              (i) => i['is_main'] == true,
              orElse: () => images.first as Map<String, dynamic>,
            );
        final thumbnails = main['thumbnails'] as Map<String, dynamic>?;
        final url = (thumbnails?['medium'] as String?) ?? (main['image'] as String?);
        if (url != null) return url;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// The full {name, exercise id, pre-split words} catalog, loaded once per
  /// app run (in-memory) and persisted to Hive so subsequent app launches
  /// don't re-download ~3300 entries across 7 paginated requests.
  Future<List<Map<String, dynamic>>> _catalog() async {
    if (_catalogMemoryCache != null) return _catalogMemoryCache!;

    final cachedJson = _storage.exerciseImagesBox.get(_catalogCacheKey) as String?;
    if (cachedJson != null) {
      final decoded = (jsonDecode(cachedJson) as List).cast<Map<String, dynamic>>();
      _catalogMemoryCache = decoded
          .map((e) => {'exercise': e['exercise'] as int, 'words': _wordsOf(e['name'] as String)})
          .toList();
      return _catalogMemoryCache!;
    }

    final fetched = await _fetchFullCatalog();
    if (fetched.isEmpty) return [];

    await _storage.exerciseImagesBox.put(_catalogCacheKey, jsonEncode(fetched));
    _catalogMemoryCache =
        fetched.map((e) => {'exercise': e['exercise'] as int, 'words': _wordsOf(e['name'] as String)}).toList();
    return _catalogMemoryCache!;
  }

  Future<List<Map<String, dynamic>>> _fetchFullCatalog() async {
    final entries = <Map<String, dynamic>>[];
    var uri = Uri.parse('$_baseUrl/exercise-translation/').replace(queryParameters: {
      'language': '$_english',
      'limit': '500',
      'format': 'json',
    });

    try {
      // A handful of sequential paginated requests — acceptable for a
      // one-time catalog sync, bounded so a slow/broken connection can't
      // hang the caller indefinitely.
      for (var page = 0; page < 10 && uri.toString().isNotEmpty; page++) {
        final res = await _http.get(uri).timeout(const Duration(seconds: 10));
        if (res.statusCode != 200) break;
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final results = (body['results'] as List?)?.cast<Map<String, dynamic>>() ?? [];
        for (final r in results) {
          final name = r['name'] as String?;
          final exercise = r['exercise'] as int?;
          if (name != null && name.isNotEmpty && exercise != null) {
            entries.add({'name': name, 'exercise': exercise});
          }
        }
        final next = body['next'] as String?;
        if (next == null) break;
        uri = Uri.parse(next);
      }
    } catch (_) {
      // Return whatever was fetched so far rather than nothing.
    }
    return entries;
  }
}
