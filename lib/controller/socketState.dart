import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'jPlanState.dart';

class SocketState extends GetxController{
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  final js = Get.put(JPlanState());
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
          onConnect: onConnect,
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
            if ((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
              int insertIndex = js.jPlanList[0]['planList'].length;
              for (int i = 0; i < js.jPlanList[0]['planList'].length; i++) {
                if (js.jPlanList[0]['planList'][i]['startTime'].compareTo(result['data']['startTime']) > 0) {
                  insertIndex = i;
                  break;
                }
              }
              js.jPlanList[0]['planList'].insert(insertIndex, result['data']);
            }
            break;
          case 'modify':
            if ((js.selectedIdx.value) + 1 == result['data']['dayAfterStart']) {
              for(int i=0;i<js.jPlanList[0]['planList'].length;i++){
                if(js.jPlanList[0]['planList'][i]['planId'] == result['data']['planId']){
                  js.jPlanList[0]['planList'][i] = result['data'];
                }
              }
          }
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


  @override
  void onClose()async{
    stompClient!.deactivate();
    super.onClose();
  }

}