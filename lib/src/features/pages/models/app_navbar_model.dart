import 'package:flutter/material.dart';
import 'package:grabsmartly/src/features/pages/screen/grocery_list/grocery_list_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/recipe_list/recipe_list_screen.dart';
import 'package:grabsmartly/src/features/pages/screen/user_profile/profile_screen.dart';

class AppModelNavBar extends StatefulWidget {
  AppModelNavBar({super.key});

  @override
  State<AppModelNavBar> createState() => _AppModelNavBarState();
}

class _AppModelNavBarState extends State<AppModelNavBar> {
  final _pageControlller = PageController();
  int _selectedIndex = 0;
  @override
  void dispose() {
    _pageControlller.dispose();
  }
  static List<Widget> _pages = <Widget>[
    GroceryListScreen(),
    RecipeListScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store_outlined),
              label: 'Grocery',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Recipe',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

