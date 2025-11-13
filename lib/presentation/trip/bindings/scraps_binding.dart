import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/delete_scrap_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_scraps_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_scraps_usecase.dart';
import 'package:tripStory/domain/usecases/toggle_scrap_bookmark_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/scraps_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class ScrapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchScrapsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => DeleteScrapUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchBookmarkedScrapsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => ToggleScrapBookmarkUseCase(Get.find<TripRepository>()));

    Get.lazyPut(
      () => ScrapsController(
        Get.find<TripRoomService>(),
        Get.find<LoginUserService>(),
        Get.find<FetchScrapsUseCase>(),
        Get.find<DeleteScrapUseCase>(),
        Get.find<FetchBookmarkedScrapsUseCase>(),
        Get.find<ToggleScrapBookmarkUseCase>(),
      ),
      fenix: true,
    );
  }
}
