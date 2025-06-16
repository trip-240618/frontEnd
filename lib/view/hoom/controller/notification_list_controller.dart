import 'package:get/get.dart';
import 'package:tripStory/view/hoom/enum/notification_type.dart';
import 'package:tripStory/view/hoom/model/notification_list_state.dart';

class NotificationListController extends GetxController with GetSingleTickerProviderStateMixin {
  NotificationListState notificationListState = NotificationListState();

  NotificationListState get state => notificationListState;

  NotificationListController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onAllPressed() async {
    notificationListState = state.copyWith(
      notificationType: NotificationType.all,
    );
    update();
  }

  Future<void> onTripSchedulePressed() async {
    notificationListState = state.copyWith(
      notificationType: NotificationType.tripSchedule,
    );
    update();
  }

  Future<void> onTripLogPressed() async {
    notificationListState = state.copyWith(
      notificationType: NotificationType.tripLog,
    );
    update();
  }
}
