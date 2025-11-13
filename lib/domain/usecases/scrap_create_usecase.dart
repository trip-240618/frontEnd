import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/scrap_create_entity.dart';
import 'package:tripStory/domain/entities/scrap_detail_entity.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class ScrapCreateUseCase implements UseCase<ScrapDetailEntity, Tuple2<int, ScrapCreateEntity>> {
  final TripRepository _tripRepository;

  ScrapCreateUseCase(this._tripRepository);

  @override
  ResultFuture<ScrapDetailEntity> call(Tuple2<int, ScrapCreateEntity> params) async {
    final tripId = params.value1;
    final entity = params.value2;

    return _tripRepository.createScrap(
      tripId: tripId,
      scrapCreateEntity: entity,
    );
  }
}
