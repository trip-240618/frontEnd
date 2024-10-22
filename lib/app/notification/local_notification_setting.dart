import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
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


/// 알림 권한 여부 설정
void requestNotificationPermissions() {
  ///fcm
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  /// 안드로이드 일때
  if (Platform.isAndroid) {
    FirebaseMessaging.instance.requestPermission(
      badge: true,
      alert: true,
      sound: true,
    );
    var channel = AndroidNotificationChannel(
        'trips', 'trips',
        description: '트립스토리 알림 채널', // description
        importance: Importance.high,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  /// Ios 일 때
  else {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}