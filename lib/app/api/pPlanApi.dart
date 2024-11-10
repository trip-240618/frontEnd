import 'package:tripStory/app/config/dio_client.dart';

class ApiPPlanClient {
  final DioClient dioClient;

  ApiPPlanClient(this.dioClient);
  /// p 일정 가져오기
  Future<List<dynamic>> getPPlanList(int tripId,int week, bool locker) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/p/list?week=$week&locker=$locker'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data???${data}');
        if(data.length==0){
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to get PPlanList: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// P 추가하기
  Future<void> addPPlanList(int tripId, Map data) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/${tripId}/plan/p/create',
          data: data);
      if (response.statusCode == 200) {
        final data = response.data;

      } else {
        throw Exception('Failed to add PPlanList: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// p edit
  Future<void> editPPlanList(int tripId, Map data) async{
    try{
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/p/modify',data: data
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

  /// P check
  Future<void> checkPPlan(int tripId, int planId) async{
    try{
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/p/check?planId=$planId');
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

  /// P delete
  Future<void> deletePPlan(int tripId, int planId, int day) async{
    try{
      final response = await dioClient.dio.delete('/trip/${tripId}/plan/p/delete?planId=$planId&day=$day');
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

  /// p 리오더블 취소
  Future<void> deleteReorderPPlan(int tripId,int week) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/p/${week}/edit/finish'
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

  Future<void> reorderPPlan(int tripId, Map data) async{
    try {
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/p/edit/move',data: data
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

  /// p PlanB 리스트 가져오기
  Future<List> getPlanBPList(int tripId,bool locker) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/plan/p/list?week=1&locker=$locker'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 일정에서 보관함, 혹은 보관함에서 일정으로 이동
  Future<void> lockerMovePPlanList(int tripId, Map data) async{
    try{
      final response = await dioClient.dio.put(
          '/trip/${tripId}/plan/p/locker/move',data: data
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

}