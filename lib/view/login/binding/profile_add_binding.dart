import 'package:get/get.dart';
import 'package:tripStory/view/login/controller/profile_add_controller.dart';

class ProfileAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileAddController());
  }
}
