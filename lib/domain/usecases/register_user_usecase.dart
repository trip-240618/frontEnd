import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/register_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class RegisterUserUsecase implements UseCase<UserEntity, RegisterRequest> {
  final UserRepository repository;

  RegisterUserUsecase(this.repository);

  @override
  ResultFuture<UserEntity> call(RegisterRequest body) async {
    return await repository.putUserRegister(body);
  }
}
