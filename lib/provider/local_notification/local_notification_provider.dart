import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_restaurant/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService service;
  int _notificationId = 0;

  LocalNotificationProvider(this.service);

  Future<bool> requestPermission() async => await service.requestPermission();

  void scheduleNotification() {
    _notificationId++;
    service.scheduleNotification(
        id: _notificationId,
        title: 'Daily reminder',
        body: 'Feeling hungry? It\'s lunchtime! 🍕',
        payload: '');
  }

  Future<List<PendingNotificationRequest>>
      getPendingNotificationRequests() async =>
          await service.getPendingNotificationRequests();

  Future<void> cancelNotification(int id) async =>
      await service.cancelNotification(id);
}
