import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/permission/permission_state.dart' as per;
import 'package:tripStory/core/permission/permission_type.dart';
import 'package:tripStory/core/permission/permisson.dart';
import 'package:tripStory/core/util/debounce.dart';
import 'package:tripStory/core/util/helper/route_helper.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/presentation/trip/models/album_state.dart';

class AlbumController extends GetxController {
  AlbumState _albumState = AlbumState();

  AlbumState get state => _albumState;

  final int maxPhotoLength = 10;

  ScrollController albumScrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: Duration(milliseconds: 200));
  final ImagePicker _picker = ImagePicker();

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
        _albumState = state.copyWith(
          isScroll: true,
        );
        update();
      }

      _debounce(() {
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

  Future<void> onCameraPressed() async {
    final status = await getPermissionStatus(PermissionType.camera);

    if (status != per.PermissionState.granted) {
      _showCameraPermissionDialog();
      return;
    }
    await _cameraSave();
  }

  void _showCameraPermissionDialog() {
    _albumState = state.copyWith(
      showCameraPermissionDialog: OneTimeEvent(true),
    );
    update();
  }

  Future<void> _cameraSave() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final AssetEntity? assetEntity = await PhotoManager.editor.saveImageWithPath(
      pickedFile.path,
      title: pickedFile.name,
    );
    if (assetEntity == null) return;

    final selected = [...state.selectedImages, assetEntity];
    _albumState = state.copyWith(
      selectedImages: selected,
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

  void onAlbumPressed(Album selectAlbum) {
    _albumState = state.copyWith(
      selectedAlbum: selectAlbum,
    );
    RouteHelper.closeAllOverlays();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _debounce.cancel();
    albumScrollController.dispose();
  }
}
