import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('app_icon'));

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          _rescheduleNotification(payload);
        }
      },
    );
  }

  static void showNotification(
      String productName, DateTime date, String tekrar) async {
    var timeParts = tekrar.split(":");
    var scheduledNotificationDateTime = date.add(Duration(
      hours: int.parse(timeParts[0]),
      minutes: int.parse(timeParts[1]),
      seconds: int.parse(timeParts[2]),
    ));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      0,
      'تذكير',
      'لا تنسى $productName',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      payload: '$productName:$tekrar',
    );
  }

  static void _rescheduleNotification(String payload) async {
    var payloadParts = payload.split(":");
    if (payloadParts.length < 4) {
      return;
    }

    var productName = payloadParts[0];
    var timeParts = payloadParts.sublist(1, 4);
    var scheduledNotificationDateTime = DateTime.now().add(Duration(
      hours: int.parse(timeParts[0]),
      minutes: int.parse(timeParts[1]),
      seconds: int.parse(timeParts[2]),
    ));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      0,
      'تذكير',
      'لا تنسى $productName',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static void cancelNotification(String productName) async {
    var notifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var notification in notifications) {
      if (notification.payload?.startsWith(productName) ?? false) {
        await flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }
  }
}
