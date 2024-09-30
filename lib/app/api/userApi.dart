import 'dart:convert';
import 'package:dio/dio.dart';
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
        us.userList.value = [data];
        print('data??? ${us.userList.value}');
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 로그아웃
  Future<void> logOut() async {
    final us = Get.put(UserState());
    try {
      us.userList.clear();
      dioClient.deleteCookies();
      // final response = await dioClient.dio.get(
      //   '/user/info',
      // );
      // if (response.statusCode == 200) {
      //   final data = response.data;
      //   us.userList.value = [data];
      //   print('data??? ${us.userList.value}');
      //   return data;
      // } else {
      //   throw Exception('Failed to auto-login: ${response.statusCode}');
      // }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }


  /// 유저 정보 디테일
  Future<Map<String, dynamic>> userModify(String nickName,String profileImg,String thumbnailImg,bool marketing) async {
    final us = Get.put(UserState());
    try {
      print('dasdasda ${marketing}');
      final response = await dioClient.dio.put(
        '/user/register',
        data: {
          'nickname':'${nickName}',
          'memo':'ㅇㅁㄴㅇ',
          'profileImg':'${profileImg}',
          'thumbnail':'${thumbnailImg}',
          "marketing": marketing
        }
      );
      if (response.statusCode == 200) {
        final data = response.data;
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
