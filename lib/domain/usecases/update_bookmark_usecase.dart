import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';

class UpdateBookmarkUseCase implements UseCase<bool, int> {
  final TripRepository repository;

  UpdateBookmarkUseCase(this.repository);

  @override
  ResultFuture<bool> call(int tripId) async {
    return await repository.updateBookmark(tripId);
  }
}
