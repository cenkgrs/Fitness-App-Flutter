import 'package:equatable/equatable.dart';
import 'enums.dart';

/// A logged food entry within a meal — either resolved from a [Food]
/// lookup (with [quantityGrams]) or entered via Quick Add (macros direct).
class MealEntry extends Equatable {
  final String id;
  final String? foodId;
  final String name;
  final double quantityGrams;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final bool isQuickAdd;

  const MealEntry({
    required this.id,
    this.foodId,
    required this.name,
    required this.quantityGrams,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.isQuickAdd = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'foodId': foodId,
        'name': name,
        'quantityGrams': quantityGrams,
        'calories': calories,
        'proteinG': proteinG,
        'carbsG': carbsG,
        'fatG': fatG,
        'isQuickAdd': isQuickAdd,
      };

  factory MealEntry.fromJson(Map<String, dynamic> json) => MealEntry(
        id: json['id'] as String,
        foodId: json['foodId'] as String?,
        name: json['name'] as String,
        quantityGrams: (json['quantityGrams'] as num).toDouble(),
        calories: (json['calories'] as num).toDouble(),
        proteinG: (json['proteinG'] as num).toDouble(),
        carbsG: (json['carbsG'] as num).toDouble(),
        fatG: (json['fatG'] as num).toDouble(),
        isQuickAdd: json['isQuickAdd'] as bool? ?? false,
      );

  @override
  List<Object?> get props =>
      [id, foodId, name, quantityGrams, calories, proteinG, carbsG, fatG, isQuickAdd];
}

/// A meal (breakfast/lunch/dinner/snack) for a given day, holding one or
/// more [MealEntry] items.
class Meal extends Equatable {
  final String id;
  final String userId;
  final DateTime date;
  final MealType type;
  final List<MealEntry> entries;

  const Meal({
    required this.id,
    required this.userId,
    required this.date,
    required this.type,
    required this.entries,
  });

  double get totalCalories => entries.fold(0.0, (s, e) => s + e.calories);
  double get totalProteinG => entries.fold(0.0, (s, e) => s + e.proteinG);
  double get totalCarbsG => entries.fold(0.0, (s, e) => s + e.carbsG);
  double get totalFatG => entries.fold(0.0, (s, e) => s + e.fatG);

  Meal copyWith({List<MealEntry>? entries}) => Meal(
        id: id,
        userId: userId,
        date: date,
        type: type,
        entries: entries ?? this.entries,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'type': type.name,
        'entries': entries.map((e) => e.toJson()).toList(),
      };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['id'] as String,
        userId: json['userId'] as String,
        date: DateTime.parse(json['date'] as String),
        type: enumFromString(MealType.values, json['type'] as String?, MealType.snack),
        entries: (json['entries'] as List<dynamic>? ?? [])
            .map((e) => MealEntry.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );

  @override
  List<Object?> get props => [id, userId, date, type, entries];
}
