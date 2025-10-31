import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:tripStory/controller/notificationState.dart';
// import 'package:tripStory/controller/tripState.dart';
// import 'package:tripStory/controller/userState.dart';
// import 'package:tripStory/presentation/trip/bottomNavigator.dart';

class FCM {
  // final us = Get.put(UserState());
  // final ts = Get.put(TripState());
  // NotiState notis = Get.put(NotiState());
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  var channel = const AndroidNotificationChannel(
    'trips',
    'trips',
    description: '트립스토리 알림 채널',
    importance: Importance.high,
  );

  setNotifications() {
    foregroundNotification();
    backgroundNotification();
    terminateNotification();
  }

  ///버튼 눌렀을 때 포그라운드
  foregroundNotification() {
    const String darwinNotificationCategoryPlain = 'trips';

    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          'id',
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    );

    ///IOS 알림
    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   if (!us.notiDuplicationList.contains(message.messageId)) {
    //     us.notiDuplicationList.add(message.messageId);
    //     flutterLocalNotificationsPlugin.show(
    //         message.hashCode,
    //         message.notification?.title,
    //         message.notification?.body,
    //         NotificationDetails(
    //             android: AndroidNotificationDetails(
    //               channel.id,
    //               channel.name,
    //               channelDescription: channel.description,
    //               icon: '@mipmap/ic_launcher',
    //             ),
    //             iOS: iosNotificationDetails),
    //         payload: '${message.data}');
    //   }
    // });
  }

  backgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        // Uri uri = Uri.parse(message.data['destination']);
        // String? tripId = uri.queryParameters['tripId'];
        // String? historyId = uri.queryParameters['historyId'];
        // if (historyId != null) {
        //   await notis.getNotificationDetail(int.parse(tripId!), int.parse(historyId!));
        //   // Get.to(()=>NotiHistoryDetail(tripId: int.parse(tripId),historyId: int.parse(historyId),));
        // } else {
        //   await ts.getSelectTrip(int.parse(tripId!));
        //   // Get.to(() => BottomNavigator());
        // }
      },
    );
  }

  terminateNotification() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      // Uri uri = Uri.parse(message.data['destination']);
      // String? tripId = uri.queryParameters['tripId'];
      // String? historyId = uri.queryParameters['historyId'];
      // if (historyId != null) {
      //   await notis.getNotificationDetail(int.parse(tripId!), int.parse(historyId!));
      //   // Get.to(()=>NotiHistoryDetail(tripId: int.parse(tripId),historyId: int.parse(historyId),));
      // } else {
      //   await ts.getSelectTrip(int.parse(tripId!));
      //   // Get.to(() => BottomNavigator());
      // }
    }
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
