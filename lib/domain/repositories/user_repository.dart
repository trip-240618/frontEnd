import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/data/models/register_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

abstract class UserRepository {
  ResultFuture<UserEntity> putUserRegister(
    RegisterRequest request,
  );
}
