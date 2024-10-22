import 'package:tripStory/app/config/dio_client.dart';

class ApiPPlanClient {
  final DioClient dioClient;

  ApiPPlanClient(this.dioClient);
  /// p 일정 가져오기
  Future<List<dynamic>> getPPlanList(int tripId,int week, bool locker) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/p/list?week?=$week&locker=$locker'
      );
      if (response.statusCode == 200) {
        final data = response.data;
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
  Future<void> addPPlanList(int tripId, String content, int dayAfterStart, bool locker) async {
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

      } else {
        throw Exception('Failed to add PPlanList: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// P check
  Future<void> checkPPlan(int tripId, int planId) async{
    try{
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/p/check?planId=$planId');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// P delete
  Future<void> deletePPlan(int tripId, int planId, int day) async{
    try{
      final response = await dioClient.dio.delete(
          '/trip/${tripId}/plan/p/delete?planId=$planId&day=$day');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

}