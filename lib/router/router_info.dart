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
import 'package:tripStory/view/login/binding/login_binding.dart';
import 'package:tripStory/view/login/binding/profile_add_binding.dart';
import 'package:tripStory/view/login/binding/term_binding.dart';
import 'package:tripStory/view/login/views/login_view.dart';
import 'package:tripStory/view/login/views/profile_add_view.dart';
import 'package:tripStory/view/login/views/register_success_view.dart';
import 'package:tripStory/view/login/views/term_view.dart';
import 'package:tripStory/view/setting/bindings/my_page_binding.dart';
import 'package:tripStory/view/setting/bindings/my_page_setting_binding.dart';
import 'package:tripStory/view/setting/views/my_page_setting_view.dart';
import 'package:tripStory/view/setting/views/my_page_view.dart';
import 'package:tripStory/view/splash/binding/splash_binding.dart';
import 'package:tripStory/view/splash/views/splash_view.dart';

class RouterInfo {
  static final config = <GetPage>[
    GetPage(
      name: "/",
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.term,
      page: () => const TermView(),
      binding: TermBinding(),
    ),
    GetPage(
      name: Routes.myPage,
      page: () => const MyPageView(),
      binding: MyPageBinding(),
    ),
    GetPage(
      name: Routes.myPageSetting,
      page: () => const MyPageSettingView(),
      binding: MyPageSettingBinding(),
    ),
    GetPage(
      name: Routes.profileAdd,
      page: () {
        final isMarketing = Get.arguments;

        if (isMarketing is! bool) {
          throw ArgumentError('error');
        }
        return ProfileAddView(
          marketing: isMarketing,
        );
      },
      binding: ProfileAddBinding(),
    ),
    GetPage(
      name: Routes.registerSuccess,
      page: () => const RegisterSuccessView(),
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
