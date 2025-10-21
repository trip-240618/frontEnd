import 'package:get/get.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_histories_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_list_state.dart';

class HistoryListController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchHistoriesUsecase _fetchHistoriesUsecase;

  HistoryListController(
    this._tripRoomService,
    this._fetchHistoriesUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  HistoryListState _historyListState = HistoryListState();

  HistoryListState get state => _historyListState;

  Future<void> init(DateTime selectedDate) async {
    if (tripRoomInfo?.id == null) return;

    final result = await _fetchHistoriesUsecase.call(tripRoomInfo?.id ?? 0);

    result.fold(
      (failure) {
        _historyListState = state.copyWith(
          historyStatus: HistoryListStatus.failure,
        );
        update();
      },
      (data) {
        HistoriesEntity? targetEntity;

        targetEntity = data.firstWhereOrNull(
          (history) => history.photoDate == selectedDate.formatYMDWithHyphen(),
        );

        _historyListState = state.copyWith(
          historyEntity: targetEntity,
          day: tripRoomInfo?.dayAfterStartFrom(selectedDate) ?? 1,
          historyStatus: HistoryListStatus.success,
        );
        update();
      },
    );
  }

  void onNavigateToDetailPressed() {
    Get.toNamed(Routes.historyDetail);
  }
}
