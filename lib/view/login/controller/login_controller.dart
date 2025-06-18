import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/app/services/user_service.dart';
import 'package:tripStory/common/enum/user_type.dart';
import 'package:tripStory/domain/usecases/login_kakao_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/login/register/term.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  final LoginWithKakaoUseCase kakaoUseCase;
  final UserService userService;

  LoginController(
    this.kakaoUseCase,
    this.userService,
  );

  Future<void> onKakaoPressed() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final isInstalled = await isKakaoTalkInstalled();
    final oauthToken =
        isInstalled ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();

    final result = await kakaoUseCase.call(
      kakaoToken: oauthToken.accessToken,
      fcmToken: fcmToken ?? "",
    );

    result.fold(
      (failure) {},
      (user) async {
        userService.setUser(user);
        await ensureUserInfoWithConsent();

        switch (user.type) {
          case UserType.register:
            Get.to(() => TermPage());
            break;
          case UserType.login:
            Get.offAllNamed(Routes.rooms);
            break;
        }
      },
    );
  }

  Future<User?> ensureUserInfoWithConsent() async {
    try {
      User user = await UserApi.instance.me();

      final scopes = <String>[
        if (user.kakaoAccount?.emailNeedsAgreement == true) "account_email",
        if (user.kakaoAccount?.birthdayNeedsAgreement == true) "birthday",
        if (user.kakaoAccount?.birthyearNeedsAgreement == true) "birthyear",
        if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) "phone_number",
        if (user.kakaoAccount?.profileNeedsAgreement == true) "profile",
        if (user.kakaoAccount?.ageRangeNeedsAgreement == true) "age_range",
      ];

      if (scopes.isNotEmpty) {
        await UserApi.instance.loginWithNewScopes(scopes);
        user = await UserApi.instance.me();
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> onGooglePressed() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final isInstalled = await isKakaoTalkInstalled();
    final oauthToken =
        isInstalled ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();

    final result = await kakaoUseCase.call(
      kakaoToken: oauthToken.accessToken,
      fcmToken: fcmToken ?? "",
    );

    result.fold(
      (failure) {},
      (user) async {
        userService.setUser(user);
        await ensureUserInfoWithConsent();

        switch (user.type) {
          case UserType.register:
            Get.to(() => TermPage());
            break;
          case UserType.login:
            Get.offAllNamed(Routes.rooms);
            break;
        }
      },
    );
  }
}
