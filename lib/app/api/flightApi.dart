import 'package:get/get.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';

import '../../data/network/dio_client.dart';

class ApiFlightClient {
  final DioClient dioClient;

  ApiFlightClient(this.dioClient);

  /// 등록한 항공권 가져오기
  Future<List<dynamic>> flightGet() async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.get('/flight/trip/${ts.selectTripList[0]['id']}/list');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {
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

  /// 항공권 조회
  Future<List<dynamic>> flightSearch(int flightNumber, String carrierCode) async {
    final js = Get.put(JPlanState());
    try {
      final response = await dioClient.dio.get(
          '/flight/search?flightNumber=${flightNumber}&carrierCode=${carrierCode}&departureDate=${js.selectedDate}');
      if (response.statusCode == 200) {
        final data = response.data;

        if (data.length == 0) {
          return [];
        }
        return [data];
      } else {
        throw Exception('Failed to flight-get: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-get: $e');
      return [];
    }
  }

  Future<void> flightDelete() async {
    final ts = Get.put(TripState());
    final js = Get.put(JPlanState());
    try {
      final response = await dioClient.dio
          .delete('/flight/trip/${ts.selectTripList[0]['id']}/delete?flightId=${js.flightList[0]['flightId']}');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {}
      } else {
        throw Exception('Failed to flight-delete: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during flight-delete: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> flightCreate(
    String airlineCode,
    int airlineNumber,
    String departureDate,
    String departureAirport,
    String departureAirport_kr,
    String arrivalDate,
    String arrivalAirport,
    String arrivalAirport_kr,
  ) async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.post('/flight/trip/${ts.selectTripList[0]['id']}/create', data: {
        "airlineCode": '${airlineCode}',
        "airlineNumber": airlineNumber,
        "departureDate": '${departureDate}',
        "departureAirport": '${departureAirport}',
        "departureAirport_kr": '${departureAirport_kr}',
        "arrivalDate": '${arrivalDate}',
        "arrivalAirport": '${arrivalAirport}',
        "arrivalAirport_kr": '${arrivalAirport_kr}'
      });
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.length == 0) {
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
}
