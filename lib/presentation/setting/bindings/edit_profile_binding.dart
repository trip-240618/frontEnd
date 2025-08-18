import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';
import 'package:tripStory/domain/usecases/edit_user_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/setting/controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUserUsecase(
          Get.find<UserRepository>(),
          Get.find<FileRepository>(),
        ));

    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        Get.find<LoginUserService>(),
        Get.find<EditUserUsecase>(),
      ),
    );
  }
}
