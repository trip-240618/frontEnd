import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/scrap_create_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/scrap_create_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

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
