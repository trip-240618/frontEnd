import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/entities/scrap_update_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class UpdateScrapUseCase implements UseCase<ScrapDetailEntity, Tuple2<int, ScrapUpdateEntity>> {
  final TripRepository _repository;

  UpdateScrapUseCase(this._repository);

  @override
  ResultFuture<ScrapDetailEntity> call(Tuple2<int, ScrapUpdateEntity> params) {
    final tripId = params.value1;
    final entity = params.value2;

    return _repository.updateScrap(
      tripId: tripId,
      scrapUpdateEntity: entity,
    );
  }
}
