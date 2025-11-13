import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class DeleteReplyParams {
  final int tripId;
  final int historyId;
  final int replyId;

  const DeleteReplyParams({
    required this.tripId,
    required this.historyId,
    required this.replyId,
  });
}

class DeleteReplyUsecase implements UseCase<List<HistoryReplyEntity>, DeleteReplyParams> {
  final TripRepository _tripRepository;

  DeleteReplyUsecase(
    this._tripRepository,
  );

  @override
  ResultFuture<List<HistoryReplyEntity>> call(DeleteReplyParams params) async {
    return await _tripRepository.deleteReply(
      tripId: params.tripId,
      historyId: params.historyId,
      replyId: params.replyId,
    );
  }
}
