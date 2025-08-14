import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';

class TripRoomMemberController extends GetxController {
  final TripRoomService _tripRoomService;
  final LoginUserService _loginUserService;

  TripRoomMemberController(
    this._tripRoomService,
    this._loginUserService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  bool isMe(TripMemberEntity member) => member.uuid == _loginUserService.myUuid;

  List<TripMemberEntity> get members => tripRoomInfo?.members ?? const [];
}
