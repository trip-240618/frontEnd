import 'package:get/get.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_coming_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_enter_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_join_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_last_trips_usecase.dart';
import 'package:tripStory/domain/usecases/update_bookmark_usecase.dart';
import 'package:tripStory/view/hoom/controller/rooms_controller.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';

class RoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchComingTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchLastTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchBookmarkedTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => UpdateBookmarkUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchJoinRoomUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchEnterRoomUsecase(Get.find<TripRepository>()));

    Get.lazyPut(() => RoomsController(
          Get.find<TripRoomService>(),
          fetchComingTrips: Get.find(),
          fetchLastTrips: Get.find(),
          fetchBookmarkedTrips: Get.find(),
          updateBookmarkUseCase: Get.find(),
          fetchJoinRoomUsecase: Get.find(),
          fetchEnterRoomUsecase: Get.find(),
        ));
  }
}
