import 'package:tripStory/app/config/dio_client.dart';


class ApiNotificationClient {
  final DioClient dioClient;

  ApiNotificationClient(this.dioClient);

  /// 알림 기록 가져오기
  Future<List> getNotificationList(String title) async {
    try {
      final response = await dioClient.dio.get(
        '/notification/list?title=$title'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
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

}
