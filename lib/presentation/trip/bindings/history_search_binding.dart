import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_history_tags_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/history_search_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class HistorySearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchHistoryTagsUsecase(Get.find<TripRepository>()));
    Get.lazyPut<HistorySearchController>(
      () => HistorySearchController(
        Get.find<TripRoomService>(),
        Get.find<FetchHistoryTagsUsecase>(),
      ),
    );
  }
}
