import 'package:flutter/material.dart';
import 'package:my_restaurant/provider/local_database/local_database_provider.dart';
import 'package:my_restaurant/ui/widget/message_card.dart';
import 'package:my_restaurant/ui/widget/restaurant_card.dart';
import 'package:provider/provider.dart';

import '../../provider/customer_reviews/customer_reviews_provider.dart';
import '../../provider/restaurants/restaurants_provider.dart';
import '../../provider/restaurants/restaurants_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantsProvider>().getRestaurants();
      context.read<LocalDatabaseProvider>().getRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantsProvider, LocalDatabaseProvider>(
      builder: (context, value1, value2, child) {
        return switch (value1.resultState) {
          RestaurantsLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          RestaurantsLoadedState(data: var restaurantList) => restaurantList
                  .isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 16, right: 16, bottom: 88),
                  child: MessageCard(
                    message: const Text('There are no restaurants'),
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<RestaurantsProvider>().getRestaurants();
                      },
                      child: const Text('Refresh'),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 16, top: 16, right: 16, bottom: 88),
                  itemCount: restaurantList.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantList[index];
                    final isFavorite =
                        value2.restaurants?.contains(restaurant) ?? false;

                    return RestaurantCard(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.pushNamed(context, '/detail',
                                arguments: restaurant.id)
                            .whenComplete(() {
                          context.read<CustomerReviewsProvider>().reset();
                        });
                      },
                      isFavorite: isFavorite,
                      onFavoritePressed: () {
                        if (isFavorite) {
                          context
                              .read<LocalDatabaseProvider>()
                              .removeRestaurant(restaurant.id);
                        } else {
                          context
                              .read<LocalDatabaseProvider>()
                              .addRestaurant(restaurant);
                        }
                        context.read<LocalDatabaseProvider>().getRestaurants();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  }),
          RestaurantsErrorState(error: var error) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MessageCard(
                message: Text(error ?? 'Error'),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<RestaurantsProvider>().getRestaurants();
                  },
                  child: const Text('Refresh'),
                ),
              ),
            ),
          _ => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MessageCard(
                message: const Text('There are no restaurants'),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<RestaurantsProvider>().getRestaurants();
                  },
                  child: const Text('Refresh'),
                ),
              ),
            ),
        };
      },
    );
  }
}
