import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';

class ApiTripClient {
  final DioClient dioClient;

  ApiTripClient(this.dioClient);

  /// 여행 가져오기
  Future<List<dynamic>> inComingTripGet() async {
    try {
      final response = await dioClient.dio.get('/trip/list/incoming');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
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
  /// 다가오는 여행 가져오기
  Future<List<dynamic>> lastTripGet() async {
    try {
      final response = await dioClient.dio.get('/trip/list/last');
      if (response.statusCode == 200) {
        final data = response.data;

        print('data?? ${data}');
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
  /// 북마크 여행 가져오기
  Future<List<dynamic>> bookMarkTripGet() async {
    try {
      final response = await dioClient.dio.get('/trip/list/bookmark');
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
  Future<Map<String,dynamic>> tripCreate(
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
        return data;
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
  Future<void> detailLocationGet(String placeId) async {
    final js = Get.put(JPlanState());
    try {
      final response = await dioClient.dio.get('/trip/location/place/$placeId');
      if (response.statusCode == 200) {
        final data = response.data;
        js.searchLocation.value = [data];
        js.searchLocation.refresh();
        if(data.length==0){
        }
      } else {
        throw Exception('Failed to detailLocation: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during detailLocation: $e');
      rethrow;
    }
  }

  /// 북마크 클릭
  Future<void> bookmarkClick(int tripId) async {
    try {
      final response = await dioClient.dio.put(
          '/trip/bookmark/toggle?tripId=${tripId}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 여행방 참여
  Future<void> tripJoin(String invitationCode) async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.post(
          '/trip/join?invitationCode=${invitationCode}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
  /// 여행방 입장
  Future<List<dynamic>> tripEnter(int tripId) async {
    try {
      final response = await dioClient.dio.post(
          '/trip/enter?tripId=${tripId}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
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
  /// 여행방 수정
  Future<void> tripModify(int tripId,String name,String thumbnail,String labelColor,String startDate,String endDate) async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.put(
          '/trip/modify?tripId=${tripId}',
          data: {
            "name": "${name}",
            "thumbnail": "${thumbnail}",
            "labelColor": '${labelColor.substring(6, labelColor.length - 1)}',
            "startDate": "${startDate}",
            "endDate": "${endDate}"
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        ts.selectTripList.value = [response.data];
        ts.selectTripList.refresh();
        print('data?? ${data}');
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }
}
