import 'package:get/get.dart';
import 'package:tripStory/app/api/tripApi.dart';
import 'package:tripStory/app/config/dio_client.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/data/repositories/trip_repository_impl.dart';
import 'package:tripStory/view/main/main_page/controller/rooms_controller.dart';

class RoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRepository>(() => TripRepositoryImpl(ApiTripClient(DioClient())));
    Get.lazyPut<RoomsController>(() => RoomsController(Get.find()));
  }
}
