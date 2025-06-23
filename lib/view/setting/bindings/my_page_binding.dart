import 'package:get/get.dart';
import 'package:tripStory/app/services/user_service.dart';
import 'package:tripStory/view/setting/controllers/my_page_controller.dart';

class MyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageController>(() => MyPageController(Get.find<UserService>()));
  }
}
