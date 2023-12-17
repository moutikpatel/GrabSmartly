class RecipeDetailModel {
  int id;
  int serving;
  int cookingTime;
  int preparingTime;
  int likes;
  String title;
  String description;
  String imgUrl;
  String spoonacularSourceUrl;
  List<ExtendedIngredient> extendedIngredients; // Include extendedIngredients

  RecipeDetailModel({
    required this.id,
    required this.serving,
    required this.cookingTime,
    required this.preparingTime,
    required this.likes,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.spoonacularSourceUrl,
    required this.extendedIngredients, // Include extendedIngredients in the constructor
  });

  factory RecipeDetailModel.fromMap(Map<String, dynamic> json) {
    // Extract extendedIngredients data from the json map
    List<dynamic> extendedIngredientsData = json['extendedIngredients'] ?? [];

    // Convert each extended ingredient data to ExtendedIngredient object
    List<ExtendedIngredient> extendedIngredients = extendedIngredientsData
        .map((ingredientData) => ExtendedIngredient.fromMap(ingredientData))
        .toList();

    return RecipeDetailModel(
      id: json['id'],
      serving: json['servings'],
      cookingTime: json['cookingMinutes'],
      preparingTime: json['preparationMinutes'],
      likes: json['aggregateLikes'],
      title: json['title'],
      description: json['summary'],
      imgUrl: json['image'],
      spoonacularSourceUrl: json['spoonacularSourceUrl'],
      extendedIngredients: extendedIngredients, // Assign the converted list to the extendedIngredients field
    );
  }
}

class ExtendedIngredient {
  int id;
  String aisle;
  String image;
  String consistency;
  String name;
  String nameClean;
  String original;
  String originalName;
  double amount;
  String unit;
  // Add other fields for extended ingredient as needed

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    // Add other fields for extended ingredient as needed
  });

  factory ExtendedIngredient.fromMap(Map<String, dynamic> json) {
    return ExtendedIngredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
      // Extract other fields for extended ingredient as needed
    );
  }
}
