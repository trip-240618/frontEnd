import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/user_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/auth_repository.dart';

class LoginGoogleUsecase implements UseCase<UserEntity, UserRequest> {
  final AuthRepository repository;

  LoginGoogleUsecase(this.repository);

  @override
  ResultFuture<UserEntity> call(UserRequest body) async {
    return await repository.loginWithGoogle(body);
  }
}
