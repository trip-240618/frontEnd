import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/core/util/one_time_event.dart';

part 'album_state.freezed.dart';

@freezed
abstract class AlbumState with _$AlbumState {
  const AlbumState._();

  const factory AlbumState({
    Album? selectedAlbum,
    @Default([]) List<Album> albums,
    @Default([]) List<AssetEntity> selectedImages,
    @Default(false) bool isScroll,
    OneTimeEvent<bool>? showCameraPermissionDialog,
  }) = _AlbumState;

  int get selectedImageLength => selectedImages.length;

  bool isImageSelected(String imageId) => selectedImages.any((image) => image.id == imageId);
}

@freezed
abstract class Album with _$Album {
  const Album._();

  const factory Album({
    @Default("") String id,
    @Default("") String name,
    @Default([]) List images,
  }) = _Album;
}
