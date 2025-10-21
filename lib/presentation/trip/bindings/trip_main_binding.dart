import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/j_socket_repository.dart';
import 'package:tripStory/domain/usecases/j_plan_connect_socket_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_main_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class TripMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JPlanConnectSocketUsecase(Get.find<JSocketRepository>()));
    Get.lazyPut<TripMainController>(
      () => TripMainController(
        Get.find<TripRoomService>(),
        Get.find<JPlanConnectSocketUsecase>(),
      ),
    );
  }
}
