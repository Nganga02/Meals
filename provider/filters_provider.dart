import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_one/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider(
  (ref) {
    ///Listening for the mealsProvider so as to get the list of meals
    final meals = ref.watch(mealsProvider);

    ///Listening for the filtersProvider so as to get the current filters to filter our meals on
    final activeFilter = ref.watch(filtersProvider);

    return meals.where(
      (meal) {
        if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (activeFilter[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
  },
);
