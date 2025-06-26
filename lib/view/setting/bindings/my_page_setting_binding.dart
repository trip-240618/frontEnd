import 'package:get/get.dart';
import 'package:tripStory/view/setting/controllers/my_page_setting_controller.dart';

class MyPageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageSettingController>(() => MyPageSettingController());
  }
}
