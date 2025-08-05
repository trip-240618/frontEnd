import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_scraps_usecase.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/scraps_state.dart';

class ScrapsController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchScrapsUseCase _fetchScrapsUseCase;

  ScrapsController(
    this._tripRoomService,
    this._fetchScrapsUseCase,
  );

  ScrapsState _scrapsState = ScrapsState();

  ScrapsState get state => _scrapsState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  @override
  void onInit() {
    super.onInit();
    _fetchScraps();
  }

  Future<void> _fetchScraps() async {
    final tripId = tripRoomInfo?.id;
    if (tripId == null) return;

    final result = await _fetchScrapsUseCase.call(tripId);
    result.fold(
      (error) {},
      (scrapsResult) {
        _scrapsState = state.copyWith(
            scraps: scrapsResult,
            status: scrapsResult.isEmpty
                ? ScrapsStatus.empty
                : ScrapsStatus.success);
        update();
      },
    );
  }
}
