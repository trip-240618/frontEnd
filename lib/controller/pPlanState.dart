import 'dart:convert';

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
  final totalDays = 1.obs;
  final RxMap selectPPlan = {}.obs; /// 수정할때 사용하는 선택된 p형 리스트
  final isSorting = false.obs; /// 수정 권한 버튼

  /// p planList 가져오기
  Future<void> getPPlanList(bool locker)async{
    List allData = await apiPPlanClient.getPPlanList(ts.selectTripList[0]['id'],selectedWeekIdx.value, locker);
    List filterData = [];

    print('기존 데이터?${allData}');
    int dayIdx = (selectedWeekIdx.value*7)<=totalDays.value? 7: totalDays.value-((selectedWeekIdx.value-1)*7);
    for(int i = 1; i<=dayIdx; i++){
      int startIdx = ((selectedWeekIdx.value-1)*7)+i;
      Map<String, dynamic>? matchedData;
      for(var data in allData[0]['dayList']){
        if(data['day']==startIdx){
          matchedData = data;
          break;
        }
      }
      filterData.add({
        'dayAfterStart':startIdx,
        'isExpanded':true,
        'planList':matchedData!=null?matchedData['planList']:[],
      });

    }
    allData[0]['dayList'] = filterData;
    allData.forEach((day) {
      day['waitList']=[];
      day['checked'] = true;
    });
    pPlanList.value = allData;
    print('완성된 pPlanList?${pPlanList}');
    pPlanList.refresh();
  }
  /// p plan List 추가
  Future<void> addPPlanList(String content, int dayAfterStart, bool locker)async{
    await apiPPlanClient.addPPlanList(ts.selectTripList[0]['id'],content, dayAfterStart, locker);
    pPlanList.refresh();
  }

  /// jplanList 수정
  Future<void> editPPlanList(Map data)async{
    await apiPPlanClient.editPPlanList(ts.selectTripList[0]['id'],data);
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
  /// 리오더블 형태로 변경
  Future<void> makeReorderableList() async{
    List allData = jsonDecode(jsonEncode(pPlanList));
    List filterData = [];
    allData[0]['dayList'].forEach((day) {
      Map<String, dynamic> dayData = {
        'type': 'day',
        'data': day['dayAfterStart'],
      };
      filterData.add(dayData);
      day['planList'].forEach((plans){
        Map<String, dynamic> planData = {
          'type': 'plan',
          'data': plans,
        };
        filterData.add(planData);
      });
    });
    allData[0].remove('waitList');
    allData[0].remove('checked');
    allData[0]['dayList'] = filterData;
    ReorderPPlanList.value = allData;
    print(ReorderPPlanList);
  }
  /// 리오더블 형식을 다시 pPlanList 형태로 되돌리기
  Future<Map<String,dynamic>> revertList() async{
    List allData = ReorderPPlanList;
    List filterData = [];
    allData[0]['dayList'].forEach((day) {
      if(day['type']=='plan'){
        Map<String, dynamic> dayData = {
          'planId': day['data']['planId'],
          'dayAfterStart': day['data']['dayAfterStart'],
          'orderByDate':day['data']['orderByDate'],
        };
        filterData.add(dayData);
      }
    });
    allData[0]['dayList'] = filterData;

    List transformedList = allData.map((weekData) {
      var groupedDayList = <int, List<Map<String, dynamic>>>{};

      weekData['dayList'].forEach((plan) {
        groupedDayList.putIfAbsent(plan['dayAfterStart'], () => []).add(plan);
      });

      return {
        'week': weekData['week'],
        'dayList': groupedDayList.entries.map((entry) => {
          'day': entry.key,
          'planList': entry.value
        }).toList()
      };
    }).toList();

    print('최종 리스트?${transformedList}');

    return transformedList[0];
  }

  /// p 리오더블 취소
  Future<void> deleteReorderPPlan(int week) async {
    await apiPPlanClient.deleteReorderPPlan(ts.selectTripList[0]['id'], week);
  }

  /// p 리오더블
  Future<void> reorderPPlan(Map data) async {
    await apiPPlanClient.reorderPPlan(ts.selectTripList[0]['id'], data);
  }
}
