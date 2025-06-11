import 'package:get/get.dart';
import 'package:tripStory/util/one_time_event.dart';
import 'package:tripStory/view/hoom/model/trip_room_calendar_state.dart';

class TripRoomCalendarController extends GetxController with GetSingleTickerProviderStateMixin {
  TripRoomCalendarController();

  TripRoomCalendarState tripRoomCalendarState = TripRoomCalendarState();

  TripRoomCalendarState get state => tripRoomCalendarState;

  /// side Effect
  void onCalendarDatesChange(List<DateTime> dates) {
    tripRoomCalendarState = tripRoomCalendarState.copyWith(
      selectedDates: dates,
    );
    update();
  }

  void onSavePressed() {
    if (state.selectedDates.isEmpty) {
      if (Get.isDialogOpen == true) return;
      tripRoomCalendarState = tripRoomCalendarState.copyWith(
        showDialog: OneTimeEvent(true),
      );
      update();
      return;
    }

    Get.back(
      result: tripRoomCalendarState.selectedDates,
    );
  }
}
