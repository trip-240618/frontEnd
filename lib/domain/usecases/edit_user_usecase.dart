import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/user_modify_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class EditUserUsecase implements UseCase<UserEntity, UserModifyRequest> {
  final UserRepository repository;

  EditUserUsecase(this.repository);

  @override
  ResultFuture<UserEntity> call(UserModifyRequest request) async {
    return await repository.putUserModify(request);
  }
}
