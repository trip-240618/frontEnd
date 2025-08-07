import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/mappers/flight_mapper.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';

class CreateFlightUsecase implements UseCase<void, Tuple2<int, FlightEntity>> {
  final FlightRepository repository;

  CreateFlightUsecase(this.repository);

  @override
  ResultFuture<FlightEntity> call(Tuple2<int, FlightEntity> params) async {
    final tripId = params.value1;
    final entity = params.value2;
    final request = FlightMapper.toRequest(entity);
    return repository.postCreateFlight(
      tripId,
      request,
    );
  }
}
