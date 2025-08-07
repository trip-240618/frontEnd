import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';

class JPlanConnectSocketUsecase implements UseCase<void, int> {
  final JSocketRepository repository;

  JPlanConnectSocketUsecase(this.repository);

  @override
  ResultFuture<void> call(int tripId) async {
    return await repository.connectToTrip(tripId);
  }
}
