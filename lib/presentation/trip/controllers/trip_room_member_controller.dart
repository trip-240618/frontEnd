import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/kick_member_usecase.dart';
import 'package:tripStory/domain/usecases/leave_trip_room_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class TripRoomMemberController extends GetxController {
  final TripRoomService _tripRoomService;
  final LoginUserService _loginUserService;
  final LeaveTripRoomUsecase _leaveTripRoomUsecase;
  final KickMemberUsecase _kickMemberUsecase;

  TripRoomMemberController(
    this._tripRoomService,
    this._loginUserService,
    this._leaveTripRoomUsecase,
    this._kickMemberUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  String get _myUuid => _loginUserService.myUuid;

  bool isMe(TripMemberEntity member) => member.uuid == _myUuid;

  bool get isRoomLeader => tripRoomInfo?.isLeader(_myUuid) ?? false;

  List<TripMemberEntity> get members => tripRoomInfo?.members ?? const [];

  /// side Effect
  Future<void> onTripRoomLeavePressed() async {
    final tripType = tripRoomInfo?.type;
    if (tripType == null) return;

    final leaveTripRoomParams = LeaveTripRoomParams(
      tripType: tripType,
      tripId: tripRoomInfo?.id ?? 0,
    );
    final result = await _leaveTripRoomUsecase.call(leaveTripRoomParams);

    result.fold(
      (failure) {},
      (success) {
        Get.until((route) => route.settings.name == Routes.rooms);
      },
    );
  }

  Future<void> onKickMemberPressed(String userId) async {
    final tripType = tripRoomInfo?.type;
    if (tripType == null) return;

    final leaveTripRoomParams = KickMemberParams(
      tripId: tripRoomInfo?.id ?? 0,
      tripType: tripType,
      uuid: userId,
    );

    final result = await _kickMemberUsecase.call(leaveTripRoomParams);

    result.fold(
      (failure) {},
      (success) {
        _tripRoomService.removeMember(userId);
        update();
      },
    );
  }
}
