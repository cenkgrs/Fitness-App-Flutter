import 'package:equatable/equatable.dart';

/// A food item, either from the (mock) food database or user-created via
/// Quick Add. Macro values are per [servingSizeG] grams.
class Food extends Equatable {
  final String id;
  final String name;
  final String? brand;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;

  const Food({
    required this.id,
    required this.name,
    this.brand,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'caloriesPer100g': caloriesPer100g,
        'proteinPer100g': proteinPer100g,
        'carbsPer100g': carbsPer100g,
        'fatPer100g': fatPer100g,
      };

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json['id'] as String,
        name: json['name'] as String,
        brand: json['brand'] as String?,
        caloriesPer100g: (json['caloriesPer100g'] as num).toDouble(),
        proteinPer100g: (json['proteinPer100g'] as num).toDouble(),
        carbsPer100g: (json['carbsPer100g'] as num).toDouble(),
        fatPer100g: (json['fatPer100g'] as num).toDouble(),
      );

  @override
  List<Object?> get props =>
      [id, name, brand, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g];
}
