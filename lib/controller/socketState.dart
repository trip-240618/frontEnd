
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
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
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
    print('Connected to WebSocket');
    stompClient!.subscribe(
      destination: '/topic/api/trip/j/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print('??소켓으로 받은 데이터  ${result}');
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
    print('순서 변경 요청');
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
        if (result['data']['latitude'] != null && result['data']['longitude'] != null) {
          List<LatLng> poly = [];
          final icon = await getCustomIcon2(insertIndex + 1);
          final marker = Marker(
            markerId: MarkerId(DateTime.now().toString()), // 고유 마커 ID
            position: LatLng(result['data']['latitude'], result['data']['longitude']),
            icon: icon,
            onTap: () {},
          );
          js.markers.add(marker);
          js.jPlanList[0]['planList'].forEach((plan) {
            poly.add(LatLng(plan['latitude'], plan['longitude']));
          });
          poly.add(LatLng(result['data']['latitude'], result['data']['longitude']));
          if (poly.isNotEmpty) {
            js.polyline.add(
              Polyline(
                polylineId: PolylineId('polyline_1'),
                patterns: [PatternItem.dash(80), PatternItem.gap(30)],
                points: poly, // 전체 경로 좌표 리스트
                color: Color(ts.selectTripList[0]['labelColor']), // 경로 색상
                width: 3, // 경로 두께
              ),
            );
          }
        };
        js.jPlanList[0]['planList'].insert(insertIndex, result['data']);
        js.jPlanList.refresh();
      } else {
        js.jPlanList.add({
          'dayAfterStart': result['data']['dayAfterStart'],
          'planList': [result['data']]
        });
        final icon = await getCustomIcon2(1);
        if (result['data']['latitude'] != null && result['data']['longitude'] != null) {
          final marker = Marker(
            markerId: MarkerId(DateTime.now().toString()), // 고유 마커 ID
            position: LatLng(result['data']['latitude'], result['data']['longitude']),
            icon: icon,
            onTap: () {},
          );
          js.markers.add(marker);
        }
      }
    }
  }
  /// 삭제 할 때 함수
  Future<void> deleteJplan(Map<String, dynamic> result) async {
    /// 현재 위치한 시간이랑 같을 때
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['dayAfterStart']) {
      js.jPlanList[0]['planList'].removeWhere((item) => item['planId'] == result['data']['planId']);
      js.jplnaMarkerSet();
    }
  }
  /// 수정 할 때 함수
  Future<void> editJplan(Map<String, dynamic> result) async {
    if ((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
      for(int i=0;i<js.jPlanList[0]['planList'].length;i++){
        if(js.jPlanList[0]['planList'][i]['planId'] == result['data']['planId']){
          js.jPlanList[0]['planList'][i] = result['data'];
          if(result['data']['latitude'] != null && result['data']['longitude'] != null){
            js.jplnaMarkerSet();
          }
        }
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
      js.jplnaMarkerSet();
    }
  }
  /// 편집 권한 체크 시작
  Future<void> checkStartEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {
        if(us.userList[0]['uuid']!=result['data']['editorUuid']){
          js.jPlanList[0]['waitList'] = result['data'];
        }
    }
  }
  /// 편집 권한 체크 종료
  Future<void> endStartEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {
      js.jPlanList[0]['waitList'] = [];
    }
  }
  /// 누가 편집중 일 때
  Future<void> waitEditorJplan(Map<String, dynamic> result) async {
    if (js.jPlanList[0]['dayAfterStart'] == result['data']['day']) {

      if(us.userList[0]['uuid']!=result['data']['editorUuid']){
        js.jPlanList[0]['waitList'] = result['data'];
      }
    }
  }
  /// p형 소켓
  void pOnConnect(StompFrame frame) {
    print('Connected to P type WebSocket');
    stompClient!.subscribe(
      destination: '/topic/api/trip/p/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print('??P 소켓으로 받은 데이터  ${result}');
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

          default:
            print("Unknown command");
            break;
        }
      },
    );
  }


  Future<void> createPPlan(Map<String, dynamic> result) async {
    print('생성하는 dayAfterStart? ${result['data']['dayAfterStart']}');
    int insertDayIndex = result['data']['dayAfterStart']-1;
    ps.pPlanList[insertDayIndex]['planList'].add(result['data']);
    print('p create');
  }

  Future<void> checkPPlan(Map<String, dynamic> result) async{
    print('check? ${result}');
    int targetPlanId = result['data']['planId'];
    int dayAfterStart = result['data']['dayAfterStart'];

    final planIndex = ps.pPlanList[dayAfterStart-1]['planList'].indexWhere((plan) => plan['planId'] == targetPlanId);

    print('planIndex????${planIndex}');
    ps.pPlanList[dayAfterStart-1]['planList'][planIndex]['checkbox'] = result['data']['checkbox'];

    ps.pPlanList.refresh();
    print('p check');
  }

  Future<void> deletePPlan(Map<String, dynamic> result) async{
    print('delete? ${result}');
    int targetPlanId = result['data']['planId'];
    int dayAfterStart = result['data']['dayAfterStart'];

    final planIndex = ps.pPlanList[dayAfterStart-1]['planList'].indexWhere((plan) => plan['planId'] == targetPlanId);
    print('planIndex????${planIndex}');
    ps.pPlanList[dayAfterStart-1]['planList'].removeAt(planIndex);
    ps.pPlanList.refresh();
    print('p delete');
  }

}

