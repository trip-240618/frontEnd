import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/flight_entity.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';

class FetchFlightUsecase implements UseCase<FlightEntity?, int> {
  final FlightRepository repository;

  const FetchFlightUsecase(this.repository);

  @override
  ResultFuture<FlightEntity?> call(int tripId) async {
    final either = await repository.fetchFlight(tripId);
    return either.fold(
      (failure) => Left(failure),
      (flights) => Right(flights.isEmpty ? null : flights.first),
    );
  }
}
