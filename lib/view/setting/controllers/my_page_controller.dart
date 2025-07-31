import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/usecases/fetch_visited_country_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/util/one_time_event.dart';
import 'package:tripStory/util/throttle.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/myPage/faq/setting_faq_main.dart';
import 'package:tripStory/view/setting/models/my_page_state.dart';

class MyPageController extends GetxController {
  final FetchVisitedCountryUsecase _fetchVisitedCountryUsecase;
  final LoginUserService _userService;

  MyPageController(
    this._userService,
    this._fetchVisitedCountryUsecase,
  );

  UserEntity? get user => _userService.user;

  MyPageState myPageState = MyPageState();

  MyPageState get state => myPageState;
  final Throttle _throttle = Throttle(delay: Duration(milliseconds: 2000));

  Future<void> getVisitedCountry(
    BuildContext context,
  ) async {
    final result = await _fetchVisitedCountryUsecase(NoParams());

    await result.fold((error) {}, (countries) async {
      myPageState = state.copyWith(
        visitedCountryItems: countries,
      );
      update();
    });
  }

  void onSettingPressed() => Get.toNamed(Routes.myPageSetting);

  void onProfilePressed() => Get.toNamed(Routes.userEditProfile)?.then(
        (value) {
          if (value != null) {
            update();
          }
        },
      );

  void onInvitedLinkPressed() {
    _throttle(() {
      myPageState = state.copyWith(
        showToast: OneTimeEvent(true),
      );
      update();
    });
  }

  void onNoticePressed() => Get.toNamed(Routes.notice);

  void onFaqPressed() => Get.to(() => SettingFaqMain());

  @override
  void onClose() {
    _throttle.cancel();
    super.onClose();
  }
}
