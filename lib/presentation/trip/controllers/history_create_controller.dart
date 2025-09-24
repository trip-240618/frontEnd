import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/presentation/trip/models/history_create_state.dart';

class HistoryCreateController extends GetxController {
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

  @override
  void dispose() {
    memoCon.dispose();
    super.dispose();
  }
}
