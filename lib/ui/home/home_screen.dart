import 'package:flutter/material.dart';
import 'package:my_restaurant/provider/detail/customer_review_list_provider.dart';
import 'package:my_restaurant/provider/home/restaurant_list_provider.dart';
import 'package:my_restaurant/provider/home/restaurant_list_result_state.dart';
import 'package:my_restaurant/ui/widget/message_card.dart';
import 'package:my_restaurant/ui/home/widget/restaurant_card.dart';
import 'package:provider/provider.dart';

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
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Restaurant')
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch(value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListLoadedState(data: var restaurantList) => restaurantList.isEmpty
            ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MessageCard(
                message: const Text('There are no restaurants'),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<RestaurantListProvider>().fetchRestaurantList();
                  },
                  child: const Text('Refresh'),
                ),
              ),
            )
            : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantList[index];

                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: restaurant.id
                    ).whenComplete(() {
                      context.read<CustomerReviewListProvider>().reset();
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              }
            ),
            RestaurantListErrorState(error: var error) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MessageCard(
                message: Text(error ?? 'Error'),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<RestaurantListProvider>().fetchRestaurantList();
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
                    context.read<RestaurantListProvider>().fetchRestaurantList();
                  },
                  child: const Text('Refresh'),
                ),
              ),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController controller = TextEditingController();

          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search restaurants',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        label: Text('Keyword'),
                        border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<RestaurantListProvider>().searchRestaurants(controller.text);
                            Navigator.pop(context);
                          },
                          child: const Text('Search'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
