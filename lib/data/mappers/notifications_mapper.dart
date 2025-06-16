import 'package:tripStory/data/models/notifications_response.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';

class NotificationsMapper {
  static NotificationsEntity toEntity(NotificationsResponse response) {
    return NotificationsEntity(
      id: response.id,
      labelColor: response.labelColor,
      destination: response.destination,
      title: response.title,
      content: response.content,
      createDate: DateTime.parse(response.createDate),
      read: response.read,
    );
  }
}
