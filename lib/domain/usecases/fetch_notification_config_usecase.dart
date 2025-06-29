import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/notification_config_entity.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';

class FetchNotificationConfigUsecase implements UseCase<NotificationConfigEntity, NoParams> {
  final NotificationRepository repository;

  FetchNotificationConfigUsecase(this.repository);

  @override
  ResultFuture<NotificationConfigEntity> call(NoParams params) {
    return repository.fetchNotificationConfig();
  }
}
