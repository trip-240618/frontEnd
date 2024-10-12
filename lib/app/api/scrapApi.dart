import 'package:get/get.dart';

import '../../controller/tripState.dart';
import '../config/dio_client.dart';

class ApiScrapClient{
  final DioClient dioClient;

  ApiScrapClient(this.dioClient);

  /// 스크랩 생성
  Future<List<dynamic>> createScrap(
      String title,
      String content,
      bool hasImage,
      String color,
      List photoList,
      )async{
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.post('/trip/${ts.selectTripList[0]['id']}/scrap/create',
          data: {
            "title": '${title}',
            "content": '${content}',
            "hasImage": '${hasImage}',
            "color": '${color.substring(6, color.length - 1)}',
            "photoList": photoList,
          }
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data??${data}');
        if(data.length==0){
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to flight-delete: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-delete: $e');
      rethrow;
    }
  }

  /// 스크랩 가져오기
  Future<List<dynamic>> getScrap() async{
    final ts = Get.put(TripState());
    print('id??${{ts.selectTripList[0]['id']}}');
    try {
      final response = await dioClient.dio.get('/trip/${ts.selectTripList[0]['id']}/scrap/list');
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to flight-get: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-get: $e');
      rethrow;
    }
  }

  /// 선택한 스크랩 리스드 가져오기
  Future<List<dynamic>> getSelectScrap(int scrapId) async{
    final ts = Get.put(TripState());
    print('scrapId??${scrapId}');
    try {
      final response = await dioClient.dio.get('/trip/${ts.selectTripList[0]['id']}/scrap/detail/${scrapId}');
      if (response.statusCode == 200) {

        final data = response.data;
        print('data???${data}');
        if(data.length==0){
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to flight-get: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-get: $e');
      rethrow;
    }
  }


  /// 스크랩 북마크 클릭
  Future<void> clickScrapBookmark(int scrapId) async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.post(
        '/trip/${ts.selectTripList[0]['id']}/scrap/bookmark/toggle?scrapId=${scrapId}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?? ${data}');
      } else {
        throw Exception('error ${response.statusCode}');
      }
    } catch (e) {
      print('Error during click-scrapBookmark: $e');
      rethrow;
    }
  }

  /// 스크랩 북마크 목록
  Future<List<dynamic>> getScrapBookmark() async{
    final ts = Get.put(TripState());
    print('id??${{ts.selectTripList[0]['id']}}');
    try {
      final response = await dioClient.dio.get('/trip/${ts.selectTripList[0]['id']}/scrap/bookmark/list');
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('Failed to get-scrapBookmark: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during get-scrapBookmark: $e');
      rethrow;
    }
  }

  /// 스크랩 삭제
  Future<void> deleteScrap(int scrapId)async{
    print(scrapId);
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.delete(
          '/trip/${ts.selectTripList[0]['id']}/scrap/delete?scrapId=${scrapId}'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('data?${data}');
        if(data.length==0){
        }
      } else {
        throw Exception('Failed to flight-delete: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-delete: $e');
      rethrow;
    }
  }


}