import 'package:tripStory/app/config/dio_client.dart';


class ApiFaqClient {
  final DioClient dioClient;

  ApiFaqClient(this.dioClient);

  /// faq 가져오기
  Future<List> getFaqList(String type) async {
    try {
      final response = await dioClient.dio.get(
          type=='전체'?'/faq/list':'/faq/list?type=$type'
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

  /// faq 검색하기
  Future<List> searchFaqList(String text) async {
    try {
      final response = await dioClient.dio.get(
          '/faq/search?text=$text'
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

  /// faq 디테일 가져오기
  Future<Map> getFaqDetailList(int faqId) async {
    try {
      final response = await dioClient.dio.get(
          '/faq/detail/${faqId}'
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
}
