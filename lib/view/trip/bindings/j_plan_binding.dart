import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_controller.dart';

class JPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JPlanController>(
      () => JPlanController(Get.find<TripRoomService>()),
    );
  }
}
