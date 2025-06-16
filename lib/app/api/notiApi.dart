import 'package:tripStory/data/network/dio_client.dart';

class ApiNotiClient {
  final DioClient dioClient;

  ApiNotiClient(this.dioClient);

  /// 공지사항 가져오기
  Future<List> getNotiList(String type) async {
    try {
      final response = await dioClient.dio.get(type == '전체' ? '/notice/list' : '/notice/list?type=$type');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {
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

  /// 공지사항 디테일 가져오기
  Future<Map> getDetailNotiList(int noticeId, String type) async {
    try {
      final response = await dioClient.dio.get('/notice/detail/${noticeId}?type=${type}');
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
