import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/core/services/notification_service.dart';
import 'package:tripStory/domain/base/usecase.dart';

class NotificationListenUsecase implements UseCase<Stream<Map<String, dynamic>>, NoParams> {
  final NotificationService _notificationService;

  NotificationListenUsecase(this._notificationService);

  @override
  ResultFuture<Stream<Map<String, dynamic>>> call(NoParams params) async {
    try {
      final stream = _notificationService.notificationStream;
      return Right(stream);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
