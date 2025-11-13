import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/notification_config_modify_request.dart';
import 'package:tripStory/domain/entities/notification_config_entity.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';

abstract class NotificationRepository {
  ResultFuture<List<NotificationsEntity>> fetchNotifications({
    required int id,
    String? title,
  });

  ResultFuture<NotificationConfigEntity> fetchNotificationConfig();

  ResultFuture<NotificationConfigEntity> putNotificationConfig(
    NotificationConfigModifyRequest request,
  );
}
