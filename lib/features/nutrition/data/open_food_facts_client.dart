import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared/models/models.dart';

/// Thin wrapper around Open Food Facts' public search API
/// (https://world.openfoodfacts.org) — free, no API key. Used to back food
/// search with real product data instead of a hardcoded list.
class OpenFoodFactsClient {
  static const _baseUrl = 'https://world.openfoodfacts.org/cgi/search.pl';

  // Open Food Facts asks API consumers to identify themselves so they can
  // reach out about abuse: https://openfoodfacts.github.io/openfoodfacts-server/api/#requests
  static const _userAgent = 'Repwise - Flutter - Version 0.1.0 - cenk.gurses@argevim.com.tr';

  Future<List<Food>> search(String query) async {
    if (query.trim().isEmpty) return const [];

    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'search_terms': query,
      'search_simple': '1',
      'action': 'process',
      'json': '1',
      'page_size': '20',
      'lc': 'tr',
      'fields': 'code,product_name,product_name_tr,brands,nutriments',
    });

    final response = await http.get(uri, headers: {'User-Agent': _userAgent});
    if (response.statusCode != 200) return const [];

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final products = body['products'] as List<dynamic>? ?? [];

    return products
        .map(_mapProduct)
        .whereType<Food>()
        .toList();
  }

  Food? _mapProduct(dynamic raw) {
    final product = raw as Map<String, dynamic>;
    final code = product['code'] as String?;
    final name = (product['product_name_tr'] as String?)?.trim().isNotEmpty == true
        ? product['product_name_tr'] as String
        : product['product_name'] as String?;
    final nutriments = product['nutriments'] as Map<String, dynamic>?;
    final calories = (nutriments?['energy-kcal_100g'] as num?)?.toDouble();

    if (code == null || name == null || name.isEmpty || calories == null) return null;

    return Food(
      id: code,
      name: name,
      brand: (product['brands'] as String?)?.split(',').first.trim(),
      caloriesPer100g: calories,
      proteinPer100g: (nutriments?['proteins_100g'] as num?)?.toDouble() ?? 0,
      carbsPer100g: (nutriments?['carbohydrates_100g'] as num?)?.toDouble() ?? 0,
      fatPer100g: (nutriments?['fat_100g'] as num?)?.toDouble() ?? 0,
    );
  }
}
