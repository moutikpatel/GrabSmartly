import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/models/recipe_detail_model.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_details/recipe_instructrion_screen.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';

import '../../../../../routing/api_service/service_recipe_api.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final int recipeId;

  const RecipeDetailsScreen({Key? key, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  late RecipeDetailModel recipeDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails(widget.recipeId);
  }

  Future<void> fetchRecipeDetails(int recipeId) async {
    try {
      RecipeDetailModel data = await RecipeApiService.instance.fetchRecipeDetails(recipeId);
      setState(() {
        recipeDetail = data;
      });
    } catch (error) {
      print("Error fetching recipe details: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoading ? const Text('Loading...') : Text(recipeDetail.title, style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        elevation: 3,

      ),
      body: _isLoading
          ? Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28.0),
                child: Image.asset(
                  'assets/images_pages/cook.gif',
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              const CircularProgressIndicator(),
            ],
          ))
          : Stack(
            children: [
              Image.network(
                recipeDetail.imgUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Container(

                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(200, 200, 200, 0.6),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border(
                        left: BorderSide(width: 1.0, color: Colors.black87.withOpacity(0.1)),
                        right: BorderSide(width: 1.0, color: Colors.black87.withOpacity(0.1)),
                        top: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                        bottom: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                      ),
                    ),

                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              recipeDetail.title,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const Divider(thickness: 3.0, color: Colors.black87,),

                            Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: const Border(
                                left: BorderSide(width: 1.5, color: Colors.black87),
                                right: BorderSide(width: 1.5, color: Colors.black87),
                                top: BorderSide(width: 1.5, color: Colors.black87),
                                bottom: BorderSide(width: 1.5, color: Colors.black87),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  // First Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // First Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              recipeDetail.serving.toString(),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              'Serves',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Spacer
                                      const SizedBox(width: 10.0),
                                      // Second Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              recipeDetail.likes.toString(),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              'Likes',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Spacer
                                  const SizedBox(height: 20.0),
                                  // Second Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Third Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              recipeDetail.preparingTime.toString(),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              'Prep time',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Spacer
                                      const SizedBox(width: 10.0),
                                      // Fourth Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              recipeDetail.cookingTime.toString(),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              'Cook time',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                            Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        minWidth: 280,
                                        height: 60.0,
                                        color: Colors.blue,
                                        onPressed: () async {
                                          await _addRecipeToGroceryList(recipeDetail.id);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Add to Grocery List',
                                              style: Theme.of(context).textTheme.headlineSmall,
                                            ),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(30.0),

                                              child: Icon(Icons.shopping_cart_rounded,fill: 1),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),



                                    // Favorite Icon
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.favorite),
                                        color: Colors.black87,
                                        onPressed: () async {
                                          await _addRecipeToFavourites(recipeDetail.id);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                minWidth: 150,
                                height: 60.0,
                                color: tButtonColor,
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecipeWebInstructionScreen(
                                        url: recipeDetail.spoonacularSourceUrl,
                                        title: recipeDetail.title,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cooking Steps',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const SizedBox(
                                      width: 30.0,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(28.0),
                                      child: Image.asset(
                                        'assets/images_pages/cook.gif',
                                        height: 52.0,
                                        width: 52.0,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ingredients',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const Divider(thickness: 3.0, color: Colors.black87),
                                  const SizedBox(height: 10.0),
                                  // Display extendedIngredients using data from the model
                                  ...recipeDetail.extendedIngredients.map((ingredient) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${ingredient.name}:',
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            '${ingredient.amount} ${ingredient.unit}',
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Future<void> _addRecipeToGroceryList(int recipeID) async {
    // Fetch the current Firebase user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not signed in");
      return;
    }

    try {
      // Use the user ID as the document ID
      String userId = user.uid;

      // Reference to the user document
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      // Reference to the GroceryList subcollection
      CollectionReference groceryListRef = userDocRef.collection('GroceryListRecipe');

      // Add the recipe to the GroceryList subcollection
      await _addToGroceryListRecipe(groceryListRef, recipeID);

      // Show a snackbar indicating success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe added to grocery list successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print("Error adding recipe to Firestore: $error");
      // Rethrow the error to signal completion with an error
      rethrow;
    }
  }
  Future<void> _addToGroceryListRecipe(CollectionReference groceryListRef, int recipeID) async {
    await groceryListRef.add({
      'recipeID': recipeID,
    });

    print("Recipe added to grocery list successfully");
  }

  Future<void> _addRecipeToFavourites(int recipeID) async {
    // Fetch the current Firebase user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not signed in");
      return;
    }

    try {
      // Use the user ID as the document ID
      String userId = user.uid;

      // Reference to the user document
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      // Reference to the GroceryList subcollection
      CollectionReference groceryListRef = userDocRef.collection('FavouritesList');

      // Add the recipe to the GroceryList subcollection
      await _addToFavouritesRecipe(groceryListRef, recipeID);

      // Show a snackbar indicating success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe added to grocery list successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print("Error adding recipe to Firestore: $error");
      // Rethrow the error to signal completion with an error
      rethrow;
    }
  }
  Future<void> _addToFavouritesRecipe(CollectionReference groceryListRef, int recipeID) async {
    await groceryListRef.add({
      'recipeID': recipeID,
    });

    print("Recipe added to grocery list successfully");
  }


}

