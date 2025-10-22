import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/create_reply_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_history_detail_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_reply_usecase.dart';
import 'package:tripStory/domain/usecases/history_heart_toggle_usecase.dart';
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

  HistoryDetailController(
    this._tripRoomService,
    this._fetchHistoryDetailUsecase,
    this._loginUserService,
    this._createReplyUsecase,
    this._fetchReplyUsecase,
    this._heartToggleUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  String get myUuid => _loginUserService.myUuid;

  HistoryDetailState _historyDetailState = HistoryDetailState();

  HistoryDetailState get state => _historyDetailState;

  final TextEditingController textCon = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await Future.wait([
      _getHistoryDetailData(),
      _getReplyData(),
    ]);
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

  Future<void> _getReplyData() async {
    final tripId = tripRoomInfo?.tripId;
    final int historyId = 5;
    if (tripId == null) return;

    final params = FetchReplyParams(
      tripId: tripId,
      historyId: historyId,
    );

    final result = await _fetchReplyUsecase.call(params);
    result.fold(
      (failure) {},
      (replies) async {
        _historyDetailState = state.copyWith(
          replies: replies,
        );
        update();
      },
    );
  }

  Future<void> onCreateReplyPressed() async {
    final tripId = tripRoomInfo?.tripId;
    final int historyId = 5;
    if (tripId == null) return;

    final params = CreateReplyParams(
      tripId: tripId,
      historyId: historyId,
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
            historyId: state.historyDetailEntities[historyId]!.copyWith(
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
    final int historyId = 5;
    if (tripId == null) return;

    final params = HistoryHeartToggleParams(
      tripId: tripId,
      historyId: historyId,
    );

    final result = await _heartToggleUsecase.call(params);

    result.fold(
      (failure) {},
      (heartResult) async {
        final currentEntity = state.historyDetailEntities[historyId];
        if (currentEntity != null) {
          final currentLikeCnt = currentEntity.likeCnt ?? 0;

          _historyDetailState = state.copyWith(
            historyDetailEntities: {
              ...state.historyDetailEntities,
              historyId: currentEntity.copyWith(
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

  @override
  void onClose() {
    textCon.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
