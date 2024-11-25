import 'package:tripStory/app/config/dio_client.dart';


class ApiNotificationClient {
  final DioClient dioClient;

  ApiNotificationClient(this.dioClient);

  /// 알림 기록 가져오기
  Future<List> getNotificationList(String title) async {
    try {
      final response = await dioClient.dio.get(
          title==''?'/notification/list':'/notification/list?title=$title'
      );
      if (response.statusCode == 200) {
        final data = response.data;

        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 단일 알림 체크
  Future<void> readNotification(int notificationId) async {
    try {
      final response = await dioClient.dio.put(
          '/notification/read?notificationId=$notificationId'
      );
      if (response.statusCode == 200) {
        final data = response.data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  ///알림 스위치 가져오기
  Future<Map> getNotificationSetting() async {
    try {
      final response = await dioClient.dio.get(
          '/notification/config'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return {};
        }
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  ///알림 스위치 변경하기
  Future<Map> changeNotificationSetting(Map maps) async {
    try {
      final response = await dioClient.dio.put(
          '/notification/config/modify',data: maps
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return {};
        }
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
}
