import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tripStory/core/enum/user_type.dart';
import 'package:tripStory/core/services/login_user_service.dart';
import 'package:tripStory/data/models/request/apple_login_request.dart';
import 'package:tripStory/data/models/request/user_request.dart';
import 'package:tripStory/domain/usecases/login_apple_usecase.dart';
import 'package:tripStory/domain/usecases/login_google_usecase.dart';
import 'package:tripStory/domain/usecases/login_kakao_usecase.dart';
import 'package:tripStory/router/routes.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final LoginWithKakaoUseCase kakaoUseCase;
  final LoginGoogleUsecase googleUsecase;
  final LoginAppleUsecase appleUsecase;
  final LoginUserService userService;

  LoginController(
    this.kakaoUseCase,
    this.googleUsecase,
    this.appleUsecase,
    this.userService,
  );

  Future<void> onKakaoPressed() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final isInstalled = await isKakaoTalkInstalled();
    final oauthToken = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final result = await kakaoUseCase.call(
      kakaoToken: oauthToken.accessToken,
      fcmToken: fcmToken ?? "",
    );
    print('????');
    result.fold(
      (failure) {
        print('????222${failure.message}');
      },
      (user) async {
        print('????222');
        userService.setUser(user);
        await ensureUserInfoWithConsent();
        _handleUserType(user.type);
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
        if (user.kakaoAccount?.phoneNumberNeedsAgreement == true)
          "phone_number",
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
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    // String? tokens = await FirebaseMessaging.instance.getToken();
    String? tokens = "";

    final userRequest = UserRequest(
      displayName: googleUser.displayName ?? "",
      email: googleUser.email,
      id: googleUser.id,
      photoUrl: googleUser.photoUrl ?? "",
      fcmToken: tokens,
    );

    final result = await googleUsecase.call(userRequest);

    result.fold(
      (failure) {},
      (user) async {
        userService.setUser(user);
        _handleUserType(user.type);
      },
    );
  }

  Future<void> onApplePressed() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    final appleUser = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);
    final userRequest = AppleLoginRequest(
      identityToken: appleUser.identityToken ?? "",
      state: appleUser.state ?? "",
      userIdentifier: appleUser.userIdentifier ?? "",
      fcmToken: fcmToken,
    );

    final result = await appleUsecase.call(userRequest);

    result.fold(
      (failure) {},
      (user) async {
        userService.setUser(user);
        _handleUserType(user.type);
      },
    );
  }

  void _handleUserType(UserType type) {
    switch (type) {
      case UserType.register:
        Get.toNamed(Routes.term);
        break;
      case UserType.login:
        Get.offAllNamed(Routes.rooms);
        break;
    }
  }
}
