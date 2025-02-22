import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant.dart';
import '../../provider/customer_reviews/customer_reviews_provider.dart';
import '../../provider/local_database/local_database_provider.dart';
import '../widget/restaurant_card.dart';
import '../widget/message_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LocalDatabaseProvider>().getRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(
      builder: (context, value, child) {
        List<Restaurant> restaurants = value.restaurants ?? List.empty();

        return restaurants.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: MessageCard(
                  message: const Text('There are no restaurants'),
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<LocalDatabaseProvider>().getRestaurants();
                    },
                    child: const Text('Refresh'),
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];

                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(context, '/detail',
                              arguments: restaurant.id)
                          .whenComplete(() {
                        context.read<CustomerReviewsProvider>().reset();
                      });
                    },
                    isFavorite: true,
                    onFavoritePressed: () {
                      context
                          .read<LocalDatabaseProvider>()
                          .removeRestaurant(restaurant.id);
                      context.read<LocalDatabaseProvider>().getRestaurants();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                });
      },
    );
  }
}
