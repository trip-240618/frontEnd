import 'package:get/get.dart';
import 'package:tripStory/presentation/trip/controllers/history_main_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistoryMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryMainController>(
      () => HistoryMainController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
