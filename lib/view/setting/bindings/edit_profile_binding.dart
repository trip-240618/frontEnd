import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';
import 'package:tripStory/domain/usecases/edit_user_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/setting/controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUserUsecase(Get.find<UserRepository>()));
    Get.lazyPut(() => FetchPresignedUrlUsecase(Get.find()));

    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        Get.find<LoginUserService>(),
        Get.find<EditUserUsecase>(),
        Get.find<FetchPresignedUrlUsecase>(),
      ),
    );
  }
}
