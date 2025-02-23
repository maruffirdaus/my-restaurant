import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  Future<void> init() async {
    const androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<bool> _requestAndroidNotificationPermission() async =>
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission() ??
      false;

  Future<bool> _requestAndroidExactAlarmPermission() async =>
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission() ??
      false;

  Future<bool> requestPermission() async =>
      await _requestAndroidNotificationPermission() &&
      await _requestAndroidExactAlarmPermission();

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String channelId = '1',
    String channelName = 'General Notification',
  }) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _getNextNotificationSchedule(),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
  }

  tz.TZDateTime _getNextNotificationSchedule() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, 11, 00);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<List<PendingNotificationRequest>>
      getPendingNotificationRequests() async =>
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  Future<void> cancelNotification(int id) async =>
      await flutterLocalNotificationsPlugin.cancel(id);
}
