import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/j_plan_register_finish_usecase.dart';
import 'package:tripStory/domain/usecases/j_plan_swap_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_swap_controller.dart';

class JPlanSwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JPlanSwapUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => JPlanRegisterFinishUsecase(Get.find<TripRepository>()));

    Get.lazyPut<JPlanSwapController>(
      () => JPlanSwapController(
        Get.find<TripRoomService>(),
        Get.find<JPlanSwapUsecase>(),
        Get.find<JPlanRegisterFinishUsecase>(),
      ),
    );
  }
}
