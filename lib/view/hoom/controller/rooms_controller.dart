import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/common/model/popup_item_model.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_coming_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_enter_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_join_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_last_trips_usecase.dart';
import 'package:tripStory/domain/usecases/update_bookmark_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';
import 'package:tripStory/view/hoom/model/trip_rooms_state.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';

class RoomsController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchComingTripsUseCase _fetchComingTrips;
  final FetchLastTripsUseCase _fetchLastTrips;
  final FetchBookmarkedTripsUseCase _fetchBookmarkedTrips;
  final UpdateBookmarkUseCase _bookmarkUseCase;
  final FetchJoinRoomUsecase _fetchJoinRoomUsecase;
  final FetchEnterRoomUsecase _fetchEnterRoomUsecase;
  final TripRoomService _tripRoomService;

  RoomsController(
    this._tripRoomService, {
    required FetchComingTripsUseCase fetchComingTrips,
    required FetchLastTripsUseCase fetchLastTrips,
    required FetchBookmarkedTripsUseCase fetchBookmarkedTrips,
    required UpdateBookmarkUseCase updateBookmarkUseCase,
    required FetchJoinRoomUsecase fetchJoinRoomUsecase,
    required FetchEnterRoomUsecase fetchEnterRoomUsecase,
  })  : _fetchComingTrips = fetchComingTrips,
        _fetchLastTrips = fetchLastTrips,
        _fetchBookmarkedTrips = fetchBookmarkedTrips,
        _bookmarkUseCase = updateBookmarkUseCase,
        _fetchJoinRoomUsecase = fetchJoinRoomUsecase,
        _fetchEnterRoomUsecase = fetchEnterRoomUsecase;

  TripRoomsState tripRoomsState = TripRoomsState();
  DateTime? _lastBackPressTime;
  int notificationCount = 0;

  List<PopupItemModel> getPopupMembers(TripRoomEntity tripRoom) => tripRoom.members
      .map(
        (member) => PopupItemModel(
          nickname: member.nickname,
          profileImg: member.thumbnail,
        ),
      )
      .toList();

  int getLongestNicknameLength(TripRoomEntity room) {
    return room.members.map((e) => e.nickname.length).fold(0, (a, b) => a > b ? a : b);
  }

  bool shouldExitOnBackPressed() {
    final now = DateTime.now();
    final isFirstTap = _lastBackPressTime == null || now.difference(_lastBackPressTime!) > const Duration(seconds: 2);

    if (isFirstTap) {
      _lastBackPressTime = now;
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    _getComingTrips();
  }

  Future<void> _getComingTrips() async {
    final result = await _fetchComingTrips.call(NoParams());
    result.fold(
      (error) {},
      (rooms) {
        tripRoomsState = tripRoomsState.copyWith(
          tripRooms: rooms,
          tripRoomType: TripRoomType.coming,
          tripRoomsStatus: rooms.isEmpty ? TripRoomsStatus.empty : TripRoomsStatus.success,
        );
        update();
      },
    );
  }

  /// side Effect
  Future<void> onComingTripPressed() async {
    _getComingTrips();
  }

  Future<void> onLastTripPressed() async {
    final result = await _fetchLastTrips.call(NoParams());
    result.fold((error) {}, (rooms) {
      tripRoomsState = tripRoomsState.copyWith(
        tripRooms: rooms,
        tripRoomType: TripRoomType.lastTrip,
        tripRoomsStatus: rooms.isEmpty ? TripRoomsStatus.empty : TripRoomsStatus.success,
      );
      update();
    });
  }

  Future<void> onBookMarkTripPressed() async {
    final result = await _fetchBookmarkedTrips.call(NoParams());
    result.fold((error) {}, (rooms) {
      tripRoomsState = tripRoomsState.copyWith(
        tripRooms: rooms,
        tripRoomType: TripRoomType.bookmarked,
        tripRoomsStatus: rooms.isEmpty ? TripRoomsStatus.empty : TripRoomsStatus.success,
      );
      update();
    });
  }

  Future<void> onBookmarkIconPressed(
    int tripId,
    int index,
  ) async {
    final result = await _bookmarkUseCase(tripId);
    result.fold((error) {}, (bookmark) {
      final room = tripRoomsState.tripRooms[index];
      final updatedRoom = room.copyWith(bookmark: bookmark);
      final updatedList = List.of(tripRoomsState.tripRooms);
      updatedList[index] = updatedRoom;

      tripRoomsState = tripRoomsState.copyWith(tripRooms: updatedList);
      update();
    });
  }

  Future<bool> onJoinCodePressed(String invitationCode) async {
    final result = await _fetchJoinRoomUsecase(invitationCode);
    return result.fold(
      (error) => false,
      (tripRoom) => true,
    );
  }

  Future<void> init(int tripId) async {}

  Future<void> onRoomPressed(int tripId) async {
    final result = await _fetchEnterRoomUsecase(tripId);
    result.fold(
      (failure) {},
      (room) {
        _tripRoomService.setTripRoom(room);
        Get.toNamed(Routes.tripRoom, arguments: tripId)?.then((v) async {
          // await notis.getNotificationCount();
        });
      },
    );
  }

  void onNotificationPressed() => Get.toNamed(Routes.notificationList)?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onMyPagePressed() => Get.toNamed(Routes.myPage);

  void onRoomCreatedPressed() => Get.toNamed(Routes.createRoom);

  ///카카오 공유하기
  void kakaoShare(int tripId, String inviteCode) async {
    /// 사용자 정의 템플릿 ID
    int templateId = 109315;

    /// 카카오톡 실행 가능 여부 확인
    bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();
    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri = await ShareClient.instance
            .shareCustom(templateId: templateId, templateArgs: {'value1': '${tripId}', 'value2': inviteCode});
        await ShareClient.instance.launchKakaoTalk(uri);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeCustomUrl(templateId: templateId, templateArgs: {'value1': '${tripId}', 'value2': inviteCode});
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }
}
