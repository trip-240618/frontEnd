import 'package:get/get.dart';
import 'package:tripStory/core/services/notification_service.dart';
import 'package:tripStory/domain/repositories/token_repository.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';
import 'package:tripStory/domain/repositories/version_repository.dart';
import 'package:tripStory/domain/usecases/auto_login_usecase.dart';
import 'package:tripStory/domain/usecases/check_app_version_usecase.dart';
import 'package:tripStory/domain/usecases/skip_app_update_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AutoLoginUsecase(Get.find<UserRepository>()));
    Get.lazyPut(() => CheckAppVersionUsecase(Get.find<VersionRepository>(), Get.find<TokenRepository>()));
    Get.lazyPut(() => SkipAppUpdateUsecase(Get.find<TokenRepository>()));
    Get.put(
      SplashController(Get.find<AutoLoginUsecase>(), Get.find<CheckAppVersionUsecase>(),
          Get.find<SkipAppUpdateUsecase>(), Get.find<LoginUserService>(), Get.find<NotificationService>()),
    );
  }
}
