import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_histories_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/history_list_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchHistoriesUsecase(Get.find<TripRepository>()));
    Get.lazyPut<HistoryListController>(
      () => HistoryListController(
        Get.find<TripRoomService>(),
        Get.find<FetchHistoriesUsecase>(),
      ),
    );
  }
}
