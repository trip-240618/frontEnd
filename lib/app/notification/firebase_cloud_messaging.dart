import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/userState.dart';



// Future<void> dailyAtTimeNotification(int idx, String title,String startDates,String endDates) async {
//
//
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.deleteNotificationChannelGroup('id');
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//       idx, // 알림 ID (유일해야 함)
//     '${title}', // 알림 제목
//     '${title}약 먹을 시간입니다', // 알림 내용
//     _setNotiTime(startDates,endDates), /// 알림 시간 설정,
//     //   _nextInstanceOfMonday(),
//     const NotificationDetails(
//       android: AndroidNotificationDetails('id', 'Channel Name'),
//     ),
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//   );
// }
//
// tz.TZDateTime _setNotiTime(String startDates,String endDates) {
//   tz.initializeTimeZones();
//   tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
//   final parsedDate = DateTime.parse(startDates);
//   final startYear = parsedDate.year;
//   final startMonth = parsedDate.month;
//   final startDay = parsedDate.day;
//   final parsedDate2 = DateTime.parse(endDates);
//   final endYear = parsedDate2.year;
//   final endMonth = parsedDate2.month;
//   final endDay = parsedDate2.day;
//   /// 시작일
//   final startDate = tz.TZDateTime(tz.local, startYear, startMonth, startDay, 00, 00);
//   /// 종료일
//   final endDate = tz.TZDateTime(tz.local, endYear, endMonth, endDay, 23, 59);
//   var now = tz.TZDateTime.now(tz.local); /// 현재시간
//
//     if (now.isAfter(startDate) && now.isBefore(endDate)) {
//       now = tz.TZDateTime.now(tz.local);
//       /// 오늘이 화요일 또는 목요일인지 확인
//       if (now.weekday == DateTime.tuesday || now.weekday == DateTime.thursday) {
//         /// 알림 시간을 설정
//         return tz.TZDateTime(tz.local, now.year, now.month, now.day, 16, 41);
//       }
//       else{
//         return tz.TZDateTime(tz.local, now.year, now.month, now.day, 0, 0);
//       }
//     }
//     /// 기본적으로 현재 시간보다 이전의 시간을 반환하여 알림이 울리지 않도록 함
//     return tz.TZDateTime(tz.local, now.year, now.month, now.day, 0, 0);
// }

// tz.TZDateTime _nextInstanceOfMonday() {
//   final now = tz.TZDateTime.now(tz.local);
//   tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 17, 0);
//
//   while (scheduledDate.weekday != DateTime.monday && scheduledDate.weekday != DateTime.thursday) {
//     scheduledDate = scheduledDate.add(const Duration(days: 1));
//     print('가나다');
//   }
//
//   return scheduledDate;
// }

Future<void> onBackgroundMessage(RemoteMessage message) async {
  // await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    final notification = message.data['notification'];
  }
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final us = Get.put(UserState());
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  var channel = const AndroidNotificationChannel(
    'trips', 'trips',
    description: '트립스토리 알림 채널', // description
    importance: Importance.high,
  );

  setNotifications() {
    foregroundNotification();

    backgroundNotification();
    //
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
    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if(!us.notiDuplicationList.contains(message.messageId)){
        us.notiDuplicationList.add(message.messageId);
        flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: iosNotificationDetails
            ),
            payload: '${message.data}');
      }
    });
  }

  backgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
        Map<String, dynamic> dataMap = json.decode('${message.data}');
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }
  //
  terminateNotification() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      //
      // print('ㅋㅋㅋㅋㅋ : ${initialMessage.notification!.title!}');
      // print('ㅋㅋㅋㅋㅋㅋ22 : ${initialMessage.notification!.body!}');
      // print('ㅋㅋㅋㅋㅋㅋ33 : ${initialMessage.data['name']}');

      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
