import 'package:get/get.dart';
import 'package:tripStory/app/services/user_service.dart';
import 'package:tripStory/domain/usecases/login_google_usecase.dart';
import 'package:tripStory/domain/usecases/login_kakao_usecase.dart';
import 'package:tripStory/view/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginWithKakaoUseCase(Get.find()));
    Get.lazyPut(() => LoginGoogleUsecase(Get.find()));

    Get.lazyPut(() => LoginController(
          Get.find<LoginWithKakaoUseCase>(),
          Get.find<LoginGoogleUsecase>(),
          Get.find<UserService>(),
        ));
  }
}
