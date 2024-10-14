import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../app/api/pPlanApi.dart';
import '../app/config/dio_client.dart';

class PPlanState extends GetxController{
  final ts = Get.put(TripState());

  final apiPPlanClient = ApiPPlanClient(DioClient());

  final RxList pPlanList = [].obs; /// p plan data 리스트

  /// p planList 가져오기
  Future<void> getPPlanList(bool locker)async{
    pPlanList.value = await apiPPlanClient.getPPlanList(ts.selectTripList[0]['id'], locker);
    pPlanList.refresh();
  }
  /// p plan List 추가
  Future<void> addPPlanList(String content, int dayAfterStart, bool locker)async{
    pPlanList.value = await apiPPlanClient.addPPlanList(ts.selectTripList[0]['id'],content, dayAfterStart, locker);
    pPlanList.refresh();
  }
}
