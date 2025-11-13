import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';
import 'package:tripStory/presentation/hoom/enum/notification_type.dart';

part 'notification_list_state.freezed.dart';

@freezed
abstract class NotificationListState with _$NotificationListState {
  const NotificationListState._();

  const factory NotificationListState({
    @Default([]) List<NotificationsEntity> notificationItems,
    @Default(NotificationType.all) NotificationType notificationType,
  }) = _NotificationListState;
}
