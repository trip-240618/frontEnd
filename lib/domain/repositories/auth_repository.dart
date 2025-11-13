import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/apple_login_request.dart';
import 'package:tripStory/data/models/request/user_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> loginWithKakao({
    required String kakaoToken,
    required String fcmToken,
  });

  ResultFuture<UserEntity> loginWithGoogle(UserRequest request);

  ResultFuture<UserEntity> loginWithApple(AppleLoginRequest request);
}
