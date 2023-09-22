import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({Key? key, required this.icon, required this.metaData})
      : super(key: key);

  final IconData icon;
  final String metaData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          metaData,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
