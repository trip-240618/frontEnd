import 'package:get/get.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/flight_create_controller.dart';

class FlightCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlightCreateController>(
      () => FlightCreateController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
