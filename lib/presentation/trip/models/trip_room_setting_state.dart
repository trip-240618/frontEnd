import 'package:flutter/animation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/enum/trip_color.dart';

part 'trip_room_setting_state.freezed.dart';

@freezed
abstract class TripRoomSettingState with _$TripRoomSettingState {
  const TripRoomSettingState._();

  const factory TripRoomSettingState({
    @Default("") String tripRoomName,
    XFile? roomImage,
    @Default(TripColor.pastelBlue) TripColor selectedColor,
  }) = _TripRoomSettingState;

  int get tripRoomLength => tripRoomName.length;

  bool get isValid => tripRoomName.isNotEmpty;

  Color get getColor => selectedColor.color;
}
