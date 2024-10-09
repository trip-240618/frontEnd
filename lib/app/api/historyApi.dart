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

  /// 여행 기록 디테일 가져오기
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
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 여행 기록 디테일 가져오기
  Future<List> getDetailHistoryCommentList(int tripId,int historyId) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/history/${historyId}/reply/list'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('댓글 목록 ${data}');
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

  /// 여행 좋아요 토글
  Future<void> historyListToggle(int tripId,int historyId) async {
    try {
      final response = await dioClient.dio.put(
          '/trip/${tripId}/history/${historyId}/like'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('좋아요 ${data}');
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 여행 댓글 작성
  Future<List> addHistoryComment(int tripId,int historyId,String content) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/${tripId}/history/${historyId}/reply/create',data: {
          "content": content
        }
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

  /// 여행 댓글 수정
  Future<List> editHistoryComment(int tripId,int historyId,int replyId,String content) async {
    try {
      final response = await dioClient.dio.put(
          '/trip/${tripId}/history/${historyId}/reply/modify',data: {
            "replyId": replyId,
            "content": "${content}"
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('수정됨 ${data}');
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

  /// 여행 댓글 삭제
  Future<List> deleteHistoryComment(int tripId,int historyId,int replyId) async {
    try {
      final response = await dioClient.dio.delete(
          '/trip/${tripId}/history/${historyId}/reply/delete?replyId=$replyId'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('댓글 삭제됨${data}');
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

  /// 태그 전체 목록 가져오기
  Future<List> getTagAll(int tripId) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/${tripId}/history/tags'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('dadasd? ${data}');
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
