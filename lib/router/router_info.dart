import 'dart:ui';

import 'package:get/get.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/hoom/bindings/notification_list_binding.dart';
import 'package:tripStory/view/hoom/bindings/rooms_binding.dart';
import 'package:tripStory/view/hoom/bindings/trip_calendar_binding.dart';
import 'package:tripStory/view/hoom/bindings/trip_rooms_create_binding.dart';
import 'package:tripStory/view/hoom/views/notification_list_view.dart';
import 'package:tripStory/view/hoom/views/rooms_view.dart';
import 'package:tripStory/view/hoom/views/trip_room_calendar_view.dart';
import 'package:tripStory/view/hoom/views/trip_room_create_view.dart';
import 'package:tripStory/view/splashScreen.dart';

class RouterInfo {
  static final config = <GetPage>[
    GetPage(
      name: "/",
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.rooms,
      page: () => const TripRoomListView(),
      binding: RoomsBinding(),
    ),
    GetPage(
      name: Routes.createRoom,
      page: () => const TripRoomCreateView(),
      binding: TripRoomsCreateBinding(),
    ),
    GetPage(
      name: Routes.createRoomCalendar,
      page: () {
        final selectedColor = Get.arguments;

        if (selectedColor is! Color) {
          throw ArgumentError('error');
        }
        return TripRoomCalendarView(selectedColor: selectedColor);
      },
      binding: TripCalendarBinding(),
    ),
    GetPage(
      name: Routes.notificationList,
      page: () => const NotificationListView(),
      binding: NotificationListBinding(),
    ),
  ];
}
