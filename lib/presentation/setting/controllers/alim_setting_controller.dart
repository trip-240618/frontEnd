import 'package:get/get.dart';
import 'package:tripStory/data/models/request/notification_config_modify_request.dart';
import 'package:tripStory/domain/base/usecase.dart';
import 'package:tripStory/domain/usecases/fetch_notification_config_usecase.dart';
import 'package:tripStory/domain/usecases/update_notification_config_usecase.dart';
import 'package:tripStory/presentation/setting/models/alim_setting_state.dart';

class AlimSettingController extends GetxController {
  final FetchNotificationConfigUsecase _fetchNotificationConfigUsecase;
  final UpdateNotificationConfigUsecase _updateNotificationConfigUsecase;

  AlimSettingController(
    this._fetchNotificationConfigUsecase,
    this._updateNotificationConfigUsecase,
  );

  AlimSettingState _alimSettingState = AlimSettingState();

  AlimSettingState get state => _alimSettingState;

  @override
  void onInit() {
    super.onInit();
    _getNotificationConfig();
  }

  Future<void> _getNotificationConfig() async {
    final result = await _fetchNotificationConfigUsecase.call(NoParams());
    result.fold((error) {}, (config) {
      _alimSettingState = state.copyWith(
        status: AlimSettingStatus.success,
        isScheduleAlim: config.activePlan,
        isLikeAlim: config.activeLikeReply,
        isMarketingAlim: config.activeMarketing,
      );
      update();
    });
  }

  void onScheduleAlimChanged(
    bool switchValue,
  ) async {
    _alimSettingState = state.copyWith(
      isScheduleAlim: switchValue,
    );
    update();

    await _updateNotificationConfig();
  }

  void onLikeReplyAlimChanged(
    bool switchValue,
  ) async {
    _alimSettingState = state.copyWith(
      isLikeAlim: !state.isLikeAlim,
    );
    update();

    await _updateNotificationConfig();
  }

  void onMarketingChanged(
    bool switchValue,
  ) async {
    _alimSettingState = state.copyWith(
      isMarketingAlim: !state.isMarketingAlim,
    );
    update();

    await _updateNotificationConfig();
  }

  Future<void> _updateNotificationConfig() async {
    final request = NotificationConfigModifyRequest(
      activeMarketing: state.isMarketingAlim,
      activeLikeReply: state.isLikeAlim,
      activePlan: state.isScheduleAlim,
    );

    final result = await _updateNotificationConfigUsecase.call(request);

    result.fold(
      (error) {
        _alimSettingState = state.copyWith(status: AlimSettingStatus.failure);
        update();
      },
      (config) {
        _alimSettingState = state.copyWith(
          status: AlimSettingStatus.success,
          isScheduleAlim: config.activePlan,
          isLikeAlim: config.activeLikeReply,
          isMarketingAlim: config.activeMarketing,
        );
        update();
      },
    );
  }
}
