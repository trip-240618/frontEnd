import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_scraps_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/scraps_controller.dart';

class ScrapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchScrapsUseCase(Get.find<TripRepository>()));

    Get.lazyPut(
      () => ScrapsController(
        Get.find<TripRoomService>(),
        Get.find<FetchScrapsUseCase>(),
      ),
      fenix: true,
    );
  }
}
