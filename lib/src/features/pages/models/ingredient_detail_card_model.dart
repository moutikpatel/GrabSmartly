class IngredientDetailCardModel {
  int id;
  String aisle;
  String category;
  double price;

  IngredientDetailCardModel({
    required this.id,
    required this.aisle,
    required this.category,
    required this.price,
  });

  factory IngredientDetailCardModel.fromMap(Map<String, dynamic> json) {
    return IngredientDetailCardModel(
      id: json['id'] ?? 0,
      aisle: json['aisle'] ?? '',
      category: (json['categoryPath'] as List)?.isNotEmpty == true
          ? (json['categoryPath'] as List).first ?? ''
          : '',
      price: json['estimatedCost']?['value']?.toDouble() ?? 0.0,
    );
  }
}