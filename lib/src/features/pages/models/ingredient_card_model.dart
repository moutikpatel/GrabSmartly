class IngredientCardModel {
  int id;
  String name;
  String imgUrl;
  int quantity;
  String unit;


  IngredientCardModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.quantity = 0,
    this.unit = '',

  });

  factory IngredientCardModel.fromMap(Map<String, dynamic> json) {
    return IngredientCardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imgUrl: json['image'] ?? '',
      quantity: json['amount']?.toInt() ?? 0,
      unit: json['unit'] ?? '',

    );
  }
}
