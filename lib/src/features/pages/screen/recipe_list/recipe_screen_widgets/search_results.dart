// search_results_container.dart
import 'package:flutter/material.dart';
import '../../../../../strings/string_colors.dart';
import '../../../models/recipe_card_model.dart';
import '../recipe_details/recipe_detail_screen.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<RecipeCardModel> searchResults;

  const SearchResultsWidget({Key? key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) {
      // If searchResults is empty, return an empty container or null
      return Container();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Text(
              'Search Results'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(
              thickness: 3.0,
              color: Colors.black87,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  searchResults.length,
                      (index) => Container(
                    width: 220.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailsScreen(
                                recipeId: searchResults[index].id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: 200.0,
                                  height: 180.0,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      searchResults[index].imgUrl,
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
                                      searchResults[index].title,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
