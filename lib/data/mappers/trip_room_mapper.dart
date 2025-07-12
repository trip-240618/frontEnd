import 'package:tripStory/data/models/response/trip_room_response.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';

class TripRoomMapper {
  static TripRoomEntity toEntity(TripRoomResponse response) {
    return TripRoomEntity(
      id: response.id,
      name: response.name,
      type: response.type,
      startDate: DateTime.parse(response.startDate),
      endDate: DateTime.parse(response.endDate),
      country: response.country,
      thumbnail: response.thumbnail,
      invitationCode: response.invitationCode,
      labelColor: response.labelColor,
      bookmark: response.bookmark,
      domain: response.domain,
      members: response.tripMemberDtoList
          .map((member) => TripMemberEntity(
                uuid: member.uuid,
                nickname: member.nickname,
                thumbnail: member.thumbnail,
                leader: member.leader,
              ))
          .toList(),
    );
  }
}
