import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_histories_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/history_main_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistoryMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchHistoriesUsecase(Get.find<TripRepository>()));
    Get.lazyPut<HistoryMainController>(
      () => HistoryMainController(
        Get.find<TripRoomService>(),
        Get.find<FetchHistoriesUsecase>(),
      ),
    );
  }
}
