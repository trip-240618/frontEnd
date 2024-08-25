import 'package:dio/dio.dart';
import 'package:tripStory/app/config/dio_client.dart';

class ApiTestClient {
  final DioClient dioClient;

  ApiTestClient(this.dioClient);

  /// 백엔드 서버로 쿠키 전송
  Future<void> sendToTest() async {
    try {
      final response = await dioClient.dio.get(
        '/hc',
      );
      if (response.statusCode == 200) {
        print('서버 응답 데이터: ${response.data}');
      } else {
        print('서버에 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('서버에 요청하는 중 에러 발생: $e');
    }
  }
}
