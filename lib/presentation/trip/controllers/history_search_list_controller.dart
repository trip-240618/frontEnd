import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_search_history_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_search_list_state.dart';
import 'package:tripStory/presentation/trip/models/history_search_param.dart';

class HistorySearchListController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchSearchHistoryUsecase _fetchSearchHistoryUsecase;

  HistorySearchListController(
    this._tripRoomService,
    this._fetchSearchHistoryUsecase,
  );

  HistorySearchListState _historySearchListState = HistorySearchListState();

  HistorySearchListState get state => _historySearchListState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  void init(HistorySearchParam param) {
    _getSearchData(param);
  }

  Future<void> _getSearchData(HistorySearchParam param) async {
    final tripId = tripRoomInfo?.tripId;
    if (tripId == null) return;

    final result = await _fetchSearchHistoryUsecase.call(
      Tuple2(tripId, param),
    );

    result.fold(
      (failure) {
        _historySearchListState = state.copyWith(
          historySearchListStatus: HistorySearchListStatus.empty,
        );
        update();
      },
      (histories) {
        _historySearchListState = state.copyWith(
          histories: histories,
          historySearchListStatus: HistorySearchListStatus.success,
        );
        update();
      },
    );
  }

  Future<void> onNavigateToHistoryDetail() async {
    final idList = state.histories?.map((history) => history.id).toList();
    Get.toNamed(Routes.historyDetail, arguments: idList);
  }
}
