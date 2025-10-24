import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class HistoryHeartToggleParams {
  final int tripId;
  final int historyId;

  const HistoryHeartToggleParams({
    required this.tripId,
    required this.historyId,
  });
}

class HistoryHeartToggleUsecase implements UseCase<bool, HistoryHeartToggleParams> {
  final TripRepository _tripRepository;

  HistoryHeartToggleUsecase(
    this._tripRepository,
  );

  @override
  ResultFuture<bool> call(HistoryHeartToggleParams params) async {
    return await _tripRepository.putHistoryToggle(
      tripId: params.tripId,
      historyId: params.historyId,
    );
  }
}
