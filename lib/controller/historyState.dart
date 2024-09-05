import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import '../screen/trip/tripHistory/album/modal/albumModel.dart';


class HistoryState extends GetxController{
  AlbumModel? albumModel;
  final RxList albums = [].obs;
  final RxList selectAlbumList = [].obs;
  // final RxList<AssetPathEntity> totalAlbumList = RxList<AssetPathEntity>([]); /// 전체 앨범 가져오기
  // final Rx<List<AlbumModel>> albumSubList = Rx<List<AlbumModel>>([]); /// 앨범 첫번쨰 사진 가져오기
  // final Rx<List<AlbumModel>> albumList = Rx<List<AlbumModel>>([]); ///해당 앨범 사진 목록
  final selectAlbumIndex = 0.obs; /// 클릭한 앨범 리스트

  // final Rx<List<AlbumModel>> selectAlbumList = Rx<List<AlbumModel>>([]); /// 선택한 앨범 리스트

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  @override
  void onInit() {
    latitude.value = 36.35475233611197;
    longitude.value = 127.34170655688537;
    super.onInit();
  }
  @override
  void onClose()async{
    super.onClose();
  }

  ///앨범 정보 가져오는 함수
  Future<void> getAlbums() async {
    albums.clear();
    // totalAlbumList.value.clear();
    // albumList.value.clear();
    await PhotoManager.getAssetPathList(
        type: RequestType.common,
        pathFilterOption: PMPathFilter(
            darwin: PMDarwinPathFilter(subType: [
              PMDarwinAssetCollectionSubtype.smartAlbumRecentlyAdded,
              PMDarwinAssetCollectionSubtype.albumRegular,
              PMDarwinAssetCollectionSubtype.smartAlbumFavorites,
            ]),
            ohos: PMOhosPathFilter(type: [PMOhosAlbumType.user],subType: [PMOhosAlbumSubtype.userGeneric])
        ),
        filterOption: FilterOptionGroup(
        orders: [
          OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ),
        ],
    )).then((paths) async{
      // totalAlbumList.value = paths;
      for (AssetPathEntity asset in paths) {
        await asset.getAssetListRange(start: 0, end: 5000).then((images)async{
          if (images.isNotEmpty) {
            final album = AlbumModel(id: asset.id, name: asset.name, images: images);
            albums.add(album);
            albums.refresh();
            if(images.length!=0){
              await PhotoCachingManager().requestCacheAssets(
                assets: images,
                option: ThumbnailOption(
                  size: ThumbnailSize.square(25), // 요청할 썸네일 크기
                ),
              );
              }
            }
        });
      }
    });
  }

  // void loadMoreImages(AssetPathEntity album) async {
  //   int start = albumList.value.isNotEmpty
  //       ? albumList.value.first.images.length
  //       : 0;
  //   int end = start + 100;
  //   List<AssetEntity> newImages = await album.getAssetListRange(start: start, end: end);
  //   if (newImages.isNotEmpty) {
  //     AlbumModel? existingAlbum = albumList.value.firstWhereOrNull((a) => a.id == album.id);
  //     await PhotoCachingManager().requestCacheAssets(
  //       assets: newImages,
  //       option: ThumbnailOption(
  //         size: ThumbnailSize.square(25), // 요청할 썸네일 크기
  //       ),
  //     );
  //
  //     if (existingAlbum != null) {
  //       existingAlbum.images.addAll(newImages);
  //     } else {
  //       albumList.value.add(AlbumModel(
  //         id: album.id,
  //         name: album.name,
  //         images: newImages,
  //       ));
  //     }
  //     albumList.refresh();
  //   }
  // }

  /// 앨범 선택
  void addToSelectedAlbum(AssetEntity image) {
    selectAlbumList.add(image);
    albums.refresh();

    // final AlbumModel album = albumList.value[0];
    // final updatedList = List<AlbumModel>.from(selectAlbumList.value);
    // updatedList.add(album);
    // selectAlbumList.value = updatedList;
  }
  /// 앨범 지우기
  void removeFromSelectedAlbum(AssetEntity image) {
    selectAlbumList.remove(image);
    albums.refresh();

    // final AlbumModel album = albumList.value[0];
    // final updatedList = List<AlbumModel>.from(selectAlbumList.value);
    // updatedList.remove(album);
    // selectAlbumList.value = updatedList;
  }
}