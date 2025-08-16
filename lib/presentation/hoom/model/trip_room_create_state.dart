import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/util/one_time_event.dart';

part 'trip_room_create_state.freezed.dart';

@freezed
abstract class TripRoomCreateState with _$TripRoomCreateState {
  const TripRoomCreateState._();

  const factory TripRoomCreateState({
    XFile? roomImage,
    @Default("") String title,
    @Default(TripColor.pastelBlue) TripColor selectedColor,
    TripType? type,
    @Default([]) List<DateTime> tripDate,
    @Default("") String tripDestination,
    OneTimeEvent<bool>? showTripSearchBottomSheet,
    OneTimeEvent<bool>? showLoading,
    OneTimeEvent<String>? showCodeDialog,
  }) = _TripRoomCreateState;

  bool get isTripDateEmpty => tripDate.isEmpty;

  Color get getColor => selectedColor.color;

  bool get isValid =>
      title.trim().isNotEmpty && type != null && tripDate.isNotEmpty && tripDestination.trim().isNotEmpty;
}
