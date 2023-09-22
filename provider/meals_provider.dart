import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:practice_one/data/dummy_meals_data.dart';

final mealsProvider = Provider((ref){
  return dummyMeals;
});