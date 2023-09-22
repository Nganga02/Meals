import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:practice_one/provider/favourite_meals_provider.dart';
import 'package:practice_one/screens/categories_screen.dart';
import 'package:practice_one/screens/meals_screen.dart';
import 'package:practice_one/screens/settings.dart';
import 'package:practice_one/widgets/main_drawer.dart';
import 'package:practice_one/provider/filters_provider.dart';

const kAvailableFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedIndex = 0;

  ///setting the current index after the tap of the button
  void onSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  ///Selecting the screen after the tap of the button
  void _selectedScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'preferences') {
      Navigator.of(context).push <Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) => const PreferencesScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Creating a list of meals using te filter screen in the FilterScreen
    final availableMeals = ref.watch(filteredMealsProvider);

    ///Creating a new watcher for the FavoritesProvider
    final favouriteMeals = ref.watch(favoriteMealsProvider);

    /// List of my screens
    List<Widget> myScreen = [
      CategoriesScreen(
        availableMeals: availableMeals,
      ),
      MealsScreen(
        title: 'Favourites',
        meals: favouriteMeals,
      )
    ];

    return Scaffold(
      extendBody: true,
      drawer: MainDrawer(
        onSelectScreen: _selectedScreen,
      ),
      body: myScreen[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.hardEdge,
          height: 70,
          child: BottomNavigationBar(
            onTap: onSelected,
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: 'Favorite')
            ],
          ),
        ),
      ),
    );
  }
}
