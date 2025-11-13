import 'package:get/get.dart';
import 'package:tripStory/core/services/session_service.dart';
import 'package:tripStory/presentation/setting/controllers/my_page_setting_controller.dart';

class MyPageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageSettingController>(
      () => MyPageSettingController(Get.find<SessionService>()),
    );
  }
}
