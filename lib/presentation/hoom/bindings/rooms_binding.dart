import 'package:get/get.dart';
import 'package:tripStory/core/services/kakao_share_service.dart';
import 'package:tripStory/domain/repositories/trip_repository.dart';
import 'package:tripStory/domain/usecases/fetch_bookmarked_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_coming_trips_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_enter_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_join_room_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_last_trips_usecase.dart';
import 'package:tripStory/domain/usecases/kakao_share_usecase.dart';
import 'package:tripStory/domain/usecases/update_bookmark_usecase.dart';
import 'package:tripStory/presentation/hoom/controller/rooms_controller.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';

class RoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchComingTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchLastTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchBookmarkedTripsUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => UpdateBookmarkUseCase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchJoinRoomUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => FetchEnterRoomUsecase(Get.find<TripRepository>()));
    Get.lazyPut(() => KakaoShareUsecase(Get.find<KakaoShareService>()));

    Get.lazyPut(() => RoomsController(
          Get.find<TripRoomService>(),
          fetchComingTrips: Get.find(),
          fetchLastTrips: Get.find(),
          fetchBookmarkedTrips: Get.find(),
          updateBookmarkUseCase: Get.find(),
          fetchJoinRoomUsecase: Get.find(),
          fetchEnterRoomUsecase: Get.find(),
          kakaoShareUsecase: Get.find(),
        ));
  }
}
