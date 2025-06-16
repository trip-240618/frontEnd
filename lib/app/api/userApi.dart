import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/data/network/dio_client.dart';

import '../../model/userModel.dart';

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
        if (data['type'] != 'register') {
          us.userList.value = [UserModel.fromJson(data)];
        } else {
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
      final response = await dioClient.dio.put('/user/update/fcmToken');
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
      final response = await dioClient.dio.put('/user/update/fcmToken?fcmToken=$token');
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
  Future<Map<String, dynamic>> userRegister(
      String nickName, String memo, String profileImg, String thumbnailImg, bool marketing) async {
    try {
      final response = await dioClient.dio.put('/user/register', data: {
        'nickname': '${nickName}',
        'memo': memo,
        'profileImg': '${profileImg}',
        'thumbnail': '${thumbnailImg}',
        "marketing": marketing
      });
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
  Future<Map<String, dynamic>> userModify(String nickName, String memo, String thumbnailImg, String profileImg) async {
    final us = Get.put(UserState());
    try {
      final response = await dioClient.dio.put('/user/modify', data: {
        "nickname": "${nickName}",
        "memo": "${memo}",
        "thumbnail": "${thumbnailImg}",
        "profileImg": "${profileImg}"
      });
      if (response.statusCode == 200) {
        final data = response.data;
        us.userList.value = [UserModel.fromJson(data)];
        us.userList.refresh();
        return data;
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

  /// 최신 버전 가져오기
  Future<void> getVersionList() async {
    final us = Get.put(UserState());
    try {
      final response = await http.get(
        Uri.parse('https://trip-story.site/version/last'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      us.versionList.value = jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
