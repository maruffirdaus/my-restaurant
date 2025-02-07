import 'package:my_restaurant/data/remote/response/food.dart';

import 'drink.dart';

class Menus {
  List<Food> foods;
  List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: json['foods'] != null
        ? List<Food>.from(json['foods']!.map((x) => Food.fromJson(x)))
        : <Food>[],
    drinks: json['drinks'] != null
        ? List<Drink>.from(json['drinks']!.map((x) => Drink.fromJson(x)))
        : <Drink>[],
  );
}