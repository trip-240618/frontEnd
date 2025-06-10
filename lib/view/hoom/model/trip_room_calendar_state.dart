import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/util/one_time_event.dart';

part 'trip_room_calendar_state.freezed.dart';

@freezed
abstract class TripRoomCalendarState with _$TripRoomCalendarState {
  const factory TripRoomCalendarState({
    @Default([]) List<DateTime> selectedDates,
    OneTimeEvent<bool>? showDialog,
  }) = _TripRoomCalendarState;
}
