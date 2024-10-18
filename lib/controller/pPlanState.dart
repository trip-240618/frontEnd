import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../app/api/pPlanApi.dart';
import '../app/config/dio_client.dart';

class PPlanState extends GetxController{
  final ts = Get.put(TripState());

  final apiPPlanClient = ApiPPlanClient(DioClient());

  final RxList pPlanList = [].obs; /// p plan data 리스트
  final RxList ReorderPPlanList = [].obs; /// Reorder

  final selectedWeekIdx = 1.obs; /// 선택된 week 인덱스
  final RxMap selectPPlan = {}.obs; /// 수정할때 사용하는 선택된 p형 리스트

  /// p planList 가져오기
  Future<void> getPPlanList(bool locker)async{
    List allData = await apiPPlanClient.getPPlanList(ts.selectTripList[0]['id'], locker);
    List filterData = [];

    DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
    DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);

    for(int i = 1; i<=endDate.difference(startDate).inDays+1; i++){
      Map<String, dynamic>? matchedData;
      for(var data in allData){
        if(data['dayAfterStart']==i){
          matchedData = data;
          break;
        }
      }
      filterData.add({
        'dayAfterStart':i,
        'checked':true,
        'planList':matchedData!=null?matchedData['planList']:[],
      });

      pPlanList.value = filterData;
      pPlanList.refresh();
    }
  }
  /// p plan List 추가
  Future<void> addPPlanList(String content, int dayAfterStart, bool locker)async{
    await apiPPlanClient.addPPlanList(ts.selectTripList[0]['id'],content, dayAfterStart, locker);
    pPlanList.refresh();
  }

  /// p check
  Future<void> checkPPlan(int planId)async{
    await apiPPlanClient.checkPPlan(ts.selectTripList[0]['id'], planId);
  }

  /// p delete
  Future<void> deletePPlan(int planId, int day) async {
    await apiPPlanClient.deletePPlan(ts.selectTripList[0]['id'], planId, day);
  }
}
