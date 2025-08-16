import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/notification/local_notification_setting.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/usecases/auto_login_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';

class SplashController extends GetxController {
  bool _isJailBroken = false;
  final AutoLoginUsecase autoLoginUseCase;
  final LoginUserService userService;

  SplashController(
    this.autoLoginUseCase,
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

    await Future.wait([
      _checkVersion(),
      _checkPermissions(),
      _getUserInfo(),
    ]);

    _navigateNext();
  }

  Future<void> _checkVersion() async {
    // await us.versionCheck(context);
  }

  Future<void> _checkPermissions() async {
    requestNotificationPermissions();
    await LocalNotifyCation().initializeNotification();
  }

  Future<void> _checkJailbreak() async {
    _isJailBroken = await FlutterJailbreakDetection.jailbroken;
  }

  Future<void> _getUserInfo() async {
    final result = await autoLoginUseCase.call(NoParams());
    result.fold((error) {
      userService.clearUser();
    }, (user) {
      userService.setUser(user);
    });
  }

  Future<void> _navigateNext() async {
    FlutterNativeSplash.remove();
    if (_isJailBroken) {
      Get.offAll(() => DialogExample());
    } else if (userService.isLoggedIn) {
      Get.offAllNamed(Routes.rooms);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
