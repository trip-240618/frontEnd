import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:tripStory/app/notification/local_notification_setting.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:tripStory/core/enum/app_update_type.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/usecases/auto_login_usecase.dart';
import 'package:tripStory/domain/usecases/check_app_version_usecase.dart';
import 'package:tripStory/domain/usecases/skip_app_update_usecase.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';

class SplashController extends GetxController {
  bool _isJailBroken = false;
  final AutoLoginUsecase autoLoginUseCase;
  final CheckAppVersionUsecase _checkAppVersionUsecase;
  final SkipAppUpdateUsecase _skipAppUpdateUsecase;
  final LoginUserService userService;

  SplashController(
    this.autoLoginUseCase,
    this._checkAppVersionUsecase,
    this._skipAppUpdateUsecase,
    this.userService,
  );

  @override
  void onInit() {
    super.onInit();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await _checkJailbreak();
    if (_isJailBroken) return;

    final continueApp = await _checkVersion();
    if (!continueApp) return;

    _navigateNext();
  }

  Future<bool> _checkVersion() async {
    final result = await _checkAppVersionUsecase.call(NoParams());
    return result.fold(
      (_) => true,
      (status) async {
        switch (status) {
          case AppUpdateType.forceUpdate:
            FlutterNativeSplash.remove();
            CommonDialog.showConfirm(
              title: "업데이트 필요",
              message: "최신 버전으로 업데이트해야 앱을 사용할 수 있습니다.",
              confirmText: "업데이트",
              barrierDismissible: false,
              onConfirm: () => StoreRedirect.redirect(
                androidAppId: "",
                iOSAppId: AppConstants.appId,
              ),
            );
            return false;

          case AppUpdateType.optionalUpdate:
            FlutterNativeSplash.remove();
            await CommonDialog.showConfirmCancel(
              title: "새로운 버전이 출시되었습니다",
              message: "지금 업데이트하시겠습니까?",
              confirmText: "업데이트",
              barrierDismissible: false,
              onConfirm: () => StoreRedirect.redirect(
                androidAppId: "",
                iOSAppId: AppConstants.appId,
              ),
              cancelText: "나중에",
              onCancel: () async {
                await _skipAppUpdateUsecase.call(NoParams());
                _navigateNext();
              },
            );
            return false;
          case AppUpdateType.upToDate:
          case AppUpdateType.unknown:
            return true;
        }
      },
    );
  }

  Future<void> _checkPermissions() async {
    requestNotificationPermissions();
    await LocalNotifyCation().initializeNotification();
  }

  Future<void> _checkJailbreak() async {
    _isJailBroken = await FlutterJailbreakDetection.jailbroken;
  }

  Future<void> _getUserInfo() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    final result = await autoLoginUseCase.call(fcmToken ?? "");
    result.fold((error) {
      userService.clearUser();
    }, (user) {
      userService.setUser(user);
    });
  }

  Future<void> _navigateNext() async {
    await _checkPermissions();
    await _getUserInfo();
    FlutterNativeSplash.remove();
    if (_isJailBroken) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      return;
    } else if (userService.isLoggedIn) {
      Get.offAllNamed(Routes.rooms);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
