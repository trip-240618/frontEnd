import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../config/dio_client.dart';

class ApiFlightClient{
  final DioClient dioClient;

  ApiFlightClient(this.dioClient);
  /// 등록한 항공권 가져오기
  Future<List<dynamic>> flightGet() async {
    final ts = Get.put(TripState());
    try {
      final response = await dioClient.dio.post('/flight/${ts.selectTripList[0]['id']}/flight/list');
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

  /// 항공권 조회 및 등록
  Future<List<dynamic>> flightSearch() async {
    int flightNumber = 703;
    String carrierCode = 'KE';
    String departureDate = '2024-10-07';
    final ts = Get.put(TripState());
    print('id?');
    print(ts.selectTripList[0]['id']);
    try {
      final response = await dioClient.dio.post(
          '/flight/${ts.selectTripList[0]['id']}/flight/create?flightNumber=${flightNumber}&carrierCode=${carrierCode}&departureDate=${departureDate}'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print('항공권???${data}');
        if(data.length==0){
          print('항공권 없나??????${data}');
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



}