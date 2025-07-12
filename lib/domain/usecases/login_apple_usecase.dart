import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/apple_login_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/auth_repository.dart';

class LoginAppleUsecase implements UseCase<UserEntity, AppleLoginRequest> {
  final AuthRepository repository;

  LoginAppleUsecase(this.repository);

  @override
  ResultFuture<UserEntity> call(AppleLoginRequest body) async {
    return await repository.loginWithApple(body);
  }
}
