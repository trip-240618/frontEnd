import 'dart:ui';

import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/presentation/hoom/bindings/notification_list_binding.dart';
import 'package:tripStory/presentation/hoom/bindings/rooms_binding.dart';
import 'package:tripStory/presentation/hoom/bindings/trip_calendar_binding.dart';
import 'package:tripStory/presentation/hoom/bindings/trip_rooms_create_binding.dart';
import 'package:tripStory/presentation/hoom/views/notification_list_view.dart';
import 'package:tripStory/presentation/hoom/views/rooms_view.dart';
import 'package:tripStory/presentation/hoom/views/trip_room_calendar_view.dart';
import 'package:tripStory/presentation/hoom/views/trip_room_create_view.dart';
import 'package:tripStory/presentation/login/binding/login_binding.dart';
import 'package:tripStory/presentation/login/binding/profile_add_binding.dart';
import 'package:tripStory/presentation/login/binding/term_binding.dart';
import 'package:tripStory/presentation/login/views/login_view.dart';
import 'package:tripStory/presentation/login/views/profile_add_view.dart';
import 'package:tripStory/presentation/login/views/register_success_view.dart';
import 'package:tripStory/presentation/login/views/term_view.dart';
import 'package:tripStory/presentation/setting/bindings/alim_setting_binding.dart';
import 'package:tripStory/presentation/setting/bindings/edit_profile_binding.dart';
import 'package:tripStory/presentation/setting/bindings/my_page_binding.dart';
import 'package:tripStory/presentation/setting/bindings/my_page_setting_binding.dart';
import 'package:tripStory/presentation/setting/bindings/notices_list_binding.dart';
import 'package:tripStory/presentation/setting/bindings/user_delete_binding.dart';
import 'package:tripStory/presentation/setting/views/alim_setting_view.dart';
import 'package:tripStory/presentation/setting/views/edit_profile_view.dart';
import 'package:tripStory/presentation/setting/views/my_page_setting_view.dart';
import 'package:tripStory/presentation/setting/views/my_page_view.dart';
import 'package:tripStory/presentation/setting/views/notices_list_view.dart';
import 'package:tripStory/presentation/setting/views/user_delete_view.dart';
import 'package:tripStory/presentation/splash/binding/splash_binding.dart';
import 'package:tripStory/presentation/splash/views/splash_view.dart';
import 'package:tripStory/presentation/trip/bindings/flight_create_binding.dart';
import 'package:tripStory/presentation/trip/bindings/flight_search_binding.dart';
import 'package:tripStory/presentation/trip/bindings/j_plan_add_binding.dart';
import 'package:tripStory/presentation/trip/bindings/j_plan_binding.dart';
import 'package:tripStory/presentation/trip/bindings/j_plan_edit_binding.dart';
import 'package:tripStory/presentation/trip/bindings/j_plan_swap_binding.dart';
import 'package:tripStory/presentation/trip/bindings/location_search_binding.dart';
import 'package:tripStory/presentation/trip/bindings/scrap_create_binding.dart';
import 'package:tripStory/presentation/trip/bindings/scraps_binding.dart';
import 'package:tripStory/presentation/trip/bindings/trip_main_binding.dart';
import 'package:tripStory/presentation/trip/bindings/trip_room_member_binding.dart';
import 'package:tripStory/presentation/trip/bindings/trip_room_setting_binding.dart';
import 'package:tripStory/presentation/trip/locker/scrap/addScrapPage.dart';
import 'package:tripStory/presentation/trip/models/flight_create_param.dart';
import 'package:tripStory/presentation/trip/models/j_plan_edit_param.dart';
import 'package:tripStory/presentation/trip/models/j_plan_swap_param.dart';
import 'package:tripStory/presentation/trip/views/flight_create_view.dart';
import 'package:tripStory/presentation/trip/views/flight_search_view.dart';
import 'package:tripStory/presentation/trip/views/j_plan_create_view.dart';
import 'package:tripStory/presentation/trip/views/j_plan_edit_view.dart';
import 'package:tripStory/presentation/trip/views/j_plan_swap_view.dart';
import 'package:tripStory/presentation/trip/views/location_search_view.dart';
import 'package:tripStory/presentation/trip/views/trip_main_view.dart';
import 'package:tripStory/presentation/trip/views/trip_room_member_view.dart';
import 'package:tripStory/presentation/trip/views/trip_room_setting_view.dart';

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
      name: Routes.alimSetting,
      page: () => const AlimSettingView(),
      binding: AlimSettingBinding(),
    ),
    GetPage(
      name: Routes.notice,
      page: () => const NoticesListView(),
      binding: NoticesListBinding(),
    ),
    GetPage(
      name: Routes.userDelete,
      page: () => const UserDeleteView(),
      binding: UserDeleteBinding(),
    ),
    GetPage(
      name: Routes.userEditProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
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
    GetPage(
      name: Routes.tripRoom,
      page: () {
        final tripId = Get.arguments;

        if (tripId is! int) {
          throw ArgumentError('error');
        }
        return TripMainView(
          tripId: tripId,
        );
      },
      bindings: [
        TripMainBinding(),
        JPlanBinding(),
        ScrapsBinding(),
      ],
    ),
    GetPage(
      name: Routes.scrapCreate,
      page: () => const AddScrapPage(),
      binding: ScrapCreateBinding(),
    ),
    GetPage(
      name: Routes.tripJPlanAdd,
      page: () {
        final selectedDate = Get.arguments;

        if (selectedDate is! DateTime) {
          throw ArgumentError('error');
        }
        return JPlanCreateView(selectedDate: selectedDate);
      },
      binding: JPlanAddBinding(),
    ),
    GetPage(
      name: Routes.locationSearch,
      page: () => const LocationSearchView(),
      binding: LocationSearchBinding(),
    ),
    GetPage(
      name: Routes.tripJPlanEdit,
      page: () {
        final args = Get.arguments;
        if (args is! JPlanEditParams) {
          throw ArgumentError('error');
        }
        return JPlanEditView(params: args);
      },
      binding: JPlanEditBinding(),
    ),
    GetPage(
      name: Routes.tripJPlanSwap,
      page: () {
        final args = Get.arguments;
        if (args is! List<JPlanSwapParam>) {
          throw ArgumentError('error');
        }
        return JPlanSwapView(plans: args);
      },
      binding: JPlanSwapBinding(),
    ),
    GetPage(
      name: Routes.searchFlight,
      page: () => const FlightSearchView(),
      binding: FlightSearchBinding(),
    ),
    GetPage(
      name: Routes.createFlight,
      page: () {
        final args = Get.arguments;
        if (args is! FlightCreateParam) {
          throw ArgumentError('error');
        }
        return FlightCreateView(param: args);
      },
      binding: FlightCreateBinding(),
    ),
    GetPage(
      name: Routes.tripRoomSetting,
      page: () => const TripRoomSettingView(),
      binding: TripRoomSettingBinding(),
    ),
    GetPage(
      name: Routes.tripRoomMember,
      page: () => const TripRoomMemberView(),
      binding: TripRoomMemberBinding(),
    ),
  ];
}
