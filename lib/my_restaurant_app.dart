import 'package:flutter/material.dart';
import 'package:my_restaurant/ui/detail/detail_screen.dart';
import 'package:my_restaurant/ui/home/home_screen.dart';
import 'package:my_restaurant/ui/theme/theme.dart';

class MyRestaurantApp extends StatelessWidget {
  const MyRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Restaurant',
      theme: MyRestaurantTheme.getLightTheme(context),
      darkTheme: MyRestaurantTheme.getDarkTheme(context),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => DetailScreen(
          id: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}