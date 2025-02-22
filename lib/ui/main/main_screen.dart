import 'package:flutter/material.dart';
import 'package:my_restaurant/provider/nav_index/nav_index_provider.dart';
import 'package:my_restaurant/ui/home/home_screen.dart';
import 'package:my_restaurant/ui/settings/settings_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/restaurants/restaurants_provider.dart';
import '../favorites/favorites_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavIndexProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: switch (value.navIndex) {
            0 => const Text('My Restaurant'),
            1 => const Text('Favorites'),
            _ => const Text('Settings'),
          },
        ),
        body: switch (value.navIndex) {
          0 => const HomeScreen(),
          1 => const FavoritesScreen(),
          _ => const SettingsScreen(),
        },
        floatingActionButton: switch (value.navIndex) {
          0 => FloatingActionButton(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      label: Text('Keyword'),
                                      border: OutlineInputBorder()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
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
                                        context
                                            .read<RestaurantsProvider>()
                                            .searchRestaurants(controller.text);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Search'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
              },
              child: const Icon(Icons.search),
            ),
          _ => null,
        },
        bottomNavigationBar: NavigationBar(
          selectedIndex: context.watch<NavIndexProvider>().navIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onDestinationSelected: (index) {
            context.read<NavIndexProvider>().navIndex = index;
          },
        ),
      );
    });
  }
}
