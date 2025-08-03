import 'package:get/get.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/trip_main_controller.dart';

class TripMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripMainController>(
      () => TripMainController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
