import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';
import 'package:tripStory/domain/usecases/fetch_notification_config_usecase.dart';
import 'package:tripStory/domain/usecases/update_notification_config_usecase.dart';
import 'package:tripStory/view/setting/controllers/alim_setting_controller.dart';

class AlimSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchNotificationConfigUsecase(Get.find<NotificationRepository>()));
    Get.lazyPut(() => UpdateNotificationConfigUsecase(Get.find<NotificationRepository>()));
    Get.lazyPut<AlimSettingController>(() => AlimSettingController(
          Get.find<FetchNotificationConfigUsecase>(),
          Get.find<UpdateNotificationConfigUsecase>(),
        ));
  }
}
