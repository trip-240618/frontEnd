import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/notification_config_modify_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/notification_config_entity.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';

class UpdateNotificationConfigUsecase implements UseCase<NotificationConfigEntity, NotificationConfigModifyRequest> {
  final NotificationRepository repository;

  UpdateNotificationConfigUsecase(this.repository);

  @override
  ResultFuture<NotificationConfigEntity> call(NotificationConfigModifyRequest body) {
    return repository.putNotificationConfig(body);
  }
}
