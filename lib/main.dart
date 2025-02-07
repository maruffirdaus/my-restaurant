import 'package:flutter/material.dart';
import 'package:my_restaurant/data/remote/api_service.dart';
import 'package:my_restaurant/provider/detail/customer_review_list_provider.dart';
import 'package:my_restaurant/provider/detail/restaurant_detail_provider.dart';
import 'package:my_restaurant/provider/home/restaurant_list_provider.dart';
import 'package:provider/provider.dart';

import 'my_restaurant_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiService>()
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiService>()
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerReviewListProvider(
            context.read<ApiService>()
          ),
        ),
      ],
      child: const MyRestaurantApp(),
    ),
  );
}