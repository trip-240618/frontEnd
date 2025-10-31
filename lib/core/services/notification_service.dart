import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final _fcm = FirebaseMessaging.instance;
  final _plugin = FlutterLocalNotificationsPlugin();

  final _notificationController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get notificationStream => _notificationController.stream;

  /// channel
  final _channel = const AndroidNotificationChannel(
    "trips",
    "Trips Notifications",
    description: "트립스토리 알림 채널",
    importance: Importance.high,
  );

  Future<void> initialize() async {
    tz.initializeTimeZones();

    // Android 설정
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 설정
    final iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _initializePlatformSettings();
    _setupFirebaseListeners();
  }

  /// 초기 셋팅
  Future<void> _initializePlatformSettings() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);
    } else if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  /// 🔸 Firebase 메시지 리스너 설정
  void _setupFirebaseListeners() {
    // 앱이 foreground일 때
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification != null) {
        await _showLocalNotification(
          id: message.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          data: message.data,
        );
      }
    });

    // 백그라운드에서 알림을 눌러 앱이 열릴 때
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _notificationController.add(message.data);
    });

    // 앱이 완전히 종료된 상태에서 알림으로 시작될 때
    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        _notificationController.add(message.data);
      }
    });
  }

  /// 🔸 로컬 알림 표시
  Future<void> _showLocalNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      "trips",
      "Trips Notifications",
      channelDescription: "트립스토리 알림 채널",
      importance: Importance.max,
      priority: Priority.high,
      icon: "@mipmap/ic_launcher",
    );

    const iosDetails = DarwinNotificationDetails();

    final details = const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id,
      title,
      body,
      details,
      payload: jsonEncode(data ?? {}),
    );
  }

  /// iOS 전용 콜백
  Future<void> _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    print("📩 Received iOS Local Notification: $title");
  }

  /// 알림 클릭 시 콜백
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _notificationController.add(data);
    }
  }

  /// 🔸 Stream 정리
  void dispose() {
    _notificationController.close();
  }
}
