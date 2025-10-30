import 'package:tripStory/core/network/typedefs.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/repositories/user_repository.dart';

class AutoLoginUsecase implements UseCase<UserEntity, String> {
  final UserRepository repository;

  AutoLoginUsecase(this.repository);

  @override
  ResultFuture<UserEntity> call(String fcmToken) async {
    final result = await repository.updateFcmToken(
      fcmToken: fcmToken,
    );
    return await repository.fetchUserInfo();
  }
}
