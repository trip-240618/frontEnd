import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';
import 'package:tripStory/domain/usecases/fetch_notifications_usecase.dart';
import 'package:tripStory/view/hoom/controller/notification_list_controller.dart';

class NotificationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchNotificationsUsecase(Get.find<NotificationRepository>()));
    Get.lazyPut<NotificationListController>(
      () => NotificationListController(Get.find<FetchNotificationsUsecase>()),
    );
  }
}
