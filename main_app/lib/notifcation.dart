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
        // Handle notification tap here
      },
    );
  }

  static void showNotification(
      String productName, DateTime date, String tekrar) async {
    var scheduledNotificationDateTime = date.add(Duration(
      hours: int.parse(tekrar.split(":")[0]),
      minutes: int.parse(tekrar.split(":")[1]),
      seconds: int.parse(tekrar.split(":")[2]),
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
      payload: productName,
    );
  }

  static void cancelNotification(String productName) async {
    var notifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var notification in notifications) {
      if (notification.payload == productName) {
        await flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }
  }
}
