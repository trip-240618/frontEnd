import 'package:get/get.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/providers/trip_client.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/data/repositories/trip_repository_impl.dart';
import 'package:tripStory/view/hoom/controller/trip_rooms_create_controller.dart';

class TripRoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRepository>(() => TripRepositoryImpl(TripClient(DioClient())));
    Get.lazyPut<TripRoomsCreateController>(() => TripRoomsCreateController(Get.find()));
  }
}
