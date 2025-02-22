import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/local_notification/local_notification_provider.dart';
import '../../provider/shared_preferences/shared_preferences_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void saveDailyReminderEnabled(BuildContext context, bool isEnabled) async {
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();

    await sharedPreferencesProvider.saveDailyReminderEnabled(isEnabled);
    sharedPreferencesProvider.getSettings();
  }

  void saveDarkModeEnabled(BuildContext context, bool isEnabled) async {
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();

    await sharedPreferencesProvider.saveDarkModeEnabled(isEnabled);
    sharedPreferencesProvider.getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<SharedPreferencesProvider>(
        builder: (context, value, child) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily reminder',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        'Enable or disable daily reminder',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  Switch(
                    value: value.settings?.dailyReminderEnabled ?? false,
                    onChanged: (value) async {
                      var isEnabled = false;

                      if (value) {
                        isEnabled = await context
                            .read<LocalNotificationProvider>()
                            .requestPermission();

                        if (isEnabled) {
                          context
                              .read<LocalNotificationProvider>()
                              .scheduleNotification();
                        }
                      } else {
                        final pendingNotificationRequests = await context
                            .read<LocalNotificationProvider>()
                            .getPendingNotificationRequests();

                        for (var request in pendingNotificationRequests) {
                          context
                              .read<LocalNotificationProvider>()
                              .cancelNotification(request.id);
                        }
                      }

                      saveDailyReminderEnabled(context, isEnabled);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark mode',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        'Enable or disable dark mode',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  Switch(
                    value: value.settings?.darkModeEnabled ?? false,
                    onChanged: (value) {
                      saveDarkModeEnabled(context, value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
