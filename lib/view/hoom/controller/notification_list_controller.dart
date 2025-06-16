import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/usecases/fetch_notifications_usecase.dart';
import 'package:tripStory/view/hoom/enum/notification_type.dart';
import 'package:tripStory/view/hoom/model/notification_list_state.dart';

class NotificationListController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchNotificationsUsecase _fetchNotificationsUsecase;
  NotificationListState notificationListState = NotificationListState();

  NotificationListState get state => notificationListState;

  NotificationListController(
    this._fetchNotificationsUsecase,
  );

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onAllPressed() async {
    final result = await _fetchNotificationsUsecase(Tuple2(0, null));
    result.fold((error) {}, (notifications) {
      notificationListState = state.copyWith(
        notificationItems: notifications,
        notificationType: NotificationType.all,
      );
    });
    update();
  }

  Future<void> onTripSchedulePressed() async {
    final result = await _fetchNotificationsUsecase(
      Tuple2(
        0,
        NotificationType.tripSchedule.title,
      ),
    );
    result.fold((error) {}, (notifications) {
      notificationListState = state.copyWith(
        notificationItems: notifications,
        notificationType: NotificationType.tripSchedule,
      );
    });
    update();
  }

  Future<void> onTripLogPressed() async {
    final result = await _fetchNotificationsUsecase(
      Tuple2(
        0,
        NotificationType.tripLog.title,
      ),
    );
    result.fold((error) {}, (notifications) {
      notificationListState = state.copyWith(
        notificationItems: notifications,
        notificationType: NotificationType.tripLog,
      );
    });
    update();
  }
}
