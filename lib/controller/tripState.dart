import 'package:get/get.dart';

import '../app/api/tripApi.dart';
import '../data/network/dio_client.dart';

class TripState extends GetxController {
  final RxList selectTripList = <dynamic>[].obs;

  /// 선택한 여행
  final dio = Get.find<DioClient>();
  late final apiTripClient = ApiTripClient(dio);

  @override
  void onInit() {
    super.onInit();
  }

  /// 여행방 정보 가져오기
  Future<void> getSelectTrip(int tripId) async {
    selectTripList.value = await apiTripClient.tripEnter(tripId);
    selectTripList[0]['labelColor'] = int.parse(selectTripList[0]['labelColor']);
    selectTripList.refresh();
  }

  /// 여행방 정보 수정하기
  Future<void> modifyTrip(
      int tripId, String name, String thumbnail, String labelColor, String startDate, String endDate) async {
    await apiTripClient.tripModify(tripId, name, thumbnail, labelColor, startDate, endDate);
  }

  /// 여행방 강퇴하기
  Future<void> kickTrip(int tripId, String tripType, String uuid) async {
    await apiTripClient.tripKick(tripId, tripType, uuid);
  }

  /// 여행방 삭제하기
  Future<void> deleteTrip(int tripId) async {
    await apiTripClient.tripDelete(tripId);
  }

  /// 여행방 나가기
  Future<void> leaveTrip(int tripId, String tripType) async {
    await apiTripClient.tripLeave(tripId, tripType);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
