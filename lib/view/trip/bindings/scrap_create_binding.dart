import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/scrap_create_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/scrap_create_controller.dart';

class ScrapCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScrapCreateUseCase(Get.find<TripRepository>()));

    Get.lazyPut(
      () => ScrapCreateController(
        Get.find<TripRoomService>(),
        Get.find<ScrapCreateUseCase>(),
      ),
    );
  }
}
