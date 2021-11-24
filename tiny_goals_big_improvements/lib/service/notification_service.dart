import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  bool _init = false;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const LinuxInitializationSettings linuxInitializationSettings =
        LinuxInitializationSettings(defaultActionName: 'tgbiaction');

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      linux: linuxInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _init = true;
  }

  Future<void> showNotifications() async {
    if (_init == false) {
      await init();
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel ID',
      'channel Name',
    );

    const LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      linux: linuxPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'This is the Notification Body',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
