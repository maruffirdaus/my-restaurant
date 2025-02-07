import 'package:flutter/material.dart';
import 'package:my_restaurant/provider/detail/customer_review_list_result_state.dart';
import 'package:my_restaurant/provider/detail/restaurant_detail_result_state.dart';
import 'package:my_restaurant/ui/detail/widget/content_card.dart';
import 'package:my_restaurant/ui/detail/widget/customer_review_card.dart';
import 'package:my_restaurant/ui/detail/widget/menu_chip.dart';
import 'package:my_restaurant/ui/widget/message_card.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/customer_review_list_provider.dart';
import '../../provider/detail/restaurant_detail_provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, value, child) {
        return switch(value.resultState) {
          RestaurantDetailLoadingState() => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          RestaurantDetailLoadedState(data: var restaurant) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(restaurant.name),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ContentCard(
                      padding: const EdgeInsets.all(24),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            restaurant.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ContentCard(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  restaurant.city,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ContentCard(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_outline,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  restaurant.rating.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ContentCard(
                      padding: const EdgeInsets.all(24),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            restaurant.address,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ContentCard(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Foods',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 32,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                final food = restaurant.menus.foods[index];

                                return MenuChip(
                                  child: Text(food.name),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ContentCard(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Drinks',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 32,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                final drink = restaurant.menus.drinks[index];

                                return MenuChip(
                                  child: Text(drink.name),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ContentCard(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Customer reviews',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Consumer<CustomerReviewListProvider>(
                            builder: (context, value, child) {
                              return switch(value.resultState) {
                                CustomerReviewListLoadingState() => const SizedBox(
                                  width: double.infinity,
                                  height: 120,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                CustomerReviewListLoadedState(data: var customerReviews) => SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    itemCount: customerReviews.length,
                                    itemBuilder: (context, index) {
                                      final customerReview = customerReviews[index];

                                      return CustomerReviewCard(
                                        customerReview: customerReview,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 8,
                                      );
                                    },
                                  ),
                                ),
                                CustomerReviewListErrorState(error: var error) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Text(
                                    error ?? 'Error',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                _ => restaurant.customerReviews.isEmpty
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Text(
                                    'There are no customer reviews',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                                : SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    itemCount: restaurant.customerReviews.length,
                                    itemBuilder: (context, index) {
                                      final customerReview = restaurant.customerReviews[index];

                                      return CustomerReviewCard(
                                        customerReview: customerReview,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 8,
                                      );
                                    },
                                  ),
                                ),
                              };
                            }
                          ),
                        ],
                      ),
                    ),
                  ]
                )
                ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                TextEditingController nameController = TextEditingController();
                TextEditingController reviewController = TextEditingController();

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
                              'Add review',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  label: Text('Name'),
                                  border: OutlineInputBorder()
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: reviewController,
                              decoration: const InputDecoration(
                                  label: Text('Review'),
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
                                    context.read<CustomerReviewListProvider>().addReview(widget.id, nameController.text, reviewController.text);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Add'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
          RestaurantDetailErrorState(error: var error) => Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: MessageCard(
                  message: Text(error ?? 'Error'),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
              ),
            ),
          ),
          _ => Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: MessageCard(
                  message: const Text('There is no detail about the restaurant'),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
              ),
            ),
          ),
        };
      },
    );
  }
}