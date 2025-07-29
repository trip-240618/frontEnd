import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_j_plan_usecase.dart';
import 'package:tripStory/view/trip/controllers/j_plan_edit_controller.dart';
import 'package:tripStory/view/trip/controllers/j_plan_editor_controller.dart';

class JPlanEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut<JPlanEditorController>(() => JPlanEditorController(
          Get.find<TripRoomService>(),
        ));
    Get.lazyPut<JPlanEditController>(
      () => JPlanEditController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
