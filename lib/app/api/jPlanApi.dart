import 'package:tripStory/app/config/dio_client.dart';


class ApiJPlanClient {
  final DioClient dioClient;

  ApiJPlanClient(this.dioClient);

  /// j 일정 가져오기
  Future<List> getJPlanList(int tripId,int day,bool locker) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/j/list?day=$day&locker=$locker'
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

  /// j 추가하기
  Future<void> addJPlanList(int tripId,Map data) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/${tripId}/plan/j/create',data: data
      );
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

  /// j 스왑
  Future<void> swapJPlan(int tripId,Map data) async {
    try {
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/j/edit/swap',data: data
      );
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
  /// j 삭제
  Future<void> deleteJPlan(int tripId,int planId) async {
    try {
      final response = await dioClient.dio.delete(
          '/trip/${tripId}/plan/j/delete?planId=$planId'
      );
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
