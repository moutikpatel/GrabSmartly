// meal_type_display_container.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../strings/string_colors.dart';
import '../../../models/recipe_card_model.dart';
import '../recipe_details/recipe_detail_screen.dart';

class MealTypeResultsWidget extends StatelessWidget {
  final List<String> recipeTypes;
  final List<List<RecipeCardModel>> recipeCards;

  const MealTypeResultsWidget({super.key, required this.recipeTypes, required this.recipeCards});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          recipeTypes.length,
              (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        recipeTypes[index].toUpperCase(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Divider(
                        thickness: 3.0,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeCards[index].length,
                    itemBuilder: (BuildContext context, int cardIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecipeDetailsScreen(
                                  recipeId: recipeCards[index][cardIndex].id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 200.0,
                                    height: 180.0,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        recipeCards[index][cardIndex].imgUrl,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 200.0,
                                    height: 180.0,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.black87.withOpacity(0.8), Colors.black87.withOpacity(0.1)],
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        recipeCards[index][cardIndex].title,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
