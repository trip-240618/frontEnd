import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/history_reply_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchReplyParams {
  final int tripId;
  final int historyId;

  const FetchReplyParams({
    required this.tripId,
    required this.historyId,
  });
}

class FetchReplyUsecase implements UseCase<List<HistoryReplyEntity>, FetchReplyParams> {
  final TripRepository _tripRepository;

  FetchReplyUsecase(
    this._tripRepository,
  );

  @override
  ResultFuture<List<HistoryReplyEntity>> call(FetchReplyParams params) async {
    return await _tripRepository.fetchReplies(
      tripId: params.tripId,
      historyId: params.historyId,
    );
  }
}
