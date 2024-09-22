import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';

class ApiTripClient {
  final DioClient dioClient;

  ApiTripClient(this.dioClient);

  /// 여행 가져오기
  Future<Map<String, dynamic>> inComingTripGet() async {
    try {
      final response = await dioClient.dio.get('/trip/list/incoming?sortField=startDate&sortDirection=DESC');
      print('???Dad ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data??? ${data}');
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
  /// 여행방 생성하기
  /// 유저 정보 디테일
  Future<Map<String, dynamic>> tripCreate(
      String name,
      String type,
      String startDate,
      String endDate,
      String country,
      String thumnail,
      String labelColor
      ) async {
    final us = Get.put(UserState());
    try {
      final response = await dioClient.dio.post(
          '/trip/create',
          data: {
            'name':'${name}',
            'type':'${type}',
            'startDate':'${startDate}',
            "endDate": '${endDate}',
            "country": '${country}',
            "thumnail": '${thumnail}',
            "labelColor": '${labelColor}',
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
