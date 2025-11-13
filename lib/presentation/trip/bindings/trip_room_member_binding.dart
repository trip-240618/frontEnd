import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/kick_member_usecase.dart';
import 'package:tripStory/domain/usecases/leave_trip_room_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_member_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class TripRoomMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveTripRoomUsecase(
          Get.find<TripRepository>(),
        ));
    Get.lazyPut(() => KickMemberUsecase(
          Get.find<TripRepository>(),
        ));
    Get.lazyPut<TripRoomMemberController>(
      () => TripRoomMemberController(
        Get.find<TripRoomService>(),
        Get.find<LoginUserService>(),
        Get.find<LeaveTripRoomUsecase>(),
        Get.find<KickMemberUsecase>(),
      ),
    );
  }
}
