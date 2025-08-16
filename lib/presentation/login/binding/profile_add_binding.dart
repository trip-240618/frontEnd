import 'package:get/get.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/domain/usecases/register_user_usecase.dart';
import 'package:tripStory/presentation/login/controller/profile_add_controller.dart';

class ProfileAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterUserUsecase(Get.find()));
    Get.lazyPut(() => FetchPresignedUrlUsecase(Get.find()));

    Get.lazyPut(() => ProfileAddController(
          Get.find<FetchPresignedUrlUsecase>(),
          Get.find<RegisterUserUsecase>(),
        ));
  }
}
