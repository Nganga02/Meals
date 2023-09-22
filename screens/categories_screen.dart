import 'package:flutter/material.dart';

import 'package:practice_one/data/categories_data.dart';
import 'package:practice_one/models/meals_data.dart';
import 'package:practice_one/screens/meals_screen.dart';
import 'package:practice_one/widgets/categories_grid_item.dart';
import 'package:practice_one/models/categories.dart' as categories;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  ///Declaring a new animation controller
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );

    ///Playing the animation controller
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    ///disposing the controller
    _animationController.dispose();
  }

  void onTap(
    BuildContext context,
    categories.Category category,
  ) {
    final categoryMeals = widget.availableMeals
        .where(
          (element) => element.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: categoryMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.5,
              crossAxisCount: 2),
          children: [
            for (final category in availableCategories)
              CategoriesGridItem(
                category: category,
                onTap: () {
                  onTap(context, category);
                },
              ),
          ],
        ),
        builder: (context, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeIn,
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}
