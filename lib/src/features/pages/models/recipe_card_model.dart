class RecipeCardModel {
  // Define your fields here
  int id;
  String title;
  String imgUrl;

  RecipeCardModel({required this.title, required this.imgUrl , required this.id});

  factory RecipeCardModel.fromMap(Map<String, dynamic> json) {
    return RecipeCardModel(
      id: json['id'],
      title: json['title'],
      imgUrl: json['image'],
    );
  }
}