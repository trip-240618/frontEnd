import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/auth_repository.dart';

class LoginWithKakaoUseCase {
  final AuthRepository repository;

  LoginWithKakaoUseCase(this.repository);

  ResultFuture<UserEntity> call({
    required String kakaoToken,
    required String fcmToken,
  }) {
    return repository.loginWithKakao(
      kakaoToken: kakaoToken,
      fcmToken: fcmToken,
    );
  }
}
