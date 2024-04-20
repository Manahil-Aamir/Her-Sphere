import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class Notifcation {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifcation() {
    initializeNotifications();
  }

  void initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = const AndroidInitializationSettings('girlicon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Channel Name',
      'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  void _scheduleNotification(DateTime date, String event) async {
    print('Scheduling notification...');

    // Subtract 30 minutes from the provided date
    var scheduledDate = date.subtract(Duration(minutes: 30));

    // Convert the scheduledDate to TZDateTime
    var tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // Configure Android notification details
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Channel name',
      'Channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Create notification details
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      // Schedule the notification using zonedSchedule method with TZDateTime
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Reminder',
        'You have an event: $event',
        tzScheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );

      // Show notification immediately
      _showNotification('Event:', 'Scheduled');

      print('Notification scheduled successfully');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}