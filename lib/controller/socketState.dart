
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import '../util/custom_marker.dart';
import 'jPlanState.dart';
import 'pPlanState.dart';

class SocketState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final js = Get.put(JPlanState());
  final ps = Get.put(PPlanState());
  final us = Get.put(UserState());
  StompClient? stompClient;

  @override
  void onInit() {
    Future.delayed(Duration.zero,()async{
      final prefs = await SharedPreferences.getInstance();
      String accessToken = '${prefs.getString('accessToken')}';
      String refreshToken = '${prefs.getString('refreshToken')}';
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: 'https://trip-story.site/ws',
          onConnect: ts.selectTripList[0]['type']=='J'?onConnect:pOnConnect,
          webSocketConnectHeaders: {
            HttpHeaders.cookieHeader: '$accessToken;$refreshToken',
          },
          beforeConnect: () async {
            // print('waiting to connect...');
            // await Future.delayed(const Duration(milliseconds: 200));
          },
          onWebSocketError: (dynamic error) {
            print('WebSocket Error: $error');
            stompClient!.deactivate();
          },
          onStompError: (dynamic error) {
            print('Stomp Error: $error');
            stompClient!.deactivate();
          },
          onDisconnect: (frame) => print('Disconnected'),
        ),
      );
      stompClient!.activate();
    });
    super.onInit();
  }

  @override
  void onClose()async{
    stompClient!.deactivate();
    super.onClose();
  }
  /// j형 소켓 정보
  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/api/trip/j/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        switch (result['command']) {
          case 'create':
            createJplan(result);
            break;
          case 'delete':
            deleteJplan(result);
            break;
          case 'modify':
            editJplan(result);
            break;
          case 'edit start':
            checkStartEditorJplan(result);
            break;
          case 'edit finish':
            endStartEditorJplan(result);
            break;
          case 'swap':
            swapJplan(result);
            break;
          case 'wait':
            waitEditorJplan(result);
            break;
          default:
            print("Unknown command");
            break;
        }
      },
    );
  }
  /// 순서 변경 클릭
  Future<void> addEditor(int day) async {
    try {
      stompClient!.send(
        destination: '/api/trip/${ts.selectTripList[0]['id']}/plan/j/${day}/edit/register',
      );
    } catch (e) {
      print('Error sending message: $e');
    }
  }
  ///추가 할 때 함수
  Future<void> createJplan(Map<String, dynamic> result) async {
    /// 현재 위치한 시간이랑 같을 때
    if ((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
      /// 하나의 리스트가 들어있을 때
      if (js.jPlanList.isNotEmpty) {
        int insertIndex = js.jPlanList[0]['planList'].length;
        for (int i = 0; i < js.jPlanList[0]['planList'].length; i++) {
          if (js.jPlanList[0]['planList'][i]['startTime'].compareTo(result['data']['startTime']) > 0) {
            insertIndex = i;
            break;
          }
        }
        js.jPlanList[0]['planList'].insert(insertIndex, result['data']);
        if (result['data']['latitude'] != null && result['data']['longitude'] != null) {
          js.jPlanMarkerSet();
        };
        js.jPlanList.refresh();
      } else {
        js.jPlanList.add({
          'dayAfterStart': result['data']['dayAfterStart'],
          'planList': [result['data']]
        });
        if (result['data']['latitude'] != null && result['data']['longitude'] != null) {
          js.jPlanMarkerSet();
        };
      }
    }
  }
  /// 삭제 할 때 함수
  Future<void> deleteJplan(Map<String, dynamic> result) async {
    /// 현재 위치한 시간이랑 같을 때
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['dayAfterStart']) {
      js.jPlanList[0]['planList'].removeWhere((item) => item['planId'] == result['data']['planId']);
      js.jPlanMarkerSet();
    }
  }
  /// 수정 할 때 함수
  Future<void> editJplan(Map<String, dynamic> result) async {
    /// 일정의 날짜를 수정할 때 ( 다른 날짜로 이동할 때 )
    if(js.jPlanList[0]['dayAfterStart']!=result['data']['dayAfterStart']){
      js.jPlanList.forEach((dayData) {
        dayData['planList'].removeWhere((plan) => plan['planId'] == result['data']['planId']);
      });
      js.jPlanList.refresh();
    }
    /// 같은 날짜 일 때
    else if((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
      bool duplicateCheck = false;
      for(int i=0;i<js.jPlanList[0]['planList'].length;i++){
        /// 만약 같으면
        if(js.jPlanList[0]['planList'][i]['planId'] == result['data']['planId']){
          duplicateCheck = true;
          js.jPlanList[0]['planList'][i] = result['data'];
          if(result['data']['latitude'] != null && result['data']['longitude'] != null){
            js.jPlanMarkerSet();
          }
          break;
        }
      }
      /// 하나라도 일치 안하면 추가 된 것
      if(!duplicateCheck){
        int insertIndex = js.jPlanList[0]['planList'].length;
        for (int i = 0; i < js.jPlanList[0]['planList'].length; i++) {
          if (js.jPlanList[0]['planList'][i]['startTime'].compareTo(result['data']['startTime']) > 0) {
            insertIndex = i;
            break;
          }
        }
        js.jPlanList[0]['planList'].insert(insertIndex, result['data']);
        if(result['data']['latitude'] != null && result['data']['longitude'] != null){
          js.jPlanMarkerSet();
        }
        js.jPlanList.refresh();
      }
    }
  }
  /// 스왑 할 때 함수
  Future<void> swapJplan(Map<String, dynamic> result) async {
    if ((js.selectedIdx.value) + 1 == result['data'][0]['dayAfterStart']) {
      js.jPlanList.value = result['data'];
      js.jPlanList.forEach((day) {
        day['waitList']=[];
        day['checked'] = true;
      });
      js.jPlanMarkerSet();
    }
  }
  /// 편집 권한 체크 시작
  Future<void> checkStartEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {
        if(us.userList[0].uuid!=result['data']['editorUuid']){
          js.jPlanList[0]['waitList'] = result['data'];
          js.jPlanList.refresh();
        }
    }
  }
  /// 편집 권한 체크 종료
  Future<void> endStartEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {
      js.jPlanList[0]['waitList'] = [];
      js.jPlanList.refresh();
    }
  }
  /// 누가 편집중 일 때
  Future<void> waitEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {
      if(us.userList[0].uuid!=result['data']['editorUuid']){
        js.jPlanList[0]['waitList'] = result['data'];
      }
    }
  }
  /// p형 소켓
  void pOnConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/api/trip/p/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);

        switch (result['command']) {
          case 'create':
            createPPlan(result);
            break;
          case 'check' :
            checkPPlan(result);
            break;
          case 'delete' :
            deletePPlan(result);
            break;
          case 'modify' :
            editPPlan(result);
            break;
          case 'edit start' :
            checkStartEditorPPlan(result);
            break;
          case 'edit finish':
            endStartEditorPPlan(result);
            break;
          case 'move':
            movePPlan(result);
            break;
          case 'wait':
            waitEditorPPlan(result);
            break;
          default:
            print("Unknown command");
            break;
        }
      },
    );
  }
  /// p형 추가 할 때 함수
  Future<void> createPPlan(Map<String, dynamic> result) async {
    int week = ((result['data']['dayAfterStart'] - 1) ~/ 7) + 1;      // 주차 계산
    int dayIndex = (result['data']['dayAfterStart'] - 1) % 7;
    /// 현재 선택한 week와 같을때
    if(ps.selectedWeekIdx.value == week){
      ps.pPlanList[0]['dayList'][dayIndex]['planList'].add(result['data']);
      ps.pPlanList.refresh();
    }
  }
  /// p형 수정 할 때 함수
  Future<void> editPPlan(Map<String, dynamic> result) async{
    int week = ((result['data']['dayAfterStart'] - 1) ~/ 7) + 1;
    int dayIndex = (result['data']['dayAfterStart'] - 1) % 7;
    int targetPlanId = result['data']['planId'];
    /// 현재 선택한 week와 같을때
    if(ps.selectedWeekIdx.value == week){
      final planIndex = ps.pPlanList[0]['dayList'][dayIndex]['planList'].indexWhere((plan) => plan['planId'] == targetPlanId);

      ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['content'] = result['data']['content'];
      ps.pPlanList.refresh();

    }
  }
  /// p형 체크박스 클릭 함수
  Future<void> checkPPlan(Map<String, dynamic> result) async{
    int targetPlanId = result['data']['planId'];
    int week = ((result['data']['dayAfterStart'] - 1) ~/ 7) + 1;
    int dayIndex = (result['data']['dayAfterStart'] - 1) % 7;
    /// 현재 선택한 week와 같을때
    if(ps.selectedWeekIdx.value == week){
      final planIndex = ps.pPlanList[0]['dayList'][dayIndex]['planList'].indexWhere((plan) => plan['planId'] == targetPlanId);
      ps.pPlanList[0]['dayList'][dayIndex]['planList'][planIndex]['checkbox'] = result['data']['checkbox'];
      ps.pPlanList.refresh();
    }
  }
  /// p형 삭제 할 때 함수
  Future<void> deletePPlan(Map<String, dynamic> result) async{
    int targetPlanId = result['data']['planId'];
    int week = ((result['data']['dayAfterStart'] - 1) ~/ 7) + 1;
    int dayIndex = (result['data']['dayAfterStart'] - 1) % 7;
    /// 현재 선택한 week와 같을때
    if(ps.selectedWeekIdx.value == week){
      final planIndex = ps.pPlanList[0]['dayList'][dayIndex]['planList'].indexWhere((plan) => plan['planId'] == targetPlanId);
      ps.pPlanList[0]['dayList'][dayIndex]['planList'].removeAt(planIndex);
      ps.pPlanList.refresh();
    }
  }

  /// p형 순서 변경 요청
 Future<void> pAddEditor(int week) async {

    try {
      stompClient!.send(
        destination: '/api/trip/${ts.selectTripList[0]['id']}/plan/p/${week}/edit/register',
      );
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  /// p형 편집 권한 체크 시작
  Future<void> checkStartEditorPPlan(Map<String, dynamic> result) async {
    if (ps.pPlanList[0]['week'] == result['data']['week']) {
      if(us.userList[0].uuid!=result['data']['uuid']){
        ps.pPlanList[0]['waitList'] = result['data'];
        ps.pPlanList.refresh();
      }
    }
  }
  /// p형 편집 종료
  Future<void> endStartEditorPPlan(Map<String, dynamic> result) async {
    if (ps.pPlanList[0]['week'] == result['data']['week']) {
      ps.pPlanList[0]['waitList'] = [];
      ps.pPlanList.refresh();
    }
  }

  Future<void> movePPlan(Map<String, dynamic> result) async {

    if(ps.selectedWeekIdx.value == result['data']['week']){
      List allData = [result['data']];
      List filterData = [];
      int dayIdx = (ps.selectedWeekIdx.value*7)<=ps.totalDays.value? 7: ps.totalDays.value-((ps.selectedWeekIdx.value-1)*7);
      for(int i = 1; i<=dayIdx; i++){
        int startIdx = ((ps.selectedWeekIdx.value-1)*7)+i;
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
      ps.pPlanList.value = allData;

      ps.pPlanList.refresh();
    }
  }
  /// 누가 편집중 일 때
  Future<void> waitEditorPPlan(Map<String, dynamic> result) async {
    if (ps.pPlanList[0]['week'] == result['data']['week']) {
      if(us.userList[0].uuid!=result['data']['uuid']){
        ps.pPlanList[0]['waitList'] = result['data'];
      }
    }
  }
}

