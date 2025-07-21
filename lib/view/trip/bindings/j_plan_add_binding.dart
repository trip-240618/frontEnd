import 'package:get/get.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_add_controller.dart';

class JPlanAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JPlanAddController>(
      () => JPlanAddController(Get.find<TripRoomService>()),
    );
  }
}
