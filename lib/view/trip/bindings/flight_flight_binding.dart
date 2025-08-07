import 'package:get/get.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/flight_search_controller.dart';

class FlightFlightBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlightSearchController>(
      () => FlightSearchController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
