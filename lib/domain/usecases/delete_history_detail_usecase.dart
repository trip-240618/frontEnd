import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class DeleteHistoryDetailParams {
  final int tripId;
  final int historyId;

  const DeleteHistoryDetailParams({
    required this.tripId,
    required this.historyId,
  });
}

class DeleteHistoryDetailUsecase implements UseCase<void, DeleteHistoryDetailParams> {
  final TripRepository _repository;

  DeleteHistoryDetailUsecase(this._repository);

  @override
  ResultFuture<void> call(DeleteHistoryDetailParams params) async {
    return await _repository.deleteHistory(
      tripId: params.tripId,
      historyId: params.historyId,
    );
  }
}
