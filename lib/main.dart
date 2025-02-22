import 'package:flutter/material.dart';
import 'package:my_restaurant/data/remote/api_service.dart';
import 'package:my_restaurant/provider/customer_reviews/customer_reviews_provider.dart';
import 'package:my_restaurant/provider/local_database/local_database_provider.dart';
import 'package:my_restaurant/provider/local_notification/local_notification_provider.dart';
import 'package:my_restaurant/provider/nav_index/nav_index_provider.dart';
import 'package:my_restaurant/provider/restaurant_detail/restaurant_detail_provider.dart';
import 'package:my_restaurant/provider/restaurants/restaurants_provider.dart';
import 'package:my_restaurant/provider/shared_preferences/shared_preferences_provider.dart';
import 'package:my_restaurant/service/local_notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local/shared_preferences_service.dart';
import 'data/local/sqlite_service.dart';
import 'my_restaurant_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavIndexProvider(),
        ),
        Provider(
          create: (context) => SharedPreferencesService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider(
              context.read<SharedPreferencesService>()),
        ),
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CustomerReviewsProvider(context.read<ApiService>()),
        ),
        Provider(
          create: (context) => SqliteService(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<SqliteService>()),
        ),
        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermission(),
        ),
      ],
      child: const MyRestaurantApp(),
    ),
  );
}
