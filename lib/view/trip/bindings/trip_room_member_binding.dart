import 'package:get/get.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/trip_room_member_controller.dart';

class TripRoomMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRoomMemberController>(
      () => TripRoomMemberController(
        Get.find<TripRoomService>(),
        Get.find<LoginUserService>(),
      ),
    );
  }
}
