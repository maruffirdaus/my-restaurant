import 'package:flutter/material.dart';
import 'package:my_restaurant/ui/theme/type.dart';

class MyRestaurantTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.orange,
      textTheme: getTextTheme(context),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.orange,
      textTheme: getTextTheme(context),
    );
  }
}
