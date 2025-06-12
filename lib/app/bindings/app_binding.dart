import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/providers/file_client.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient());
    Get.put<TripClient>(TripClient(DioClient().dio));
    Get.put<FileClient>(FileClient(DioClient().dio));
  }
}
