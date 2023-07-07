import 'package:flutter/material.dart';
import 'package:select_meals_app/data/dummy_data.dart';
import 'package:select_meals_app/widgets/category_grid_item.dart';
import 'meals.dart';
import 'package:select_meals_app/models/category_blueprint.dart';
import 'package:select_meals_app/models/meals_blueprint.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // the property will be defined later and not at the time of creation of class

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      // lowerBound: 0, Default values
      // upperBound: 1, Default values
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filteredmeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredmeals,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Scaffold(
        body: GridView(
          padding: const EdgeInsets.all(18),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 22),
          children: [
            //  availableCategories.map((category) => CategoryGridItem(category: category))
            // One more way
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectedCategory(context, category);
                },
              ),
          ],
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.4),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
