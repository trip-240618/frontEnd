import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';

class FetchFlightResultUsecase implements UseCase<FlightEntity, Tuple3<int, String, String>> {
  final FlightRepository repository;

  FetchFlightResultUsecase(this.repository);

  @override
  ResultFuture<FlightEntity> call(Tuple3<int, String, String> params) async {
    return await repository.fetchFlight(
      params.value1,
      params.value2,
      params.value3,
    );
  }
}
