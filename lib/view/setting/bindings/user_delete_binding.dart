import 'package:get/get.dart';
import 'package:tripStory/core/services/session_service.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';
import 'package:tripStory/domain/usecases/delete_user_usecase.dart';
import 'package:tripStory/view/setting/controllers/user_delete_controller.dart';

class UserDeleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeleteUserUsecase(Get.find<UserRepository>()));
    Get.lazyPut<UserDeleteController>(
      () => UserDeleteController(
        Get.find<DeleteUserUsecase>(),
        Get.find<SessionService>(),
      ),
    );
  }
}
