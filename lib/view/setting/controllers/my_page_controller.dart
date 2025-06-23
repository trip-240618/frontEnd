import 'package:get/get.dart';
import 'package:tripStory/app/services/user_service.dart';
import 'package:tripStory/domain/entities/user_entity.dart';

class MyPageController extends GetxController with GetSingleTickerProviderStateMixin {
  final UserService _userService;

  MyPageController(this._userService);

  UserEntity? get user => _userService.user;

  @override
  void onInit() {
    print("??? ${user}");
    super.onInit();
  }
}
