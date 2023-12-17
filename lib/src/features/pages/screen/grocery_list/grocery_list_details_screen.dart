import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/models/ingredient_card_model.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/grocery_store/grocery_store_costco_price_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/grocery_store/grocery_store_price_screen.dart';
import 'package:grabsmartly/src/routing/api_service/service_recipe_api.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';
import '../../models/ingredient_detail_card_model.dart';
import 'grocery_list_screen.dart';

class GroceryListDetailsScreen extends StatefulWidget {
  final List<GroceryListItem> groceryList;

  const GroceryListDetailsScreen({required this.groceryList});

  @override
  _GroceryListDetailsScreenState createState() =>
      _GroceryListDetailsScreenState();
}

class _GroceryListDetailsScreenState extends State<GroceryListDetailsScreen> {
  List<GroceryListItem> _groceryList = [];
  String _selectedCategory = ''; // Added variable to store selected category
  final List<String> _categories = ['All','Dairy','Produce','Cheese','Nuts', 'Pasta', 'Spices']; // Array of categories
  bool _connectionCompleted = false;
  @override
  void initState() {
    super.initState();
    _fetchGroceryListData();
  }

  Future<void> _fetchGroceryListData() async {
    try {
      // Fetch the current Firebase user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("User is not signed in");
        return;
      }

      // Use the user ID as the document ID
      String userId = user.uid;

      // Reference to the user document
      DocumentReference userDocRef =
      FirebaseFirestore.instance.collection('Users').doc(userId);

      // Reference to the GroceryList subcollection
      CollectionReference groceryListRef =
      userDocRef.collection('GroceryList');

      // Fetch the documents in the GroceryList subcollection
      QuerySnapshot querySnapshot = await groceryListRef.get();

      // Create a list of futures for fetching ingredient information
      List<Future<GroceryListItem>> fetchFutures = querySnapshot.docs
          .map((doc) async {
        // Create a GroceryListItem
        GroceryListItem item = GroceryListItem(
          id: userId,
          ingredientID: doc['ingredientID'],
          ingredientName: doc['ingredientName'],
          quantity: doc['quantity'],
          unit: doc['unit'],
        );

        // Fetch ingredient information and update the item
        IngredientDetailCardModel ingredientInfo =
        await RecipeApiService.instance
            .fetchIngredientInformation(item.ingredientID);

        // Update the item with additional information
        item.aisle = ingredientInfo.aisle;
        item.category = ingredientInfo.category;
        item.price = ingredientInfo.price;

        return item;
      })
          .toList();

      // Wait for all the futures to complete
      List<GroceryListItem> items = await Future.wait(fetchFutures);

      setState(() {
        // Update the state with the fetched grocery list items
        _groceryList = items;
      });

      print('Fetched grocery list items: $items');
    } catch (error) {
      print("Error fetching grocery list data: $error");
    }
  }

  void _deleteItem(String itemId) async {
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
      DocumentReference userDocRef =
      FirebaseFirestore.instance.collection('Users').doc(userId);

      // Reference to the GroceryList subcollection
      CollectionReference groceryListRef =
      userDocRef.collection('GroceryList');

      // Delete the document with the specified itemId
      await groceryListRef.doc(itemId).delete();

      // Optionally, display a success message to the user
      print("Item deleted successfully");

      // Fetch and set the updated grocery list data
      _fetchGroceryListData();
    } catch (error) {
      print("Error deleting item: $error");
    }
  }

  // Function to show filter options in a bottom sheet
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: tMainNavBarColor,
              //borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15.0,),
                Text('Filter By Category', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(thickness: 3.0, color: Colors.white70,),
                ),
                const SizedBox(height: 15.0,),
                for (String category in _categories)
                  ListTile(
                    title: Text(category, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), ),
                    onTap: () {
                      _filterByCategory(category);
                      Navigator.pop(context);
                    },
                  ),
                Divider(thickness: 1.0, color: Colors.white60,)
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to filter grocery list by category
  void _filterByCategory(String selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  // Function to filter grocery list by selected category
  List<GroceryListItem> _getFilteredGroceryList() {
    if (_selectedCategory.isEmpty) {
      return _groceryList;
    }

    return _groceryList
        .where((item) =>
        item.aisle.toLowerCase().contains(_selectedCategory.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Home Grocery List',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 30.0,),
            IconButton(
              icon: const Icon(Icons.filter_list_alt , color: Colors.black87,),
              onPressed: _showFilterOptions,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Opacity(
            opacity: 0.5,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ80AOOWBf2cQ9x1uY2gavqxpatDsoIpUGWApWvKAPLBfFX18pZuivb3qUYXLnKvMLuEO0&usqp=CAU',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _getFilteredGroceryList().isEmpty
                ? Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text(
                'Empty Grocery List. \nAdd Items to View here.',
                style: Theme.of(context).textTheme.headlineMedium,
              )],
            )
                : !_connectionCompleted
                ? Container(
              // Your existing code for ListView.builder
              child: ListView.builder(
                itemCount: _getFilteredGroceryList().length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.all(10.0),
                    color: tButtonColor.withOpacity(0.8),
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: ListTile(
                            title: Text(
                              '${_getFilteredGroceryList()[index].ingredientName}'.toUpperCase(),
                              style:
                              Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteItem(
                                    _getFilteredGroceryList()[index].id);
                              },
                            ),
                          ),
                          children: [
                            // Additional details can be displayed here
                            ListTile(
                              title: Text(
                                'Quantity: ${_getFilteredGroceryList()[index].quantity} ${_getFilteredGroceryList()[index].unit}',
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'General Price:  ${_getFilteredGroceryList()[index].price * 0.01} USD',
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Aisle: ${_getFilteredGroceryList()[index].aisle}',
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Category: ${_getFilteredGroceryList()[index].category}',
                                style:
                                Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            ListTile(
                              title: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroceryStorePriceScreen(
                                            productName: _getFilteredGroceryList()[
                                            index]
                                                .ingredientName,
                                          ),
                                    ),
                                  );
                                },
                                child: const Text(
                                    'Check In-Store Walmart Prices'),
                              ),
                            ),
                            ListTile(
                              title: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GroceryStoreCostCoPriceScreen(
                                            productName: _getFilteredGroceryList()[
                                            index]
                                                .ingredientName,
                                          ),
                                    ),
                                  );
                                },
                                child: const Text(
                                    'Check In-Store CostCo Prices'),
                              ),
                            ),
                            // Add more widgets as needed
                          ],
                          onExpansionChanged: (isExpanded) {
                            if (isExpanded) {
                              // Handle expansion if needed
                              //_fetchIngredientInformation(_groceryList[index].ingredientID);
                            } else {
                              // Handle collapse if needed
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

}
