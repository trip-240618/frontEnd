import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/common/enum/user_type.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String uuid,
    required String name,
    required String nickName,
    required String memo,
    required String thumbnail,
    required String profileImg,
    required UserType type,
    required DateTime createDate,
  }) = _UserEntity;
}
