import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/create_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/delete_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_j_plan_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_swap_register_usecase.dart';
import 'package:tripStory/domain/usecases/move_j_plan_locker_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';
import 'package:tripStory/view/trip/controllers/j_plan_create_controller.dart';
import 'package:tripStory/view/trip/controllers/j_plan_editor_controller.dart';

class JPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => DeleteJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => MoveJPlanLockerUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => JPlanSwapRegisterUsecase(Get.find<TripRepository>()));

    Get.lazyPut<JPlanController>(
      () => JPlanController(
        Get.find<JSocketRepository>(),
        Get.find<TripRoomService>(),
        Get.find<FetchJPlanUsecase>(),
        Get.find<DeleteJPlanUsecase>(),
        Get.find<MoveJPlanLockerUsecase>(),
        Get.find<JPlanSwapRegisterUsecase>(),
      ),
      fenix: true,
    );

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
