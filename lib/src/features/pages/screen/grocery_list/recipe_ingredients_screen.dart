import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/grocery_store/grocery_store_costco_price_screen.dart';
import '../../../../strings/string_colors.dart';
import '../../models/recipe_detail_model.dart';
import '../recipe_list/recipe_details/recipe_detail_screen.dart';
import 'grocery_store/grocery_store_price_screen.dart';

class RecipeIngredientsScreen extends StatefulWidget {
  final RecipeDetailModel recipeDetail;

  const RecipeIngredientsScreen({Key? key, required this.recipeDetail}) : super(key: key);

  @override
  _RecipeIngredientsScreenState createState() => _RecipeIngredientsScreenState();
}

class _RecipeIngredientsScreenState extends State<RecipeIngredientsScreen> {
  late List<IngredientItem> ingredientList;

  @override
  void initState() {
    super.initState();
    ingredientList = widget.recipeDetail.extendedIngredients
        .map((ingredient) => IngredientItem(ingredient: ingredient, isInHand: false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeDetail.title, style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        elevation: 0,

      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity, // Adjust the height as needed
            width: double.infinity,
            child: Image.network(
              widget.recipeDetail.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(200, 200, 200, 0.6),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border(
                      left: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                      right: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                      top: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                      bottom: BorderSide(width: 1.5, color: Colors.black87.withOpacity(0.1)),
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Ingredient Name',style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('Item in Hand',style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                      Divider(thickness: 2.0,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ingredientList.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: ListTile(
                              title: Text(
                                '${ingredientList[index].ingredient.name}: ${ingredientList[index].ingredient.amount} ${ingredientList[index].ingredient.unit}'.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: Checkbox(
                                value: ingredientList[index].isInHand,
                                onChanged: (value) {
                                  setState(() {
                                    ingredientList[index].isInHand = value!;
                                  });
                                },
                              ),
                            ),
                            children: [
                              //Walmart
                              ListTile(
                                title: ElevatedButton(
                                  onPressed: () {
                                    // Handle button press action
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GroceryStorePriceScreen(
                                          productName: ingredientList[index].ingredient.name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Check In-Store Walmart Prices'),
                                ),
                              ),
                              //CostCo
                              ListTile(
                                title: ElevatedButton(
                                  onPressed: () {
                                    // Handle button press action
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GroceryStoreCostCoPriceScreen(
                                          productName: ingredientList[index].ingredient.name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Check In-Store CostCo Prices'),
                                ),
                              ),
                              const SizedBox(height: 20.0)
                              // Add more widgets as needed
                            ],
                            onExpansionChanged: (isExpanded) {
                              if (isExpanded) {
                                // Handle expansion if needed
                              } else {
                                // Handle collapse if needed
                              }
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minWidth: MediaQuery.of(context).size.width,
                          height: 60.0,
                          color: tButtonColor.withOpacity(0.7),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecipeDetailsScreen(
                                  recipeId: widget.recipeDetail.id,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View Full Recipe',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientItem {
  final ExtendedIngredient ingredient;
  bool isInHand;

  IngredientItem({required this.ingredient, required this.isInHand});
}
