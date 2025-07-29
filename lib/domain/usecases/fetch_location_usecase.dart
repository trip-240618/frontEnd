import 'package:dartz/dartz.dart';
import 'package:tripStory/core/errors/failure.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/domain/repositories/location_repository.dart';

class FetchLocationUsecase implements UseCase<LocationEntity, String> {
  final LocationRepository repository;

  FetchLocationUsecase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(String placeId) async {
    return await repository.fetchPlaceDetail(placeId);
  }
}
