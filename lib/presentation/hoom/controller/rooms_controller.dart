import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_coming_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_enter_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_join_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_last_trips_usecase.dart';
import 'package:tripStory/domain/usecases/kakao_share_usecase.dart';
import 'package:tripStory/domain/usecases/update_bookmark_usecase.dart';
import 'package:tripStory/presentation/common/popup/popup_item_model.dart';
import 'package:tripStory/presentation/hoom/enum/trip_rooms_type.dart';
import 'package:tripStory/presentation/hoom/model/trip_rooms_state.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class RoomsController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchComingTripsUseCase _fetchComingTrips;
  final FetchLastTripsUseCase _fetchLastTrips;
  final FetchBookmarkedTripsUseCase _fetchBookmarkedTrips;
  final UpdateBookmarkUseCase _bookmarkUseCase;
  final FetchJoinRoomUsecase _fetchJoinRoomUsecase;
  final FetchEnterRoomUsecase _fetchEnterRoomUsecase;
  final TripRoomService _tripRoomService;
  final KakaoShareUsecase _kakaoShareUsecase;

  RoomsController(
    this._tripRoomService, {
    required FetchComingTripsUseCase fetchComingTrips,
    required FetchLastTripsUseCase fetchLastTrips,
    required FetchBookmarkedTripsUseCase fetchBookmarkedTrips,
    required UpdateBookmarkUseCase updateBookmarkUseCase,
    required FetchJoinRoomUsecase fetchJoinRoomUsecase,
    required FetchEnterRoomUsecase fetchEnterRoomUsecase,
    required KakaoShareUsecase kakaoShareUsecase,
  })  : _fetchComingTrips = fetchComingTrips,
        _fetchLastTrips = fetchLastTrips,
        _fetchBookmarkedTrips = fetchBookmarkedTrips,
        _bookmarkUseCase = updateBookmarkUseCase,
        _fetchJoinRoomUsecase = fetchJoinRoomUsecase,
        _fetchEnterRoomUsecase = fetchEnterRoomUsecase,
        _kakaoShareUsecase = kakaoShareUsecase;

  TripRoomsState tripRoomsState = TripRoomsState();

  TripRoomsState get state => tripRoomsState;

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
    _handleKakaoEntry();
  }

  Future<void> _handleKakaoEntry() async {
    final url = await receiveKakaoScheme();
    if (url != null) {
      _enterKakaoTrip(url);
    }

    kakaoSchemeStream.listen((url) {
      if (url != null) {
        _enterKakaoTrip(url);
      }
    });
  }

  Future<void> _enterKakaoTrip(String url) async {
    final uri = Uri.parse(url);

    if (uri.host == "share") {
      final tripId = uri.queryParameters["tripId"];
      final inviteCode = uri.queryParameters["inviteCode"];

      if (tripId != null && inviteCode != null) {
        final result = await _fetchJoinRoomUsecase.call(inviteCode);

        result.fold(
          (error) {},
          (_) {
            RouteHelper.popAllUntilAndToNamed(
              Routes.rooms,
              Routes.tripRoom,
              arguments: tripId,
            );
          },
        );
      }
    }
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

  Future<void> _getLastTrips() async {
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

  Future<void> _getBookMarkTrips() async {
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

  Future<void> _refreshRoom() async {
    switch (tripRoomsState.tripRoomType) {
      case TripRoomType.coming:
        await _getComingTrips();
        break;
      case TripRoomType.lastTrip:
        await _getLastTrips();
        break;
      case TripRoomType.bookmarked:
        await _getBookMarkTrips();
        break;
    }
  }

  /// side Effect
  Future<void> onComingTripPressed() async {
    _getComingTrips();
  }

  Future<void> onLastTripPressed() async {
    _getLastTrips();
  }

  Future<void> onBookMarkTripPressed() async {
    _getBookMarkTrips();
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
    final result = await _fetchJoinRoomUsecase.call(invitationCode);
    return result.fold(
      (error) => false,
      (tripRoom) => true,
    );
  }

  Future<void> onRoomPressed(int tripId) async {
    final result = await _fetchEnterRoomUsecase(tripId);
    result.fold(
      (failure) {},
      (room) {
        _tripRoomService.setTripRoom(room);
        Get.toNamed(Routes.tripRoom, arguments: tripId)?.then((v) async {
          _refreshRoom();
        });
      },
    );
  }

  void onNotificationPressed() => Get.toNamed(Routes.notificationList)?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onMyPagePressed() => Get.toNamed(Routes.myPage);

  void onRoomCreatedPressed() => Get.toNamed(Routes.createRoom);

  Future<void> onKakaoSharePressed(
    int tripId,
    String inviteCode,
  ) async {
    final result = await _kakaoShareUsecase.call(Tuple2(tripId, inviteCode));
    result.fold(
      (failure) {
        tripRoomsState = tripRoomsState.copyWith(
          tripRoomsStatus: TripRoomsStatus.failure,
        );
        update();
      },
      (_) {},
    );
  }

  void onInviteCodeCopyPressed(String inviteCode) {
    Clipboard.setData(ClipboardData(text: inviteCode));
    tripRoomsState = tripRoomsState.copyWith(
      showToast: OneTimeEvent("초대코드를 복사했습니다"),
    );
    update();
  }
}
