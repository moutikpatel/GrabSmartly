import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/controllers/controller_ingredients.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';
import '../../../../repository/user_repository/user_repository.dart';
import '../../models/ingredient_card_model.dart';

class IngredientListScreen extends StatefulWidget {
  final UserRepository userRepository;

  IngredientListScreen({required this.userRepository});

  @override
  _IngredientListScreenState createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {

  late Future<List<IngredientCardModel>> _futureIngredients;
  final TextEditingController _searchController = TextEditingController();
  List<IngredientCardModel> groceryList = [];
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    _futureIngredients = Future.value([]);
    IngredientListController.fetchCurrentUserId();
    selectedUnit = 'kg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _futureIngredients = IngredientListController.fetchIngredients(context, _searchController);
                });
              },

              decoration: const InputDecoration(
                labelText: 'Search for an ingredient',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<IngredientCardModel>>(
              future: _futureIngredients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: tButtonColor.withOpacity(0.2),
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].name.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.add_circle_outline_rounded),
                            onPressed: () {
                              IngredientListController.addToGroceryList(context, snapshot.data![index]);
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
