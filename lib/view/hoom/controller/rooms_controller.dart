import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/app/api/fileApi.dart';
import 'package:tripStory/app/api/tripApi.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/common/model/popup_item_model.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';
import 'package:tripStory/view/hoom/model/trip_rooms_state.dart';
import 'package:tripStory/view/hoom/notification/notification_main.dart';
import 'package:tripStory/view/myPage/myPage.dart';
import 'package:tripStory/view/trip/bottomNavigator.dart';

class RoomsController extends GetxController with GetSingleTickerProviderStateMixin {
  RoomsController(this._tripRepository);

  final TripRepository _tripRepository;

  final apiTripClient = ApiTripClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());

  late TabController tabController;

  TripRoomsState tripRoomsState = TripRoomsState();

  DateTime? _lastBackPressTime;

  int notificationCount = 0;

  List<PopupItemModel> getPopupMembers(TripRoom tripRoom) => tripRoom.tripMemberDtoList
      .map(
        (member) => PopupItemModel(
          nickname: member.nickname,
          profileImg: member.thumbnail,
        ),
      )
      .toList();

  int getLongestNicknameLength(TripRoom room) {
    return room.tripMemberDtoList.map((e) => e.nickname.length).fold(0, (a, b) => a > b ? a : b);
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
    final result = await _tripRepository.fetchComingTrips();
    tripRoomsState = tripRoomsState.copyWith(
      tripRooms: result,
      tripRoomType: TripRoomType.coming,
    );
    update();
  }

  Future<void> onLastTripPressed() async {
    final result = await _tripRepository.fetchLastTrips();
    tripRoomsState = tripRoomsState.copyWith(
      tripRooms: result,
      tripRoomType: TripRoomType.lastTrip,
    );
    update();
  }

  Future<void> onBookMarkTripPressed() async {
    final result = await _tripRepository.fetchBookmarkedTrips();
    tripRoomsState = tripRoomsState.copyWith(
      tripRooms: result,
      tripRoomType: TripRoomType.bookmarked,
    );
    update();
  }

  Future<void> onBookmarkIconPressed(int tripId) async {
    final result = await _tripRepository.updateBookmark(tripId);

    final room = tripRoomsState.findTripRoom(tripId);
    if (room == null) return;

    final updatedRoom = room.copyWith(bookmark: result);

    tripRoomsState = tripRoomsState.copyWith(
      tripRooms: tripRoomsState.tripRooms.map((room) => room.id == tripId ? updatedRoom : room).toList(),
    );
    update();
  }

  void onRoomPressed() => Get.to(() => BottomNavigator())?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onNotificationPressed() => Get.to(() => NotificationMain())?.then((v) async {
        // await notis.getNotificationCount();
      });

  void onMyPagePressed() => Get.to(() => MyPage());

  void onRoomCreatedPressed() => Get.toNamed(Routes.createRoom);

  /// 탭
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  final tripDestination = ''.obs;

  /// 여행지 목적
  RxList<DateTime> tripDate = <DateTime>[].obs;
  TextEditingController tripCitySearchCon = TextEditingController();

  /// 여행지 검색
  TextEditingController tripDirectSearchCon = TextEditingController();

  /// 여행지 직접 검색
  final directSelectedCity = ''.obs;

  /// 여행지 직접 검색에서 선택한 해외 여행지
  final selectedCity = ''.obs;

  /// 선택한 여행지
  final tripLeaveType = ''.obs;

  /// 여행타입 선택
  final firstInit = false.obs;

  /// 처음 실행 됬을 때

  /// 여행지 목록 리스트

  @override
  void onClose() {
    tabController.dispose();
    tripCitySearchCon.dispose();
    tripDirectSearchCon.dispose();
    super.onClose();
  }

  /// 여행방 참가
  Future<Map<String, dynamic>> tripJoin(String invitationCode) async {
    Map<String, dynamic> data = await apiTripClient.tripJoin(invitationCode);
    return data;
  }

  /// 여행지 캐쉬 저장
  void preCacheFlagImages(BuildContext context, List<Map<String, dynamic>> country) {
    for (var region in country) {
      for (var country in region['countries']) {
        final imageUrl = country['image'];
        precacheImage(CachedNetworkImageProvider(imageUrl), context);
      }
    }
  }

  /// 여행방 만들기 변수 초기화
  Future<void> roomReset() async {
    selectedCity.value = '';
    tripLeaveType.value = '해외';
    directSelectedCity.value = '';
    pickedImage.value = null;
    tripDestination.value = '';
    tripDate.value = [];
  }

  /// 여행지 바텀 리셋
  Future<void> bottomModalReset() async {
    selectedCity.value = '';
    tripLeaveType.value = '해외';
    directSelectedCity.value = '';
    tabController.index = 0;
    tripCitySearchCon.text = '';
    tripDirectSearchCon.text = '';
  }

  /// 여행지 선택 저장
  Future<void> saveDestination() async {
    ///여행지 검색
    if (tabController.index == 0) {
      if (selectedCity == '') {
      } else {
        tripDestination.value = selectedCity.value;
        Get.back();
      }

      ///직접 입력
    } else {
      if (tripLeaveType == '' || tripDirectSearchCon.text == '') {
      } else {
        if (tripLeaveType == '해외' && directSelectedCity.value != '') {
          tripDestination.value = directSelectedCity.value!;
          Get.back();
        } else if (tripLeaveType == '국내') {
          tripDestination.value = tripDirectSearchCon.text;
          Get.back();
        }
      }
    }
  }

  /// 여행방 add
  Future<Map<String, dynamic>> createRoom(
      String thumbnailUrl, String name, String color, String type, List tripDate, String tripDestination) async {
    Map<String, dynamic> createData = await apiTripClient.tripCreate(thumbnailUrl, name, color, type, '${tripDate[0]}',
        tripDate.length == 1 ? '${tripDate[0]}' : '${tripDate[1]}', tripDestination);
    return createData;
  }

  /// 여행방 썸네일 요청
  Future<Map<String, dynamic>> tripThumbnailUpload(XFile xfile) async {
    final fileBytes = await xfile.readAsBytes();
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
      fileBytes,
      quality: 10,
      minWidth: 400,
      minHeight: 400,
    );
    Map<String, dynamic> data = await apiFileClient.fileUrlGet(1);

    for (int i = 0; i < 1; i++) {
      final response = await http.put(
        Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: compressedBytes, // 압축된 이미지를 업로드
      );
    }
    return data;
  }

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
