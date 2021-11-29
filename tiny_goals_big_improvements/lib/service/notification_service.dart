import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:tiny_goals_big_improvements/repository/options_repository.dart';
import 'package:tiny_goals_big_improvements/service/upcoming_service.dart';

/// Will handle all notifications of the app.
class NotificationService {
  static NotificationService instance = NotificationService();

  /// The id for the daily notification.
  ///
  /// Everyday at a specific time a notification should get scheduled that reminds the user of it's
  /// upcoming goals.
  static const int dailyScheduledNotificationId = 80301;

  /// The id for the daily notification tomorrow.
  ///
  /// Everyday at a specific time a notification should get scheduled that reminds the user of it's
  /// upcoming goals. But when the user didn't open up the app on that date the notification for the
  /// next day must get scheduled in advance.
  static const int tomorrowScheduledNotificationId = 80302;

  /// The id for the daily notification the day after tomorrow.
  ///
  /// Everyday at a specific time a notification should get scheduled that reminds the user of it's
  /// upcoming goals. But when the user didn't open up the app on that date the notification for the
  /// next day must get scheduled in advance. But in order to not annoy the user anymore, the next
  /// notification is scheduled a week later.
  static const int dayAfterTomorrowScheduledNotificationId = 80303;

  /// The id for the weekly notification.
  ///
  /// Everyday at a specific time a notification should get scheduled that reminds the user of it's
  /// upcoming goals. But when the user didn't open up the app on that date the notification for the
  /// next day must get scheduled in advance. But in order to not annoy the user anymore, the next
  /// notification is scheduled a week later. When the user did't use the app for a week the
  /// notification should notify the user that he didn't use the app since then. After that he'll
  /// probably deinstall the application since he's not using it anymore and we just remembered him
  /// that he has the app installed. So there is no need for any further notification planning in
  /// the future.
  static const int weeklyScheduledNotificationId = 80307;

  final Logger _log = Logger("NotificationService");

  final OptionsRepository _optionsRepository = OptionsRepository.instance;

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final UpcomingService _upcomingService = UpcomingService();

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

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _init = true;
  }

  Future<void> scheduleNotification() async {
    if (_init == false) {
      await init();
    }

    await cancelNotifications();

    if ((await _upcomingService.getUpcoming(null)).isEmpty) {
      _log.fine('Don\' schedule any notification.');
      return;
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

    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime today =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 14);
    tz.TZDateTime tomorrow = today.add(const Duration(days: 1));
    tz.TZDateTime dayAfterTomorow = tomorrow.add(const Duration(days: 1));
    tz.TZDateTime nextWeek = today.add(const Duration(days: 7));

    String head = "👋 Did you reach your goals?";
    String body = "Take a look at your upcoming goals.";

    if (await _optionsRepository.getLanguage() == 'de') {
      head = "👋 Haben sie ihre Ziele schon erreicht?";
      body = "Sehen Sie nach, was alles bevorsteht.";
    }

    _log.fine('Scheduled notification to ${today.toString()}');
    flutterLocalNotificationsPlugin.zonedSchedule(
      dailyScheduledNotificationId,
      head,
      body,
      today,
      platformChannelSpecifics,
      payload: 'Notification Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    _log.fine('Scheduled notification to ${tomorrow.toString()}');
    flutterLocalNotificationsPlugin.zonedSchedule(
      tomorrowScheduledNotificationId,
      head,
      body,
      tomorrow,
      platformChannelSpecifics,
      payload: 'Notification Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    _log.fine('Scheduled notification to ${dayAfterTomorow.toString()}');
    flutterLocalNotificationsPlugin.zonedSchedule(
      dayAfterTomorrowScheduledNotificationId,
      head,
      body,
      dayAfterTomorow,
      platformChannelSpecifics,
      payload: 'Notification Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    _log.fine('Scheduled notification to ${nextWeek.toString()}');
    flutterLocalNotificationsPlugin.zonedSchedule(
      weeklyScheduledNotificationId,
      head,
      body,
      nextWeek,
      platformChannelSpecifics,
      payload: 'Notification Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    _log.fine('All notification scheduled properly.');
  }

  Future<void> cancelNotifications() async {
    _log.fine('Canceling all notification');

    await flutterLocalNotificationsPlugin.cancel(
      dailyScheduledNotificationId,
    );
    await flutterLocalNotificationsPlugin.cancel(
      tomorrowScheduledNotificationId,
    );
    await flutterLocalNotificationsPlugin.cancel(
      dayAfterTomorrowScheduledNotificationId,
    );
    await flutterLocalNotificationsPlugin.cancel(
      weeklyScheduledNotificationId,
    );
  }
}
