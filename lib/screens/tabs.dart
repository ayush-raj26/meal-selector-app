import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_meals_app/screens/filters.dart';
import 'package:select_meals_app/screens/meal_categories.dart';
import 'package:select_meals_app/screens/meals.dart';
import 'package:select_meals_app/widgets/main_side_drawer.dart';
import 'package:select_meals_app/providers/favourites_provider.dart';
import 'package:select_meals_app/providers/filters_provider.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    final availableMeals = ref.watch(filterMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    Widget activePageTitle = const Row(
      children: [
        Text("Pick your Category "),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.food_bank_outlined,
          size: 30,
        )
      ],
    );

    if (_selectedPageIndex == 1) {
      final favouriteMeal = ref.watch(favouiteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeal,
      );
      activePageTitle = const Text('Your Favourites');
    }

    return Scaffold(
      appBar: AppBar(
        title: activePageTitle,
      ),
      drawer: SideDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_rounded), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
        ],
      ),
    );
  }
}
