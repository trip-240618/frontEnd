import 'package:get/get.dart';
import 'package:tripStory/view/hoom/controller/trip_room_calendar_controller.dart';

class TripCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRoomCalendarController>(() => TripRoomCalendarController());
  }
}
