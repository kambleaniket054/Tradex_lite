import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);

    await _notificationsPlugin.initialize(initSettings);
    final androidImplementation =
    _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    var androidDetails = AndroidNotificationDetails(
      'price_alerts', // channel ID
      'Price Alerts', // channel name
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // notification ID
      title,
      body,
      notificationDetails,
    );
  }
}