import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
class LocalNotifyCation {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //initialized
  Future<void> initializeNotification() async {
    tz.initializeTimeZones();

    ///IOS
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  /// 안드로이드
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher

    final InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    print('test notification print');
  }
  /// foreground 상태
  void selectNotification(NotificationResponse payload) async {
    // print('notification payload333333: ${payload.payload}');
    Map<String, dynamic> data = jsonDecode('${payload.payload}');
    switch (data['name']) {
      case 'first' :
        break;
    }
  }
}

