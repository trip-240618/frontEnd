import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/location_repository.dart';
import 'package:tripStory/domain/usecases/fetch_location_usecase.dart';
import 'package:tripStory/domain/usecases/location_auto_complete_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/controllers/location_search_controller.dart';

class LocationSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostAutoCompleteUseCase(Get.find<LocationRepository>()));
    Get.lazyPut(() => FetchLocationUsecase(Get.find<LocationRepository>()));
    Get.lazyPut<LocationSearchController>(
      () => LocationSearchController(
        Get.find<TripRoomService>(),
        Get.find<PostAutoCompleteUseCase>(),
        Get.find<FetchLocationUsecase>(),
      ),
    );
  }
}
