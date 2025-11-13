import 'package:get/get.dart';
import 'package:tripStory/domain/usecases/fetch_notices_usecase.dart';
import 'package:tripStory/presentation/setting/models/notices_list_state.dart';

class NoticesListController extends GetxController {
  final FetchNoticesUsecase _fetchNoticesUsecase;

  NoticesListController(
    this._fetchNoticesUsecase,
  );

  NoticesListState _noticesListState = NoticesListState();

  NoticesListState get state => _noticesListState;

  @override
  void onInit() {
    super.onInit();
    _fetchNotices(NoticesType.all);
  }

  Future<void> onNoticesTypePressed(NoticesType noticeType) async {
    await _fetchNotices(
      noticeType,
    );
  }

  Future<void> _fetchNotices(
    NoticesType type,
  ) async {
    final result = await _fetchNoticesUsecase.call(type.name);

    result.fold(
      (error) {},
      (notices) {
        _noticesListState = state.copyWith(
          selectedNoticesType: type,
          notices: notices,
        );
        update();
      },
    );
  }
}
