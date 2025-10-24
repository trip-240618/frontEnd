import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class ReportHistoryUsecase implements UseCase<void, int> {
  final TripRepository _repository;

  ReportHistoryUsecase(this._repository);

  @override
  ResultFuture<void> call(int tripId) async {
    return await _repository.reportHistory(
      tripId: tripId,
      reason: '',
    );
  }
}
