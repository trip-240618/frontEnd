import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/file_repository.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/trip_room_modify_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/trip_room_setting_controller.dart';

class TripRoomSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripRoomModifyUsecase(
          Get.find<TripRepository>(),
          Get.find<FileRepository>(),
        ));

    Get.lazyPut<TripRoomSettingController>(
      () => TripRoomSettingController(
        Get.find<TripRoomService>(),
        Get.find<TripRoomModifyUsecase>(),
      ),
    );
  }
}
