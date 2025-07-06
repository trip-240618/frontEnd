import 'package:get/get.dart';
import 'package:tripStory/domain/usecases/fetch_notices_usecase.dart';
import 'package:tripStory/view/setting/models/notices_list_state.dart';

class NoticesListController extends GetxController {
  final FetchNoticesUsecase _fetchNoticesUsecase;

  NoticesListController(
    this._fetchNoticesUsecase,
  );

  NoticesListState _noticesListState = NoticesListState();

  NoticesListState get state => _noticesListState;

  Future<void> onNoticesTypePressed(NoticesType noticeType) async {
    final result = await _fetchNoticesUsecase.call(
      state.selectedNoticesType.name,
    );

    result.fold(
      (error) {},
      (notices) {
        _noticesListState = state.copyWith(
          selectedNoticesType: noticeType,
          notices: notices,
        );
        update();
      },
    );
  }
}
