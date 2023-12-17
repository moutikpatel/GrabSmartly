import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/recipe_ingredients_screen.dart';

import '../../../../routing/api_service/service_recipe_api.dart';
import '../../../../strings/string_colors.dart';
import 'grocery_list_details_screen.dart';
import '../../models/recipe_detail_model.dart'; // Import your recipe detail model

class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late List<GroceryListItem> groceryList;
  late Future<List<RecipeDetailModel>> recipeDetails = Future.value([]); // Initialize with an empty list
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    groceryList = [];
    _fetchRecipeDetails(); // Fetch recipe details directly
    _fetchGroceryListData();
  }

  Future<void> _fetchRecipeDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not signed in");
      return;
    }

    try {
      String userId = user.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      CollectionReference groceryListRecipeRef = userDocRef.collection('GroceryListRecipe');

      QuerySnapshot querySnapshot = await groceryListRecipeRef.get();

      List<int> recipeIds = querySnapshot.docs.map((doc) {
        return doc['recipeID'] as int;
      }).toList();

      print("Recipe IDs: $recipeIds");

      List<RecipeDetailModel> details = await _fetchRecipeDetailsList(recipeIds);

      print("Recipe Details: $details");

      setState(() {
        recipeDetails = Future.value(details);
      });
    } catch (error) {
      print("Error fetching recipe details: $error");
    }
  }

  Future<List<RecipeDetailModel>> _fetchRecipeDetailsList(List<int> recipeIds) async {
    List<RecipeDetailModel> details = [];

    for (int recipeId in recipeIds) {
      try {
        RecipeDetailModel data = await RecipeApiService.instance.fetchRecipeDetails(recipeId);
        details.add(data);
      } catch (error) {
        print("Error fetching recipe details: $error");
      }
    }

    return details;
  }

  void _fetchGroceryListData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not signed in");
      return;
    }

    try {
      String userId = user.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);

      CollectionReference groceryListRef = userDocRef.collection('GroceryList');

      QuerySnapshot querySnapshot = await groceryListRef.get();

      List<GroceryListItem> items = querySnapshot.docs.map((doc) {
        return GroceryListItem(
          id: doc.id,
          ingredientID: doc['ingredientID'],
          ingredientName: doc['ingredientName'],
          quantity: doc['quantity'],
          unit: doc['unit'],
        );
      }).toList();

      setState(() {
        groceryList = items;
      });
    } catch (error) {
      print("Error fetching grocery list data: $error");
    }
  }

  Future<void> _removeRecipeFromFirebase(String recipeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("User is not signed in");
        return;
      }

      String userId = user.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);
      CollectionReference groceryListRecipeRef = userDocRef.collection('GroceryListRecipe');

      // Find the document with the given recipeId and delete it
      QuerySnapshot querySnapshot = await groceryListRecipeRef.where('recipeID', isEqualTo: int.parse(recipeId)).get();
      querySnapshot.docs.forEach((doc) async {
        await groceryListRecipeRef.doc(doc.id).delete();
      });

      print('Recipe removed from Firebase: $recipeId');

      // Trigger a state update to refresh the list
      _fetchRecipeDetails();
    } catch (error) {
      print('Error removing recipe from Firebase: $error');
      // Handle the error as needed
    }
  }
  Future<void> _clearGroceryList() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("User is not signed in");
        return;
      }

      String userId = user.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);
      CollectionReference groceryListRef = userDocRef.collection('GroceryList');

      // Delete all documents in the collection
      QuerySnapshot querySnapshot = await groceryListRef.get();
      querySnapshot.docs.forEach((doc) async {
        await groceryListRef.doc(doc.id).delete();
      });

      print('Grocery list cleared from Firebase');
    } catch (error) {
      print('Error clearing grocery list from Firebase: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            // Fixed Card with GestureDetector for Expansion
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
                if (isExpanded) {
                  // Navigate to the new screen when expanded
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroceryListDetailsScreen(groceryList: groceryList),
                    ),
                  );
                }
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                ),
                elevation: 5, // Add elevation for a shadow effect
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), // Same radius as Card's shape
                    color: tButtonColor.withOpacity(0.7),
                    border: Border.all(width: 3.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text content
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Home Grocery List', // Fixed Name for the Card
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add your logic for clearing the list here
                              _clearGroceryList();
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Clear List  '),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                backgroundColor: Colors.redAccent,
                                textStyle: const TextStyle(color: Colors.black87, wordSpacing: 2.0)// Text color

                            ),
                          ),
                        ],
                      ),
                      // Background image
                      Container(
                        height: 150.0, // Adjust the height as needed
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ80AOOWBf2cQ9x1uY2gavqxpatDsoIpUGWApWvKAPLBfFX18pZuivb3qUYXLnKvMLuEO0&usqp=CAU',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // New card for displaying recipe details
            FutureBuilder<List<RecipeDetailModel>>(
              future: recipeDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Discover new recipes to try out this week', style: Theme.of(context).textTheme.displayMedium,),
                  );
                } else {
                  // Display a card for each recipe detail
                  return Column(
                    children: snapshot.data!.map((detail) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to RecipeIngredientsScreen with the selected recipe detail
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeIngredientsScreen(recipeDetail: detail),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: tButtonColor.withOpacity(0.7),
                              border: Border.all(width: 3.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        constraints: BoxConstraints(maxWidth: 325), // Adjust the maximum width as needed
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            detail.title, // Adjust to your model
                                            style: Theme.of(context).textTheme.displayMedium,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Remove the recipe from the Firebase collection here
                                        _removeRecipeFromFirebase(detail.id.toString());
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 150.0, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        detail.imgUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                                // Additional content if needed
                              ],
                            ),
                          ),
                        ),
                      );

                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GroceryListItem {
  final String id;
  final int ingredientID;
  final String ingredientName;
  int quantity;
  final String unit;
  String aisle;
  String category;
  double price;

  GroceryListItem({
    required this.id,
    required this.ingredientName,
    required this.quantity,
    required this.unit,
    required this.ingredientID,
    this.aisle = '',
    this.category = '',
    this.price = 0.0,
  });
}
