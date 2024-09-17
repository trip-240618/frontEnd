import '../config/dio_client.dart';

class ApiFileClient {
  final DioClient dioClient;

  ApiFileClient(this.dioClient);

  /// 파일 url 요청
  Future<Map<String, dynamic>> fileUrlGet(int count) async {
    try {
      final response = await dioClient.dio.get(
        '/file/request/url?prefix=profile&photoCnt=${count}'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      }else {
        throw Exception('failed');
      }
    } catch (e) {
      print('error : $e');
      rethrow;
    }
  }
}