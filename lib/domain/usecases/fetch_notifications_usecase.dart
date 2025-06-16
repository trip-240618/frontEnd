import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';

class FetchNotificationsUsecase implements UseCase<List<NotificationsEntity>, Tuple2<int, String?>> {
  final NotificationRepository repository;

  FetchNotificationsUsecase(this.repository);

  @override
  ResultFuture<List<NotificationsEntity>> call(Tuple2<int, String?> params) {
    final userId = params.value1;
    final title = params.value2;

    return repository.fetchNotifications(
      id: userId,
      title: (title?.trim().isEmpty ?? true) ? null : title,
    );
  }
}
