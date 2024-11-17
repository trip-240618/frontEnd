import 'dart:convert';

import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';

import '../app/api/reportApi.dart';
import '../app/config/dio_client.dart';

class ReportState extends GetxController {
  final ts = Get.put(TripState());
  final apiReportClient = ApiReportClient(DioClient());
  /// 신고하기
  Future<void> addReport(String type, int? historyId, int typeId)async{
    await apiReportClient.createReport(type, ts.selectTripList[0]['id'],historyId == null?0:historyId,typeId);
  }
}