import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class JPlanSwapRegisterUsecase implements UseCase<void, Tuple2<int, int>> {
  final TripRepository repository;

  JPlanSwapRegisterUsecase(this.repository);

  @override
  ResultFuture<void> call(Tuple2<int, int> params) async {
    final int tripId = params.value1;
    final int day = params.value2;

    return await repository.fetchRegisterJPlan(
      tripId: tripId,
      day: day,
    );
  }
}
