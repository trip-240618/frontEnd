import 'package:tripStory/app/config/dio_client.dart';

class ApiPPlanClient {
  final DioClient dioClient;

  ApiPPlanClient(this.dioClient);
  /// p 일정 가져오기
  Future<List<dynamic>> getPPlanList(int tripId,bool locker) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/p/list?locker=$locker'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?${data}');
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to get PPlanList: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// P 추가하기
  Future<List<dynamic>> addPPlanList(int tripId, String content, int dayAfterStart, bool locker) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/${tripId}/plan/p/create',
          data: {
            "content":'${content}',
            "dayAfterStart": dayAfterStart,
            "locker": locker
          });
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?${data}');
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to add PPlanList: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

}