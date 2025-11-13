import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class HistoryDetailParams {
  final int tripId;
  final int historyId;

  const HistoryDetailParams({
    required this.tripId,
    required this.historyId,
  });
}

class FetchHistoryDetailUsecase implements UseCase<HistoryEntity, HistoryDetailParams> {
  final TripRepository repository;

  FetchHistoryDetailUsecase(this.repository);

  @override
  ResultFuture<HistoryEntity> call(HistoryDetailParams params) async {
    return await repository.fetchHistoryDetail(
      tripId: params.tripId,
      historyId: params.historyId,
    );
  }
}
