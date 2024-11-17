import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';

class ApiUserClient {
  final DioClient dioClient;

  ApiUserClient(this.dioClient);


  /// 자동 로그인
  Future<void> autoLogin() async {
    final us = Get.put(UserState());
    try {
      final response = await dioClient.dio.get(
        '/user/info',
      );
      if (response.statusCode == 200) {
        final data = response.data;

        if(data['type']!='register'){
          us.userList.value = [data];
        }else{
          us.userList.clear();
        }
      }
    } catch (e) {
      print('Error during auto-login: $e');
      us.userList.clear();
    }
  }
  /// 로그아웃
  Future<void> logOut() async {
    final us = Get.put(UserState());
    try {
      final response = await dioClient.dio.put(
          '/user/update/fcmToken'
      );
      us.userList.clear();
      dioClient.deleteCookies();
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 토큰 업데이트
  Future<void> updateToken(String token) async {
    try {
      final response = await dioClient.dio.put(
          '/user/update/fcmToken?fcmToken=$token'
      );
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 유저 삭제
  Future<void> userDelete() async {
    final us = Get.put(UserState());
    try {
      final response = await dioClient.dio.delete(
        '/user/delete/account',
      );
      us.userList.clear();
      dioClient.deleteCookies();
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 유저 정보 디테일
  Future<Map<String, dynamic>> userRegister(String nickName,String memo,String profileImg,String thumbnailImg,bool marketing) async {
    try {
      final response = await dioClient.dio.put(
        '/user/register',
        data: {
          'nickname':'${nickName}',
          'memo':memo,
          'profileImg':'${profileImg}',
          'thumbnail':'${thumbnailImg}',
          "marketing": marketing
        }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 유저 정보 수정
  Future<Map<String, dynamic>> userModify(String nickName,String memo,String thumbnailImg,String profileImg) async {
    final us = Get.put(UserState());
    try {
      print('??? ${nickName}');
      print('??? ${memo}');
      print('??? ${thumbnailImg}');
      print('??? ${profileImg}');
      final response = await dioClient.dio.put(
          '/user/modify',
          data:{
            "nickname": "${nickName}",
            "memo": "${memo}",
            "thumbnail": "${thumbnailImg}",
            "profileImg": "${profileImg}"
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        us.userList.value = [data];
        us.userList.refresh();
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

  /// 자동 로그인
  Future<void> alimTest() async {
    final us = Get.put(UserState());
    try {
      String token ='emwtUZuJG0FrtbysU0sMxv:APA91bGyoUGtmG_DQXiDG0RQmchnvuSKUvgGH3VLophlpVa3RHbiH7XtMG67cuquhADmqdysCZ2zbllZtyTcWySkFBMesGzW258fQJddGoQqOFY1bLnjX6R9Ki6wboAVO3Y2hMeUfGIR';
      final response = await dioClient.dio.post(
        '/fcm/test/send?fcmToken=$token'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('타입? ${data}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      us.userList.clear();
    }
  }
}
