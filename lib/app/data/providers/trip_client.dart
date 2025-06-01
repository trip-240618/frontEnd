import 'package:dio/dio.dart';
import 'package:tripStory/app/config/dio_client.dart';

class ApiTripClient {
  final Dio _dio;

  ApiTripClient(DioClient dioClient) : _dio = dioClient.dio;

  Future<List<dynamic>> inComingTripGet() async {
    final response = await _dio.get('/trip/incoming');
    return response.data;
  }

  Future<List<dynamic>> lastTripGet() async {
    final response = await _dio.get('/trip/last');
    return response.data;
  }

  Future<List<dynamic>> bookMarkTripGet() async {
    final response = await _dio.get('/trip/bookmarked');
    return response.data;
  }
}
