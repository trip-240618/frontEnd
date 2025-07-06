import 'package:tripStory/core/enum/user_type.dart';
import 'package:tripStory/data/models/user_response.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity toEntity(UserResponse response) {
    return UserEntity(
      uuid: response.uuid,
      name: response.name,
      nickName: response.nickName,
      memo: response.memo,
      thumbnail: response.thumbnail,
      profileImg: response.profileImg,
      type: UserType.fromString(response.type),
      createDate: DateTime.parse(response.createDate),
    );
  }
}
