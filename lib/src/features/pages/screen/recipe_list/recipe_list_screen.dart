// Your main screen file
import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_screen_widgets/meal_type_results.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_screen_widgets/search_bar.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_screen_widgets/search_results.dart';
import '../../../../routing/api_service/service_recipe_api.dart';
import '../../models/recipe_card_model.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<String> dietaryPreferences = [
    'Gluten Free',
    'Ketogenic',
    'Vegetarian',
    'Lacto-Vegetarian',
    'Vegan',
    'Pescetarian',
  ];
  List<String> cuisineTypes = [
    'African',
    'Asian',
    'Chinese',
    'French',
    'Indian',
    'Italian',
    'Mediterranean',
    'Mexican',
    'Middle Eastern',
    'Southern',
  ];
  List<String> recipeTypes = [
    'main course',
    'side dish',
    'dessert',
    'salad',
    'breakfast',
    'soup',
    'appetizer',
  ];

  List<List<RecipeCardModel>> recipeCards = List.filled(7, [], growable: false);
  List<RecipeCardModel> searchResults = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  Future<void> searchRecipes() async {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      try {
        // Call the fetchRecipesWithQuery function with the search query
        List<RecipeCardModel> results =
            await RecipeApiService.instance.fetchRecipesWithQuery(query);
        setState(() {
          // Update the searchResults list to trigger a UI update
          searchResults = results;
        });
        print('Search Results: $searchResults');
      } catch (error) {
        print('Error searching recipes: $error');
      }
    }
  }

  Future<void> fetchRecipesWithCuisine(String cuisine) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<RecipeCardModel> results =
          await RecipeApiService.instance.fetchRecipesWithCuisines(cuisine);
      setState(() {
        searchResults = results;
      });
    } catch (error) {
      print('Error fetching recipes by cuisine: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchRecipesWithDiet(String diet) async {
    try {
      setState(() {
        isLoading = true;
      });

      List<RecipeCardModel> results =
      await RecipeApiService.instance.fetchRecipesWithDiet(diet);
      setState(() {
        searchResults = results;
      });
    } catch (error) {
      print('Error fetching recipes by cuisine: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchRecipe() async {
    try {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < recipeTypes.length; i++) {
        List<RecipeCardModel> data =
            await RecipeApiService.instance.fetchRecipeByType(recipeTypes[i]);
        setState(() {
          recipeCards[i] = data;
        });
      }
    } catch (error) {
      throw Exception('Error fetching recipe data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildResultCard(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            SizedBox(
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
              height: 120.0,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.transparent, Colors.blueGrey],
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  searchResults[index].title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search and Categories Container
            SearchBarWidget(
              searchController: _searchController,
              onSearch: searchRecipes,

              dietaryPreferences: dietaryPreferences,
              fetchDietRecipe: fetchRecipesWithDiet,

              cuisineTypes: cuisineTypes,
              fetchCuisineRecipe: fetchRecipesWithCuisine,

            ),

            // Combine Search Results and Meal Type Display
            SearchResultsWidget(searchResults: searchResults),
            MealTypeResultsWidget(
                recipeTypes: recipeTypes, recipeCards: recipeCards),
          ],
        ),
      ),
    );
  }
}
