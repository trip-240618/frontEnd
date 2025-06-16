import 'package:get/get.dart';
import 'package:tripStory/view/hoom/controller/notification_list_controller.dart';

class NotificationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationListController>(() => NotificationListController());
  }
}
