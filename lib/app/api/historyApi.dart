import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';

class ApiHistoryClient {
  final DioClient dioClient;

  ApiHistoryClient(this.dioClient);

  /// 여행 기록 가져오기
  Future<List<Map<String, dynamic>>> getHistoryList(int tripId) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/history/list'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 여행 기록 업로드
  Future<List> addHistory(int tripId,List uploadList) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/${tripId}/history/create/many',data: {
            "historyCreateRequestDtos": uploadList
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data??? ${data}');
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

  /// 여형 기록 디테일 가져오기
  Future<Map<String,dynamic>> getDetailHistoryList(int tripId,int historyId) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/history/detail/${historyId}'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return {};
        }
        print('data??? ${data}');
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
