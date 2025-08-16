import 'package:get/get.dart';
import 'package:tripStory/presentation/trip/controllers/trip_main_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

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
