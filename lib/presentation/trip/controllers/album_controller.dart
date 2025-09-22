import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/util/debounce.dart';
import 'package:tripStory/presentation/trip/models/album_state.dart';

class AlbumController extends GetxController {
  AlbumState _albumState = AlbumState();

  AlbumState get state => _albumState;

  final int maxPhotoLength = 10;

  ScrollController albumScrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: Duration(milliseconds: 200));

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await getAlbums();
    _setupScrollListener();
  }

  Future<void> getAlbums() async {
    final albums = <Album>[];
    final paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      pathFilterOption: PMPathFilter(
        darwin: PMDarwinPathFilter(subType: [
          PMDarwinAssetCollectionSubtype.smartAlbumRecentlyAdded,
          PMDarwinAssetCollectionSubtype.albumRegular,
          PMDarwinAssetCollectionSubtype.smartAlbumFavorites,
        ]),
        ohos: PMOhosPathFilter(
          type: [PMOhosAlbumType.user],
          subType: [PMOhosAlbumSubtype.userGeneric],
        ),
      ),
      filterOption: FilterOptionGroup(
        orders: [
          OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ),
        ],
      ),
    );

    for (final path in paths) {
      final images = await path.getAssetListRange(start: 0, end: 5000);
      if (images.isEmpty) continue;

      albums.add(Album(
        id: path.id,
        name: path.name,
        images: images,
      ));
      PhotoCachingManager().requestCacheAssets(
        assets: images,
        option: ThumbnailOption(
          size: ThumbnailSize.square(25),
        ),
      );
    }

    _albumState = state.copyWith(
      albums: albums,
      selectedAlbum: albums.first,
    );
    update();
  }

  void _setupScrollListener() {
    albumScrollController.addListener(() {
      if (!_albumState.isScroll) {
        print("스크롤중");
        _albumState = state.copyWith(
          isScroll: true,
        );
        update();
      }

      _debounce(() {
        print("스크롤 종료");
        _albumState = state.copyWith(
          isScroll: false,
        );
        update();
      });
    });
  }

  void onImageSelectedPressed(AssetEntity image) {
    final currentSelectedImages = [...state.selectedImages];
    final index = currentSelectedImages.indexWhere((asset) => image.id == asset.id);

    if (index != -1) {
      currentSelectedImages.removeAt(index);
    } else {
      if (maxPhotoLength <= currentSelectedImages.length) return;
      currentSelectedImages.add(image);
    }

    _albumState = state.copyWith(
      selectedImages: currentSelectedImages,
    );
    update();
  }

  void reorderSelectedImages(int oldIndex, int newIndex) {
    final selected = [...state.selectedImages];
    if (newIndex > oldIndex) newIndex -= 1;

    final item = selected.removeAt(oldIndex);
    selected.insert(newIndex, item);

    _albumState = state.copyWith(
      selectedImages: selected,
    );
    update();
  }

  void onImageSelectedDeletePressed(int index) {
    final selected = [...state.selectedImages];
    selected.removeAt(index);

    _albumState = state.copyWith(
      selectedImages: selected,
    );
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _debounce.cancel();
    albumScrollController.dispose();
  }
}
