import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:practice_one/models/meals_data.dart';
import 'package:practice_one/provider/favourite_meals_provider.dart';

class MealsDetailScreen extends ConsumerWidget {
  const MealsDetailScreen({
    Key? key,
    required this.meal,
    required this.title,
  }) : super(key: key);
  final Meal meal;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Listening for the favouriteMealsProvider
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    /// Determining if the current meal is in the favouriteMeals list
    final bool isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              final isAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .onToggleFavoriteMeal(meal);

              ///showing a message whenever the user toggles the favorite icon

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded
                      ? 'Meal has been added to Favorite'
                      : 'Meal has been removed from Favorite!!'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFavorite),
              ),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween<double>(
                  begin: 0.9,
                  end: 1,
                ).animate(animation),
                child: child,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Text('Ingredients',
                    style: TextStyle(color: Colors.orange[300], fontSize: 30)),
                const SizedBox(
                  height: 14,
                ),
                for (final ingredient in meal.ingredients)
                  Text(ingredient,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                const SizedBox(
                  height: 16,
                ),
                Text('Steps',
                    style: TextStyle(color: Colors.orange[300], fontSize: 30)),
                const SizedBox(
                  height: 14,
                ),
                for (final step in meal.steps)
                  Text(
                    step,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
