import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


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
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  var channel = const AndroidNotificationChannel(
    'tripFcm', 'tripFcm',
    description: 'this is fcm channel', // description
    importance: Importance.high,
  );

  setNotifications() {
    // FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    foregroundNotification();

    backgroundNotification();
    //
    terminateNotification();
    // final token =// _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }
  ///버튼 눌렀을 때 포그라운드
  foregroundNotification() {
    const String darwinNotificationCategoryPlain = 'tripFcm';

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
      print('111');
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
          payload: '${message?.data}');
      print('eeeee');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
    });
  }

  backgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
        Map<String, dynamic> dataMap = json.decode('${message.data}');
        // print('ㄴㄹㅁㄴㅁㅁㅁㅁ : ${message.notification!.title!}');
        // print('ㄴㄹㅁㄴㅁㅁㅁㅁ22 : ${message.notification!.body!}');
        // print('ㄴㄹㅁㄴㅁㅁㅁㅁ33 : ${dataMap['name']}');

        // up.fcmDocId = '${message.data['docId']}';
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

// class FCMController {
//   final String _serverKey =
//       "AAAA6RlPOZ0:APA91bHl4TNWSQH8O9s83Qbof11BZgLGrBH3AdM0zZiM4C_152I19xwVS_V8pDQ3aJmw3s88V07pGf9sHy41NsGtuFtJqqkB6rrGPjDlXjHG4U_y3fjfQFqacWW4ppIrVJPbjASu38mp";
//
//   Future<void> sendMessage({
//     required String userToken,
//     required String title,
//     required String body,
//   }) async {
//     http.Response response;
//
//     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//
//     try {
//       response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//           headers: <String, String>{'Content-Type': 'application/json', 'Authorization': 'key=$_serverKey'},
//           body: jsonEncode({
//             'notification': {'title': title, 'body': body, 'sound': 'true'},
//             'ttl': '60s',
//             "content_available": true,
//             'data': {
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'id': '1',
//               'status': 'done',
//               "action": 'clickSound',
//             },
//             // 'topic': 'community',
//             // 상대방 토큰 값, to -> 단일, registration_ids -> 여러명
//             'to': userToken
//             // 'registration_ids': tokenList
//           }));
//     } catch (e) {
//       print('error $e');
//     }
//   }
// }