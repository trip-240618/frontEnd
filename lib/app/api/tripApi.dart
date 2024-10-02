import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/userState.dart';

class ApiTripClient {
  final DioClient dioClient;

  ApiTripClient(this.dioClient);

  /// 여행 가져오기
  Future<List<dynamic>> inComingTripGet() async {
    try {
      final response = await dioClient.dio.get('/trip/list/incoming?sortField=startDate&sortDirection=DESC');
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
  /// 여행방 생성하기
  /// 유저 정보 디테일
  Future<String> tripCreate(
      String thumnail,
      String name,
      String labelColor,
      String type,
      String startDate,
      String endDate,
      String country,
      ) async {
    try {
      print('??? ${startDate.toString().split(' ')[0]}');
      final response = await dioClient.dio.post(
          '/trip/create',
          data:
          {
            'name':'${name}',
            'type':type=='J형'?'J':'P',
            'startDate':'${startDate.toString().split(' ')[0]}',
            "endDate": '${endDate.toString().split(' ')[0]}',
            "country": '${country}',
            "thumbnail": '${thumnail}',
            "labelColor": '${labelColor.substring(6, labelColor.length - 1)}',
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data??? ${data}');
        return data['invitationCode'];
      } else {
        throw Exception('Failed to auto-login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 주소 자동 완성
  Future<List<dynamic>> autoLocationGet(String place) async {
    try {
      final response = await dioClient.dio.get(
          '/trip/location/autocomplete',
        data: {
          "input": '${place}',
          "languageCode": "ko",
        });
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to autoLocation: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during autoLocation: $e');
      rethrow;
    }
  }

  /// lat,lng 포함된 세부적인 장소 정보 검색
  Future<List<dynamic>> detailLocationGet(String placeId) async {
    try {
      final response = await dioClient.dio.get('/trip/location/place/$placeId');
      if (response.statusCode == 200) {
        final data = response.data;
        print('받은 자세한 데이터?${[data]}');
        List test = [data];
        print('형태는?${test[0]['location']['latitude']}');
        if(data.length==0){
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to detailLocation: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during detailLocation: $e');
      rethrow;
    }
  }


}
