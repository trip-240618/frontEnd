import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/common/model/popup_item_model.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_coming_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_last_trips_usecase.dart';
import 'package:tripStory/domain/usecases/update_bookmark_usecase.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';
import 'package:tripStory/view/hoom/model/trip_rooms_state.dart';
import 'package:tripStory/view/myPage/myPage.dart';
import 'package:tripStory/view/trip/bottomNavigator.dart';

class RoomsController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchComingTripsUseCase _fetchComingTrips;
  final FetchLastTripsUseCase _fetchLastTrips;
  final FetchBookmarkedTripsUseCase _fetchBookmarkedTrips;
  final UpdateBookmarkUseCase _bookmarkUseCase;

  RoomsController({
    required FetchComingTripsUseCase fetchComingTrips,
    required FetchLastTripsUseCase fetchLastTrips,
    required FetchBookmarkedTripsUseCase fetchBookmarkedTrips,
    required UpdateBookmarkUseCase updateBookmarkUseCase,
  })  : _fetchComingTrips = fetchComingTrips,
        _fetchLastTrips = fetchLastTrips,
        _fetchBookmarkedTrips = fetchBookmarkedTrips,
        _bookmarkUseCase = updateBookmarkUseCase;

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

  /// side Effect

  Future<void> onComingTripPressed() async {
    final result = await _fetchComingTrips.call(NoParams());
    result.fold((error) {}, (rooms) {
      tripRoomsState = tripRoomsState.copyWith(
        tripRooms: rooms,
        tripRoomType: TripRoomType.coming,
      );
      update();
    });
  }

  Future<void> onLastTripPressed() async {
    final result = await _fetchLastTrips.call(NoParams());
    result.fold((error) {}, (rooms) {
      tripRoomsState = tripRoomsState.copyWith(
        tripRooms: rooms,
        tripRoomType: TripRoomType.lastTrip,
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
      );
      update();
    });
  }

  Future<void> onBookmarkIconPressed(int tripId) async {
    final result = await _bookmarkUseCase(tripId);
    result.fold((error) {}, (bookmark) {
      final room = tripRoomsState.findTripRoom(tripId);
      if (room == null) return;

      final updatedRoom = room.copyWith(bookmark: bookmark);

      tripRoomsState = tripRoomsState.copyWith(
        tripRooms: tripRoomsState.tripRooms.map((room) => room.id == tripId ? updatedRoom : room).toList(),
      );
      update();
    });
  }

  void onRoomPressed() => Get.to(() => BottomNavigator())?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onNotificationPressed() => Get.toNamed(Routes.notificationList)?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onMyPagePressed() => Get.to(() => MyPage());

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
