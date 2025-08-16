import 'package:get/get.dart';
import 'package:tripStory/core/enum/user_type.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

class LoginUserService extends GetxService {
  UserEntity? _user;

  UserEntity? get user => _user;

  bool get isLoggedIn => _user != null && _user?.type == UserType.login;

  String get myUuid => _user?.uuid ?? "";

  void setUser(UserEntity user) {
    _user = user;
  }

  void clearUser() {
    _user = null;
  }
}
