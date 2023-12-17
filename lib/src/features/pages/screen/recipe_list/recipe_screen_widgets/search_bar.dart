// search_categories_container.dart
import 'package:flutter/material.dart';
import 'package:grabsmartly/src/strings/string_colors.dart';

import '../../../../../strings/string_colors.dart';
import '../../../../../strings/string_colors.dart';
import '../../../../../strings/string_colors.dart';
class SearchBarWidget extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final Future<void> Function(String) fetchCuisineRecipe;
  final Future<void> Function(String) fetchDietRecipe;
  final List<String> dietaryPreferences;
  final List<String> cuisineTypes;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.dietaryPreferences,
    required this.cuisineTypes,
    required this.fetchCuisineRecipe,
    required this.fetchDietRecipe,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();

}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _isFilterExpanded = false;
  bool _isCuisineTypesExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tSearchBarColor.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28.0),
          bottomRight: Radius.circular(28.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          // SearchBar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: widget.searchController, // Fix here
                    onSubmitted: (_) => widget.onSearch(), // Fix here
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for a recipe...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: widget.onSearch, // Fix here
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter
              ListTile(
                title: Text(
                  'Explore Tastes',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: IconButton(
                  icon: Icon(_isFilterExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      _isFilterExpanded = !_isFilterExpanded;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(thickness: 4.0,color: Colors.black54,),
              ),
              // Dietary Preferences and Popular Cuisines
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: _isFilterExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _buildFilterContent(context),
                secondChild:  const FadeTransition(opacity: kAlwaysCompleteAnimation,),
              ),

              const SizedBox(height: 8.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [

          // Dietary Preferences
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dietary Preferences:',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.dietaryPreferences.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () =>
                            widget.fetchDietRecipe(widget.dietaryPreferences[index]),
                        child: Chip(
                          backgroundColor: tButtonColor.withOpacity(0.7),
                          label: Text(
                            widget.dietaryPreferences[index],
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8.0),

// Popular Cuisines
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Cuisines:',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.start,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.cuisineTypes.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () =>
                            widget.fetchCuisineRecipe(widget.cuisineTypes[index]),
                        child: Chip(

                          backgroundColor: tButtonColor.withOpacity(0.7),
                          label: Text(
                            widget.cuisineTypes[index],
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
