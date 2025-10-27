import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/history_search_type.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/fetch_history_tags_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_search_param.dart';
import 'package:tripStory/presentation/trip/models/history_search_state.dart';

class HistorySearchController extends GetxController {
  final TripRoomService _tripRoomService;
  final FetchHistoryTagsUsecase _fetchHistoryTagsUsecase;

  HistorySearchController(
    this._tripRoomService,
    this._fetchHistoryTagsUsecase,
  );

  HistorySearchState _historySearchState = HistorySearchState();

  HistorySearchState get state => _historySearchState;

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  List<TagEntity> _allTags = [];
  List<TripMemberEntity> _allMembers = [];
  TextEditingController textCon = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _getTagsData();
    _allMembers = tripRoomInfo?.members ?? [];
    _historySearchState = state.copyWith(
      members: tripRoomInfo?.members ?? [],
    );
    update();
  }

  Future<void> _getTagsData() async {
    final tripId = tripRoomInfo?.tripId;
    if (tripId == null) return;

    final result = await _fetchHistoryTagsUsecase.call(tripId);
    result.fold(
      (failure) {},
      (tags) {
        _allTags = tags;
        _historySearchState = state.copyWith(
          tags: tags,
        );
        update();
      },
    );
  }

  void onTypePressed(HistorySearchType selectedType) {
    _historySearchState = state.copyWith(
      historySearchType: selectedType,
    );
    update();
  }

  Future<void> onSearchPressed() async {
    final searchText = textCon.text;

    final filteredMembers = _allMembers.where((member) => member.nickname.contains(searchText)).toList();

    final filteredTags = _allTags.where((tag) => tag.tagName.contains(searchText)).toList();

    _historySearchState = state.copyWith(
      searchMode: true,
      members: filteredMembers,
      tags: filteredTags,
    );
    update();
  }

  Future<void> onSearchModeCancelPressed() async {
    _historySearchState = state.copyWith(
      searchMode: false,
      members: _allMembers,
      tags: _allTags,
      historySearchType: HistorySearchType.tag,
    );
    textCon.clear();
    update();
  }

  Future<void> onNavigateToTagSearchPressed(TagEntity tag) async {
    final param = HistorySearchParam.tag(
      tag: tag,
    );
    Get.toNamed(Routes.historySearchList, arguments: param);
  }

  Future<void> onNavigateToMemberSearchPressed(TripMemberEntity member) async {
    final param = HistorySearchParam.member(
      member: member,
    );
    Get.toNamed(Routes.historySearchList, arguments: param);
  }

  @override
  void dispose() {
    textCon.dispose();
    super.dispose();
  }
}
