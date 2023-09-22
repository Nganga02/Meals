import 'package:flutter/material.dart';
import 'package:practice_one/models/categories.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({Key? key, required this.category, required this.onTap}) : super(key: key);
  final Category category;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Text(category.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.background,
        ) ),
      ),
    );
  }
}
