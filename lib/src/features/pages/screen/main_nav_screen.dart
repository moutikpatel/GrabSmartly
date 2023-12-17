import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_list_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/user_profile/profile_screen.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';
import 'package:grabsmartly/src/strings/string_text.dart';

import '../../../repository/user_repository/user_repository.dart';
import 'grocery_list/grocery_list_screen.dart';
import 'ingredients_list/ingredient_list_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = Get.put(UserRepository());;
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _pages; // Declare it here

  @override
  Widget build(BuildContext context) {
    // Initialize _pages in the build method
    _pages = [
      GroceryListScreen(),
      IngredientListScreen(userRepository: userRepository,),
      RecipeListScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        elevation: 0,

      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: tMainNavBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GNav(
              gap: 5,
              selectedIndex: _selectedIndex,
              onTabChange: _navigateBottomBar,
              padding: EdgeInsets.all(13),
              iconSize: 34,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              backgroundColor: tMainNavBarColor,
              color: Colors.white,
              activeColor: Colors.white,

              tabs: const [
                GButton(
                  icon: Icons.local_grocery_store_outlined,
                  text: 'Grocery List',
                ),
                GButton(
                  icon: Icons.search_outlined,
                  text: 'Ingredients',
                ),
                GButton(
                  icon: Icons.receipt_long_outlined,
                  text: 'Recipes',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Profile',
                ),
              ]),
        ),
      ),
    );
  }
}