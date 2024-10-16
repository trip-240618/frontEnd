import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import '../util/custom_marker.dart';
import 'jPlanState.dart';
import 'pPlanState.dart';

class SocketState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final js = Get.put(JPlanState());
  final ps = Get.put(PPlanState());
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

  void onConnect(StompFrame frame) {
    print('Connected to WebSocket');
    stompClient!.subscribe(
      destination: '/topic/api/trip/j/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print('??소켓으로 받은 데이터  ${result}');
        switch (result['command']) {
          case 'create':
            addData(result);
            break;
          case 'modify':
            if ((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
              for(int i=0;i<js.jPlanList[0]['planList'].length;i++){
                if(js.jPlanList[0]['planList'][i]['planId'] == result['data']['planId']){
                  js.jPlanList[0]['planList'][i] = result['data'];
                }
              }
          }
            break;
          case 'edit start':
            if ((js.selectedIdx.value) + 1 == result['data']['day']) {
              js.jPlanList[0]['checked'] = false;
              print('수정 스타트${js.jPlanList}');
          }
            break;
          case 'edit finish':
            if ((js.selectedIdx.value) + 1 == result['data']['day']) {
              js.jPlanList[0]['checked'] = true;
              print('수정 끝 ${js.jPlanList}');
            }
            break;
          case 'swap':
            if ((js.selectedIdx.value) + 1 == result['data'][0]['dayAfterStart']) {
              print('스왑해서 보내준 데이터 ${result['data']}');
              js.jPlanList.value = result['data'];
            }
            break;
          default:
            print("Unknown command");
            break;
        }
      },
    );
  }

  void addEditor(int day) async {
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
  Future<void> addData(Map<String, dynamic> result) async {
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
          final icon = await getCustomIcon2(insertIndex + 1);
          final marker = Marker(
            markerId: MarkerId(DateTime.now().toString()), // 고유 마커 ID
            position: LatLng(result['data']['latitude'], result['data']['longitude']),
            icon: icon,
            onTap: () {},
          );
          js.markers.add(marker);
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
  @override
  void onClose()async{
    stompClient!.deactivate();
    super.onClose();
  }

  void pOnConnect(StompFrame frame) {
    print('Connected to P type WebSocket');
    stompClient!.subscribe(
      destination: '/topic/api/trip/p/${ts.selectTripList[0]['id']}',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print('??P 소켓으로 받은 데이터  ${result}');
        switch (result['command']) {
          case 'create':
            print('생성하는 dayAfterStart? ${result['data']['dayAfterStart']}');
            int insertDayIndex = result['data']['dayAfterStart']-1;
            ps.pPlanList[insertDayIndex]['planList'].add(result['data']);
            print('p create');
            break;
          default:
            print("Unknown command");
            break;
        }
      },
    );
  }

}