import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/flight_repository.dart';

class DeleteFlightUsecase implements UseCase<void, Tuple2<int, int>> {
  final FlightRepository repository;

  DeleteFlightUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple2<int, int> params) async {
    return repository.deleteFlight(
      params.value1,
      params.value2,
    );
  }
}
