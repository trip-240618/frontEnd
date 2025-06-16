import 'dart:convert';

import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../app/api/pPlanApi.dart';
import '../data/network/dio_client.dart';

class PPlanState extends GetxController {
  final ts = Get.put(TripState());
  final apiPPlanClient = ApiPPlanClient(DioClient());

  final RxList pPlanList = [].obs;

  /// p plan 리스트
  final RxList ReorderPPlanList = [].obs;

  /// Reorder p plan 리스트
  final selectedWeekIdx = 1.obs;

  /// 선택된 week 인덱스
  final totalDays = 1.obs;
  final RxMap selectPPlan = {}.obs;

  /// 수정할때 사용하는 선택된 p형 리스트
  final isSorting = false.obs;

  /// 수정 권한 버튼

  /// planB P
  final RxList planBPList = [].obs;

  /// planB p 리스트
  final RxMap selectPlanBPList = {}.obs;

  /// 수정할때 사용하는 선택된 p형 리스트

  /// p planList 가져오기
  Future<void> getPPlanList(bool locker) async {
    List allData = await apiPPlanClient.getPPlanList(ts.selectTripList[0]['id'], selectedWeekIdx.value, locker);
    List filterData = [];
    int dayIdx =
        (selectedWeekIdx.value * 7) <= totalDays.value ? 7 : totalDays.value - ((selectedWeekIdx.value - 1) * 7);
    for (int i = 1; i <= dayIdx; i++) {
      int startIdx = ((selectedWeekIdx.value - 1) * 7) + i;
      Map<String, dynamic>? matchedData;
      for (var data in allData[0]['dayList']) {
        if (data['day'] == startIdx) {
          matchedData = data;
          break;
        }
      }
      filterData.add({
        'dayAfterStart': startIdx,
        'isExpanded': true,

        /// p형 일정 열고 닫기
        'planList': matchedData != null ? matchedData['planList'] : [],
      });
    }
    allData[0]['dayList'] = filterData;
    allData.forEach((day) {
      day['waitList'] = [];
      day['checked'] = true;
    });
    pPlanList.value = allData;
    pPlanList.refresh();
  }

  /// p plan 추가
  Future<void> addPPlanList(Map data) async {
    await apiPPlanClient.addPPlanList(ts.selectTripList[0]['id'], data);
    pPlanList.refresh();
  }

  /// p plan 수정
  Future<void> editPPlanList(Map data) async {
    await apiPPlanClient.editPPlanList(ts.selectTripList[0]['id'], data);
    pPlanList.refresh();
  }

  /// p check
  Future<void> checkPPlan(int planId) async {
    await apiPPlanClient.checkPPlan(ts.selectTripList[0]['id'], planId);
  }

  /// p delete
  Future<void> deletePPlan(int planId, int day) async {
    await apiPPlanClient.deletePPlan(ts.selectTripList[0]['id'], planId, day);
  }

  /// 리오더블 형태로 변경
  Future<void> makeReorderableList() async {
    List allData = jsonDecode(jsonEncode(pPlanList));
    List filterData = [];
    allData[0]['dayList'].forEach((day) {
      Map<String, dynamic> dayData = {
        'type': 'day',
        'data': day['dayAfterStart'],
      };
      filterData.add(dayData);
      day['planList'].forEach((plans) {
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
  }

  /// 리오더블 형식을 다시 pPlanList 형태로 되돌리기
  Future<Map<String, dynamic>> revertList() async {
    List allData = jsonDecode(jsonEncode(ReorderPPlanList));
    List filterData = [];
    allData[0]['dayList'].forEach((day) {
      if (day['type'] == 'plan') {
        Map<String, dynamic> dayData = {
          'id': day['data']['planId'],
          'dayAfterStart': day['data']['dayAfterStart'],
          'orderByDate': day['data']['orderByDate'],
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
        'dayList': groupedDayList.entries.map((entry) => {'day': entry.key, 'planList': entry.value}).toList()
      };
    }).toList();
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

  /// planB pList 가져오기
  Future<void> getPlanBPList() async {
    planBPList.value = await apiPPlanClient.getPlanBPList(ts.selectTripList[0]['id'], true);
    planBPList.refresh();
  }

  /// p 일정에서 보관함 이동 혹은 보관함에서 일정 이동
  Future<void> lockerMovePPlanList(Map data) async {
    await apiPPlanClient.lockerMovePPlanList(ts.selectTripList[0]['id'], data);
    pPlanList.refresh();
  }
}
