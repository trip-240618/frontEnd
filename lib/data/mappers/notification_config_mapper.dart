import 'package:tripStory/data/models/response/notification_config_response.dart';
import 'package:tripStory/domain/entities/notification_config_entity.dart';

class NotificationConfigMapper {
  static NotificationConfigEntity toEntity(NotificationConfigResponse response) {
    return NotificationConfigEntity(
      activePlan: response.activePlan,
      activeLikeReply: response.activeLikeReply,
      activeMarketing: response.activeMarketing,
    );
  }
}
