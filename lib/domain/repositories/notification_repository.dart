import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';

abstract class NotificationRepository {
  ResultFuture<List<NotificationsEntity>> fetchNotifications({
    required int id,
    String? title,
  });
}
