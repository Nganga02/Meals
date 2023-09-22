import 'package:flutter/material.dart';
import 'package:practice_one/models/meals_data.dart';
import 'package:practice_one/screens/meals_detail_screen.dart';
import 'package:practice_one/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {Key? key,
      required this.title,
      required this.meals,})
      : super(key: key);

  final String title;
  final List<Meal> meals;


  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailScreen(
          meal: meal,
          title: meal.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ooops nothing here',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white)),
          const SizedBox(height: 16),
          Text('Try choosing a different category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white))
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: meals[index],
              onTap: (meal) {
                selectMeal(context, meal);
              },
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
