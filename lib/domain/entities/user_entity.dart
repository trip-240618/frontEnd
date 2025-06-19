import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/common/enum/user_type.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String uuid,
    required String name,
    String? nickName,
    String? memo,
    String? thumbnail,
    String? profileImg,
    required UserType type,
    required DateTime createDate,
  }) = _UserEntity;
}
