import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class DeleteScrapUseCase implements UseCase<void, Tuple2<int, int>> {
  final TripRepository _repository;

  DeleteScrapUseCase(this._repository);

  @override
  ResultFuture<void> call(Tuple2<int, int> params) {
    final tripId = params.value1;
    final scrapId = params.value2;

    return _repository.deleteScrap(tripId: tripId, scrapId: scrapId);
  }
}
