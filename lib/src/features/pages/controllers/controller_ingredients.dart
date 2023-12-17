import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../routing/api_service/service_recipe_api.dart';
import '../models/ingredient_card_model.dart';

class IngredientListController {
  static Future<List<IngredientCardModel>> fetchIngredients(
      BuildContext context,
      TextEditingController searchController,
      ) async {
    try {
      return await RecipeApiService.instance.fetchIngredient(searchController.text);
    } catch (error) {
      print("Error fetching ingredients: $error");
      return []; // or handle the error appropriately
    }
  }

  static void fetchCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      print("Current User ID: $userId");
    } else {
      print("User is not signed in");
    }
  }

  static void addToGroceryList(BuildContext context, IngredientCardModel ingredient) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not signed in");
      return;
    }

    TextEditingController quantityController = TextEditingController();
    List<String> units = [
      'Item Count',
      'Dozen',
      'kg',
      'grams',
      'milligrams',
      'pounds',
      'ounces',
      'liters',
      'milliliters',
    ];
    String selectedUnit = units.first;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Add to Grocery List'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter quantity:'),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                const Text('Select unit:'),
                DropdownButton<String>(
                  value: selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                  },
                  items: units.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (quantityController.text.isNotEmpty) {
                    int quantity = int.parse(quantityController.text);
                    await _addToGroceryListWithQuantity(user, ingredient, quantity, selectedUnit);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a quantity')),
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  static Future<void> _addToGroceryListWithQuantity(
      User user,
      IngredientCardModel ingredient,
      int quantity,
      String unit,
      ) async {
    try {
      String userId = user.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);
      CollectionReference groceryListRef = userDocRef.collection('GroceryList');

      await groceryListRef.add({
        'ingredientID': ingredient.id,
        'ingredientName': ingredient.name,
        'quantity': quantity,
        'unit': unit,
      });

      print("Item added to grocery list successfully");
    } catch (error) {
      print("Error adding item to Firestore: $error");
    }
  }

  static void setState(VoidCallback callback) {
    callback();
  }
}
