import 'package:dartz/dartz.dart';
import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class ToggleScrapBookmarkUseCase implements UseCase<bool, Tuple2<int, int>> {
  final TripRepository _repository;

  ToggleScrapBookmarkUseCase(this._repository);

  @override
  ResultFuture<bool> call(Tuple2<int, int> params) async {
    final tripId = params.value1;
    final scrapId = params.value2;
    return _repository.toggleScrapBookmark(tripId: tripId, scrapId: scrapId);
  }
}
