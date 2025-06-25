import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/services/user_service.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/usecases/fetch_visited_country_usecase.dart';
import 'package:tripStory/util/helper/country_flag_helper.dart';
import 'package:tripStory/view/myPage/editProfilePage.dart';
import 'package:tripStory/view/setting/models/my_page_state.dart';

class MyPageController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchVisitedCountryUsecase _fetchVisitedCountryUsecase;
  final UserService _userService;

  MyPageController(
    this._userService,
    this._fetchVisitedCountryUsecase,
  );

  UserEntity? get user => _userService.user;

  MyPageState myPageState = MyPageState();

  MyPageState get state => myPageState;

  Future<void> getVisitedCountry(
    BuildContext context,
  ) async {
    final result = await _fetchVisitedCountryUsecase(NoParams());

    await result.fold((error) {}, (countries) async {
      myPageState = state.copyWith(
        visitedCountryItems: countries,
      );

      for (final country in countries) {
        await CountryFlagHelper.cacheImage(
          country.imageUrl ?? "",
          context,
        );
      }
      update();
    });
  }

  void onProfilePressed() => Get.to(() => EditProfilePage());
}
