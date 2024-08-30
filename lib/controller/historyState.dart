import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/screen/tripHistory/album/modal/albumModel.dart';

class HistoryState extends GetxController{
  AlbumModel? albumModel;
  final RxList<AssetPathEntity> albumList = RxList<AssetPathEntity>([]);
  // final Rx<List<AlbumModel>> albumList = Rx<List<AlbumModel>>([]);
  final selectAlbumIndex = 0.obs; /// 클릭한 앨범 리스트
  final Rx<List<AlbumModel>> selectAlbumList = Rx<List<AlbumModel>>([]); /// 선택한 앨범 리스트
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final isListScroll = false.obs;

  @override
  void onInit() {
    latitude.value = 36.35475233611197;
    longitude.value = 127.34170655688537;
    super.onInit();
  }
  @override
  void onClose()async{
    print('31231');
    super.onClose();
  }

  ///앨범 정보 가져오는 함수
  Future<void> getAlbums() async {
    albumList.value.clear();
    await PhotoManager.getAssetPathList(
        type: RequestType.image,
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
      albumList.value = paths;
      print('alnbumList ${albumList}');
      for (AssetPathEntity asset in paths) {
      }
      // for (AssetPathEntity asset in paths) {
      //   asset.getAssetListRange(start: 0, end: 20).then((images)async{
      //     if (images.isNotEmpty) {
      //       print('길이?? ${images.length}');
      //       albumModel = AlbumModel(id: asset.id, name: asset.name, images: images);
      //       albumList.value.add(albumModel!);
      //       albumList.refresh();
      //     }
      //   });
      // }
    });
  }

  // /// 앨범 선택
  // void addToSelectedAlbum(AssetEntity image) {
  //   final AlbumModel album = albumList.value[0];
  //   final updatedList = List<AlbumModel>.from(selectAlbumList.value);
  //   updatedList.add(album);
  //   selectAlbumList.value = updatedList;
  // }
  // /// 앨범 지우기
  // void removeFromSelectedAlbum(AssetEntity image) {
  //   final AlbumModel album = albumList.value[0];
  //   final updatedList = List<AlbumModel>.from(selectAlbumList.value);
  //   updatedList.remove(album);
  //   selectAlbumList.value = updatedList;
  // }
}