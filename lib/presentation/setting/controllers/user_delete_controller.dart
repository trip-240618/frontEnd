import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/services/session_service.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/usecases/delete_user_usecase.dart';

class UserDeleteController extends GetxController {
  final DeleteUserUsecase _deleteUserUsecase;
  final SessionService _sessionService;

  UserDeleteController(
    this._deleteUserUsecase,
    this._sessionService,
  );

  Future<void> onUserDeletePressed() async {
    final result = await _deleteUserUsecase.call(NoParams());

    result.fold((error) {}, (success) {
      _sessionService.clearSession();
      Get.offAllNamed(Routes.login);
    });
  }
}
