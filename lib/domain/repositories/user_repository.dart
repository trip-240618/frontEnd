import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/request/register_request.dart';
import 'package:tripStory/data/models/request/user_modify_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

abstract class UserRepository {
  ResultFuture<UserEntity> putUserRegister(
    RegisterRequest request,
  );

  ResultFuture<UserEntity> fetchUserInfo();

  ResultFuture<void> deleteUser();

  ResultFuture<UserEntity> putUserModify(
    UserModifyRequest request,
  );
}
