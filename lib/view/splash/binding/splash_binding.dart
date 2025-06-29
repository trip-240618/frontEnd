import 'package:get/get.dart';
import 'package:tripStory/app/services/login_user_service.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';
import 'package:tripStory/domain/usecases/auto_login_usecase.dart';
import 'package:tripStory/view/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AutoLoginUsecase(Get.find<UserRepository>()));
    Get.put(SplashController(
      Get.find<AutoLoginUsecase>(),
      Get.find<LoginUserService>(),
    ));
  }
}
