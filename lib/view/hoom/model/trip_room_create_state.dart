import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/enum/trip_color.dart';
import 'package:tripStory/common/enum/trip_type.dart';

part 'trip_room_create_state.freezed.dart';

@freezed
abstract class TripRoomCreateState with _$TripRoomCreateState {
  const factory TripRoomCreateState({
    XFile? roomImage,
    @Default(TripColor.pastelBlue) TripColor selectedColor,
    TripType? type,
  }) = _TripRoomCreateState;
}
