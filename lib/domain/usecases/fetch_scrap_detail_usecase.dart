import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class FetchScrapDetailUseCase implements UseCase<ScrapDetailEntity, Tuple2<int, int>> {
  final TripRepository _repository;

  FetchScrapDetailUseCase(this._repository);

  @override
  ResultFuture<ScrapDetailEntity> call(Tuple2<int, int> params) {
    final tripId = params.value1;
    final scrapId = params.value2;

    return _repository.fetchScrapDetail(tripId: tripId, scrapId: scrapId);
  }
}
