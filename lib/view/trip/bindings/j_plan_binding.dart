import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_j_plan_usecase.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';

class JPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchJPlanUsecase(Get.find<TripRepository>()));
    Get.lazyPut<JPlanController>(
      () => JPlanController(
        Get.find<JSocketRepository>(),
        Get.find<TripRoomService>(),
        Get.find<FetchJPlanUsecase>(),
      ),
    );
  }
}
