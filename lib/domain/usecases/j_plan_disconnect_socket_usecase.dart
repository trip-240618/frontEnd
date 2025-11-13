import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';

class JPlanDisconnectSocketUsecase implements UseCase<void, NoParams> {
  final JSocketRepository repository;

  JPlanDisconnectSocketUsecase(this.repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    return await repository.disconnect();
  }
}
