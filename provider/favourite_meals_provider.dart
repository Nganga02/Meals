import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:practice_one/models/meals_data.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier(): super([]);

  ///Toggling between the favorites in the meals detailed screen
  bool onToggleFavoriteMeal(Meal meal) {
    ///checking to see if the meal is in the provider list
    final mealIsFavorite = state.contains(meal);

    ///adding or removing the meal in the provider list
    if (mealIsFavorite) {
      ///removing the meal if it exists in the state list
      state = state.where((mealInList) => mealInList.id != meal.id).toList();
      return false;
    } else {
      ///Adding a meal to provider state list
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
