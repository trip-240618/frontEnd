import 'package:tripStory/data/network/dio_client.dart';

class ApiNotificationClient {
  final DioClient dioClient;

  ApiNotificationClient(this.dioClient);

  /// 알림 기록 가져오기
  Future<List<Map<String, dynamic>>> getNotificationList(String title, int id) async {
    try {
      final response = await dioClient.dio
          .get(title == '' ? '/notification/list?id=${id}' : '/notification/list?id=${id}&title=$title');
      if (response.statusCode == 200) {
        final data = response.data as List;
        if (data.length == 0) {
          return [];
        }
        final notifications = data.map((e) => e as Map<String, dynamic>).toList();
        return notifications;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 홈 화면 용 카운트 체크
  Future<int> getNotificationCount() async {
    try {
      final response = await dioClient.dio.get('/notification/count');
      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 알림 삭제
  Future<void> deleteNotification(int notificationId) async {
    try {
      final response = await dioClient.dio.delete('/notification/delete?notificationId=$notificationId');
      if (response.statusCode == 200) {
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
      final response = await dioClient.dio.put('/notification/read?notificationId=$notificationId');
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

  /// 전체 알림 체크
  Future<void> readAllNotification() async {
    try {
      final response = await dioClient.dio.put('/notification/read/all');
      if (response.statusCode == 200) {
        final data = response.data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      return;
    }
  }

  ///알림 스위치 가져오기
  Future<Map> getNotificationSetting() async {
    try {
      final response = await dioClient.dio.get('/notification/config');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {
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
      final response = await dioClient.dio.put('/notification/config/modify', data: maps);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {
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
