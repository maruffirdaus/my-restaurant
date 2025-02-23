import 'package:flutter/material.dart';

import '../../data/model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  final bool isFavorite;
  final Function() onFavoritePressed;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.isFavorite = false,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                          width: 160,
                          height: 240,
                          child: Center(
                              child: Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                          ))),
                      width: 160,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton.filled(
                    onPressed: onFavoritePressed,
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline),
                  ),
                )
              ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: Text(
                              restaurant.city,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.star_outline,
                            size: 16,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
