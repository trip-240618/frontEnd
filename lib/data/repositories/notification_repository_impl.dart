import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/datasources/remote/notification_data_source.dart';
import 'package:tripStory/data/mappers/notifications_mapper.dart';
import 'package:tripStory/domain/entities/notifications_entity.dart';
import 'package:tripStory/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource _notificationDataSource;

  NotificationRepositoryImpl(this._notificationDataSource);

  @override
  ResultFuture<List<NotificationsEntity>> fetchNotifications({
    required int id,
    String? title,
  }) async {
    try {
      final result = await _notificationDataSource.fetchNotifications(
        id,
        title,
      );
      final entities = result.map(NotificationsMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
