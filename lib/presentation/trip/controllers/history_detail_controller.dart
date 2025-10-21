import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_history_detail_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_detail_state.dart';

class HistoryDetailController extends GetxController {
  final TripRoomService _tripRoomService;
  final LoginUserService _loginUserService;
  final FetchHistoryDetailUsecase _fetchHistoryDetailUsecase;

  HistoryDetailController(
    this._tripRoomService,
    this._fetchHistoryDetailUsecase,
    this._loginUserService,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  String get myUuid => _loginUserService.myUuid;

  HistoryDetailState _historyDetailState = HistoryDetailState();

  HistoryDetailState get state => _historyDetailState;

  @override
  void onInit() {
    super.onInit();
    _getHistoryDetailData();
  }

  Future<void> _getHistoryDetailData() async {
    final tripId = tripRoomInfo?.tripId;
    final int historyId = 5;
    if (tripId == null) return;

    if (state.historyDetailEntities.containsKey(historyId)) {
      return;
    }

    final params = HistoryDetailParams(
      tripId: tripId,
      historyId: historyId,
    );

    final result = await _fetchHistoryDetailUsecase.call(params);
    result.fold(
      (failure) {},
      (historyDetail) async {
        _historyDetailState = state.copyWith(
          historyDetailEntities: {
            ...state.historyDetailEntities,
            historyId: historyDetail,
          },
        );
        update();
      },
    );
  }
}
