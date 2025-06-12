import 'package:dio/dio.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/models/trip_room.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/models/trip_room_create_response.dart';

class TripClient {
  final Dio _dio;

  TripClient(DioClient dioClient) : _dio = dioClient.dio;

  Future<List<dynamic>> inComingTripGet() async {
    final response = await _dio.get('/trip/list/incoming');
    return response.data;
  }

  Future<List<dynamic>> lastTripGet() async {
    final response = await _dio.get('/trip/list/last');
    return response.data;
  }

  Future<List<dynamic>> bookMarkTripGet() async {
    final response = await _dio.get('/trip/list/bookmark');
    return response.data;
  }

  Future<bool> updateBookMark(int tripId) async {
    final response = await _dio.put('/trip/bookmark/toggle?tripId=$tripId');
    return response.data;
  }

  Future<TripRoomCreateResponse> postCreateTrip(
    TripRoomCreateRequest request,
  ) async {
    final response = await _dio.post("/trip/create", data: request.toJson());

    return TripRoomCreateResponse.fromJson(response.data);
  }

  Future<TripRoom> getEnterTrip(
    int tripId,
  ) async {
    final response = await _dio.get(
      "/trip/enter",
      queryParameters: {
        "tripId": tripId,
      },
    );
    return TripRoom.fromJson(response.data);
  }
}
