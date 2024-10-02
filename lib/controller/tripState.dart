import 'package:get/get.dart';
import '../app/api/tripApi.dart';
import '../app/config/dio_client.dart';


class TripState extends GetxController{
  final RxList selectTripList = <dynamic>[].obs; /// 선택한 여행
  final apiTripClient = ApiTripClient(DioClient());

  @override
  void onInit() {

    super.onInit();
  }
  /// 여행방 정보 가져오기
  Future<void> getSelectTrip(int tripId)async{
    selectTripList.clear();
    selectTripList.value = await apiTripClient.tripEnter(tripId);
  }
  /// 여행방 정보 수정하기
  Future<void> modifyTrip(int tripId,String name,String thumbnail,String labelColor,String startDate,String endDate)async{
     await apiTripClient.tripModify(tripId, name, thumbnail, labelColor, startDate, endDate);
  }


  @override
  void dispose() {
    super.dispose();
  }
}