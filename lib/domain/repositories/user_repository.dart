import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

abstract class UserRepository {
  ResultFuture<UserEntity> putUserRegister({
    required String nickname,
    String? thumbnail,
    String? profileImg,
    required bool isMarketing,
  });

  ResultFuture<UserEntity> fetchUserInfo();

  ResultFuture<void> deleteUser();

  ResultFuture<UserEntity> putUserModify({
    required String nickname,
    required String memo,
    String? thumbnail,
    String? profileImg,
  });

  ResultFuture<void> updateFcmToken({
    required String fcmToken,
  });
}
