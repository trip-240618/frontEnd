import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/network_constants.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/models/dialog_info.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/create_reply_usecase.dart';
import 'package:tripStory/domain/usecases/delete_history_detail_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_history_detail_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_reply_usecase.dart';
import 'package:tripStory/domain/usecases/history_heart_toggle_usecase.dart';
import 'package:tripStory/domain/usecases/report_history_usecase.dart';
import 'package:tripStory/domain/usecases/share_image_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_detail_state.dart';

class HistoryDetailController extends GetxController {
  final TripRoomService _tripRoomService;
  final LoginUserService _loginUserService;
  final FetchHistoryDetailUsecase _fetchHistoryDetailUsecase;
  final CreateReplyUsecase _createReplyUsecase;
  final FetchReplyUsecase _fetchReplyUsecase;
  final HistoryHeartToggleUsecase _heartToggleUsecase;
  final ShareImageUsecase _shareImageUsecase;
  final DeleteHistoryDetailUsecase _deleteHistoryDetailUsecase;
  final ReportHistoryUsecase _reportHistoryUsecase;

  HistoryDetailController(
    this._tripRoomService,
    this._fetchHistoryDetailUsecase,
    this._loginUserService,
    this._createReplyUsecase,
    this._fetchReplyUsecase,
    this._heartToggleUsecase,
    this._shareImageUsecase,
    this._deleteHistoryDetailUsecase,
    this._reportHistoryUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  String get myUuid => _loginUserService.myUuid;

  HistoryDetailState _historyDetailState = HistoryDetailState();

  HistoryDetailState get state => _historyDetailState;

  final TextEditingController textCon = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(initialPage: 0);

  int get currentHistoryId =>
      state.historyIds[pageController.hasClients ? pageController.page?.round() ?? 0 : pageController.initialPage];

  Future<void> init(List<int> historiesIds) async {
    _historyDetailState = state.copyWith(
      historyIds: historiesIds,
    );

    await Future.wait([
      _getHistoryDetailData(currentHistoryId),
      _getReplyData(),
    ]);

    _prefetchNextPage();
  }

  Future<void> _getHistoryDetailData(int historyId) async {
    final tripId = tripRoomInfo?.tripId;
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
      (historyDetail) {
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

  Future<void> _getReplyData() async {
    final tripId = tripRoomInfo?.tripId;
    if (tripId == null) return;

    final params = FetchReplyParams(
      tripId: tripId,
      historyId: currentHistoryId,
    );

    final result = await _fetchReplyUsecase.call(params);
    result.fold(
      (failure) {},
      (replies) async {
        _historyDetailState = state.copyWith(
          replies: replies,
          historyDetailStatus: HistoryDetailStatus.success,
        );
        update();
      },
    );
  }

  Future<void> _prefetchNextPage() async {
    final currentPage = pageController.hasClients ? pageController.page?.round() ?? 0 : pageController.initialPage;
    final nextPage = currentPage + 1;

    if (nextPage < state.historyIds.length) {
      final nextHistoryId = state.historyIds[nextPage];

      if (state.historyDetailEntities.containsKey(nextHistoryId)) {
        return;
      }

      final tripId = tripRoomInfo?.tripId;
      if (tripId == null) return;

      await _getHistoryDetailData(nextHistoryId);
    }
  }

  Future<void> _scrollToBottom() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      });
    });
  }

  void onPageIndexChanged(int page) async {
    await _getReplyData();
    _prefetchNextPage();
  }

  Future<void> onCreateReplyPressed() async {
    final tripId = tripRoomInfo?.tripId;

    if (tripId == null) return;

    final params = CreateReplyParams(
      tripId: tripId,
      historyId: currentHistoryId,
      content: textCon.text,
    );

    final result = await _createReplyUsecase.call(params);
    result.fold(
      (failure) {},
      (replies) async {
        _historyDetailState = state.copyWith(
          replies: replies,
          historyDetailEntities: {
            ...state.historyDetailEntities,
            currentHistoryId: state.historyDetailEntities[currentHistoryId]!.copyWith(
              replyCnt: replies.length,
            ),
          },
        );
        textCon.clear();
        update();
        _scrollToBottom();
      },
    );
  }

  Future<void> onHeartPressed() async {
    final tripId = tripRoomInfo?.tripId;

    if (tripId == null) return;

    final params = HistoryHeartToggleParams(
      tripId: tripId,
      historyId: currentHistoryId,
    );

    final result = await _heartToggleUsecase.call(params);

    result.fold(
      (failure) {},
      (heartResult) async {
        final currentEntity = state.historyDetailEntities[currentHistoryId];
        if (currentEntity != null) {
          final currentLikeCnt = currentEntity.likeCnt ?? 0;

          _historyDetailState = state.copyWith(
            historyDetailEntities: {
              ...state.historyDetailEntities,
              currentHistoryId: currentEntity.copyWith(
                likeCnt: heartResult ? currentLikeCnt + 1 : currentLikeCnt - 1,
                like: heartResult,
              ),
            },
          );
          update();
        }
      },
    );
  }

  Future<void> onImageSharedPressed() async {
    final firstEntity = state.historyDetailEntities.entries.first.value;
    final imageUrl = firstEntity.imageUrl;

    final result = await _shareImageUsecase.call(
      NetworkConstants.downLoadFileUrl(imageUrl),
    );

    result.fold(
      (failure) => {},
      (_) => {},
    );
  }

  void onHistoryDeletePressed() {
    _historyDetailState = state.copyWith(
      showDialog: OneTimeEvent(
        DialogInfo(
          title: "게시물을 삭제하시겠습니까?",
          message: "삭제 후 복구는 어렵습니다",
          onConfirm: _deleteHistory,
        ),
      ),
    );
    update();
  }

  Future<void> _deleteHistory() async {
    final tripId = tripRoomInfo?.tripId;
    if (tripId == null) return;

    final params = DeleteHistoryDetailParams(
      tripId: tripId,
      historyId: currentHistoryId,
    );

    final result = await _deleteHistoryDetailUsecase.call(params);

    result.fold(
      (failure) => {},
      (result) => RouteHelper.closeOverlaysAndPop(),
    );
  }

  void onHistoryReportPressed() {
    _historyDetailState = state.copyWith(
      showDialog: OneTimeEvent(
        DialogInfo(
          title: "게시물을 신고하시겠습니까?",
          onConfirm: () {
            RouteHelper.closeAllOverlays();
            _reportHistory();
          },
        ),
      ),
    );
    update();
  }

  Future<void> _reportHistory() async {
    final tripId = tripRoomInfo?.tripId;
    if (tripId == null) return;

    final result = await _reportHistoryUsecase.call(tripId);

    result.fold(
      (failure) {},
      (_) {
        _historyDetailState = state.copyWith(
          showDialog: OneTimeEvent(
            DialogInfo(
              title: "신고 접수가 완료되었습니다",
              onConfirm: () => Get.back(),
            ),
          ),
        );
        update();
      },
    );
  }

  @override
  void onClose() {
    textCon.dispose();
    scrollController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
