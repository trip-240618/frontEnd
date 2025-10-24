import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/entities/histories_create_entity.dart';
import 'package:tripStory/domain/entities/tag_entity.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/domain/usecases/create_histories_upload_usecase.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_service.dart';
import 'package:tripStory/presentation/trip/models/history_create_state.dart';

class HistoryCreateController extends GetxController {
  final TripRoomService _tripRoomService;
  final CreateHistoriesUploadUsecase _createHistoriesUploadUsecase;

  HistoryCreateController(
    this._tripRoomService,
    this._createHistoriesUploadUsecase,
  );

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;
  HistoryCreateState _historyCreateState = HistoryCreateState();
  final TextEditingController memoCon = TextEditingController();

  HistoryCreateState get state => _historyCreateState;

  final PageController pageController = PageController(
    initialPage: 0,
  );

  int get currentIndex => pageController.page?.round() ?? 0;

  void init(List<AssetEntity> images) {
    _historyCreateState = state.copyWith(
      historyItems: images
          .map(
            (image) => HistoryItem(
              image: image,
            ),
          )
          .toList(),
    );
    update();
  }

  void onMemoChanged(String text) {
    _updateCurrentItem(
      (item) => item.copyWith(
        memo: text,
      ),
    );
  }

  void onTagSavePressed(List<TagEntity> tags) {
    _updateCurrentItem(
      (item) => item.copyWith(
        tags: tags,
      ),
    );
    update();
  }

  void _currentMemoChange(String memo) => memoCon.text = memo;

  void _pageMove(int moveIndex) => pageController.jumpToPage(moveIndex);

  void _updateCurrentItem(HistoryItem Function(HistoryItem) updater) {
    final items = [...state.historyItems];

    if (currentIndex < items.length) {
      items[currentIndex] = updater(items[currentIndex]);
      _historyCreateState = state.copyWith(historyItems: items);
      update();
    }
  }

  void onTagDeletedPressed(int tagIndex) {
    _updateCurrentItem(
      (item) => item.copyWith(
        tags: [...item.tags]..removeAt(tagIndex),
      ),
    );
  }

  void onPageChanged() {
    _currentMemoChange(state.historyItems[currentIndex].memo);
  }

  void onReorderImagePressed(int index) {
    _pageMove(index);
    _currentMemoChange(state.historyItems[currentIndex].memo);
  }

  void onReorderImageDeleted(int selectIndex) {
    final items = [...state.historyItems];

    if (items.length <= 1) return;
    items.removeAt(selectIndex);

    _historyCreateState = state.copyWith(
      historyItems: items,
    );
    int newIndex = currentIndex > selectIndex ? currentIndex - 1 : currentIndex.clamp(0, items.length - 1);
    _pageMove(newIndex);
    _currentMemoChange(items[newIndex].memo);

    update();
  }

  void onReorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;

    final items = [...state.historyItems];
    final movedItem = items.removeAt(oldIndex);
    items.insert(newIndex, movedItem);

    _historyCreateState = state.copyWith(
      historyItems: items,
    );
    update();

    _pageMove(newIndex);
    _currentMemoChange(items[newIndex].memo);
  }

  Future<void> onHistoryUploadPressed(DateTime photoDate) async {
    _historyCreateState = state.copyWith(
      showLoadingDialog: OneTimeEvent(true),
    );
    update();

    final uploadItems = await Future.wait(
      List.generate(state.historyLength, (index) async {
        final imageInfo = state.historyItems[index];
        final bytes = await imageInfo.image.originBytes;
        if (bytes == null) return null;

        return HistoryUploadWithFile(
          historyItem: HistoryUploadEntity(
            latitude: imageInfo.image.latitude,
            longitude: imageInfo.image.longitude,
            memo: imageInfo.memo,
            tags: imageInfo.tags,
            photoDate: photoDate.formatYMDWithHyphen(),
          ),
          fileBytes: bytes,
        );
      }),
    );

    final params = CreateHistoriesUploadParams(
      tripId: tripRoomInfo?.id ?? 0,
      items: uploadItems.whereType<HistoryUploadWithFile>().toList(),
    );

    final result = await _createHistoriesUploadUsecase(params);

    result.fold(
      (error) {
        _historyCreateState = state.copyWith(
          showMaxUploadDialog: OneTimeEvent(true),
          showLoadingDialog: OneTimeEvent(false),
        );
        update();
      },
      (_) {
        RouteHelper.popAllUntilAndToNamed(
          Routes.tripRoom,
          Routes.historyList,
          arguments: photoDate,
        );
      },
    );
  }

  @override
  void dispose() {
    memoCon.dispose();
    super.dispose();
  }
}
