import 'package:flutter/material.dart';
import 'package:my_restaurant/provider/shared_preferences/shared_preferences_provider.dart';
import 'package:my_restaurant/ui/detail/detail_screen.dart';
import 'package:my_restaurant/ui/main/main_screen.dart';
import 'package:my_restaurant/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class MyRestaurantApp extends StatelessWidget {
  const MyRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesProvider>(
      builder: (context, value, child) => MaterialApp(
        title: 'My Restaurant',
        theme: MyRestaurantTheme.getLightTheme(context),
        darkTheme: MyRestaurantTheme.getDarkTheme(context),
        themeMode: value.settings?.darkModeEnabled ?? false
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/detail': (context) => DetailScreen(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
