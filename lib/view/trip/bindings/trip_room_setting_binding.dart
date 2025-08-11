import 'package:get/get.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/trip_room_setting_controller.dart';

class TripRoomSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRoomSettingController>(
      () => TripRoomSettingController(
        Get.find<TripRoomService>(),
      ),
    );
  }
}
