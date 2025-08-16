import 'package:get/get.dart';
import 'package:tripStory/presentation/hoom/controller/trip_room_calendar_controller.dart';

class TripCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRoomCalendarController>(() => TripRoomCalendarController());
  }
}
