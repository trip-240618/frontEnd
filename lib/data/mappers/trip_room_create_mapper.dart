import 'package:tripStory/data/models/trip_room_create_response.dart';
import 'package:tripStory/domain/entities/trip_room_create_entity.dart';

class TripRoomCreateMapper {
  static TripRoomCreateEntity toEntity(TripRoomCreateResponse response) {
    return TripRoomCreateEntity(
      tripId: response.tripId,
      invitationCode: response.invitationCode,
    );
  }
}
