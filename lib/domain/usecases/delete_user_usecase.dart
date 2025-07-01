import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class DeleteUserUsecase implements UseCase<void, NoParams> {
  final UserRepository repository;

  DeleteUserUsecase(this.repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    return await repository.deleteUser();
  }
}
