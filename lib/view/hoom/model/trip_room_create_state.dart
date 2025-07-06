import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/one_time_event.dart';

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

  String get tripDateText {
    if (tripDate.isEmpty) return "여행 날짜를 입력해 주세요";
    if (tripDate.length == 1) return tripDate[0].formatYMDWithHyphen();
    return '${tripDate[0].formatYMDWithHyphen()} ~ ${tripDate[1].formatYMDWithHyphen()}';
  }

  bool get isValid => type != null && tripDate.isNotEmpty && tripDestination.trim().isNotEmpty;
}
