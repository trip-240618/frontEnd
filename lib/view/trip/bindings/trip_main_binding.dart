import 'package:get/get.dart';
import 'package:tripStory/core/services/socket_service.dart';
import 'package:tripStory/core/services/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/trip_main_controller.dart';

class TripMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripMainController>(
      () => TripMainController(
        Get.find<TripRoomService>(),
        Get.find<SocketService>(),
      ),
    );
  }
}
