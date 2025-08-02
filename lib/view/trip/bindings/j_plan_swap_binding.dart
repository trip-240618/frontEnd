import 'package:get/get.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/j_plan_swap_controller.dart';

class JPlanSwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JPlanSwapController>(
      () => JPlanSwapController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
