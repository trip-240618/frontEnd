import 'package:get/get.dart';

import '../../controller/tripState.dart';
import '../config/dio_client.dart';

class ApiReportClient {
  final DioClient dioClient;
  ApiReportClient(this.dioClient);

  /// 신고 하기
  Future<void> createReport(String type, int tripId, int historyId, int typeId)async{
    try {
      final response =
      type == 'reply'&& historyId != 0?
      await dioClient.dio.post('/report/create?type=$type&tripId=$tripId&typeId=$typeId'):
      await dioClient.dio.post('/report/create?type=$type&tripId=$tripId&historyId=$historyId&typeId=$typeId');

      if (response.statusCode == 200) {
        final data = response.data;
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