import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripStory/view/rooms/main_page/enum/trip_option.dart';

part 'trip_room_model.freezed.dart';
part 'trip_room_model.g.dart';

@freezed
abstract class TripRoomModel with _$TripRoomModel {
  const factory TripRoomModel({
    @Default(TripOption.tripUpcoming) TripOption selectedTripOption,
    @Default([]) List<String> tripRoomTile,
  }) = _TripRoomModel;

  factory TripRoomModel.fromJson(Map<String, dynamic> json) => _$TripRoomModelFromJson(json);
}
