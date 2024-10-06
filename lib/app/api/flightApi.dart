import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../config/dio_client.dart';

class ApiFlightClient{
  final DioClient dioClient;

  ApiFlightClient(this.dioClient);
  /// 항공권 가져오기
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


}