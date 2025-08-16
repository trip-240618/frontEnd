import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_j_plan_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/j_plan_create_controller.dart';
import 'package:tripStory/presentation/trip/controllers/j_plan_editor_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class JPlanAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut<JPlanEditorController>(() => JPlanEditorController(
          Get.find<TripRoomService>(),
        ));
    Get.lazyPut<JPlanCreateController>(
      () => JPlanCreateController(
        Get.find<TripRoomService>(),
        Get.find<CreateJPlanUsecase>(),
      ),
    );
  }
}
