import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class ReplyModifyParams {
  final int tripId;
  final int historyId;
  final int replyId;
  final String content;

  const ReplyModifyParams({
    required this.tripId,
    required this.historyId,
    required this.replyId,
    required this.content,
  });
}

class ReplyModifyUsecase implements UseCase<List<HistoryReplyEntity>, ReplyModifyParams> {
  final TripRepository _tripRepository;

  ReplyModifyUsecase(
    this._tripRepository,
  );

  @override
  ResultFuture<List<HistoryReplyEntity>> call(ReplyModifyParams params) async {
    return await _tripRepository.modifyReply(
      tripId: params.tripId,
      historyId: params.historyId,
      content: params.content,
      replyId: params.replyId,
    );
  }
}
