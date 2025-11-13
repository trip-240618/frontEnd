import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_search_history_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/history_search_list_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistorySearchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchSearchHistoryUsecase(Get.find<TripRepository>()));
    Get.lazyPut<HistorySearchListController>(
      () => HistorySearchListController(
        Get.find<TripRoomService>(),
        Get.find<FetchSearchHistoryUsecase>(),
      ),
    );
  }
}
