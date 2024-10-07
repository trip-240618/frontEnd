import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tripStory/controller/tripState.dart';
import '../app/api/fileApi.dart';
import '../app/api/historyApi.dart';
import '../app/config/dio_client.dart';
import '../screen/trip/tripHistory/album/modal/albumModel.dart';
import '../screen/trip/tripHistory/history/model/detailItem.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class HistoryState extends GetxController{
  final apiHistoryClient = ApiHistoryClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());
  AlbumModel? albumModel;
  final ImagePicker _picker = ImagePicker();
  final RxList albums = [].obs;
  final RxList selectAlbumList = [].obs; ///선택된 앨범 리스트
  final selectAlbumIndex = 0.obs; /// 클릭한 앨범 리스트
  final RxList imgUrl = [].obs; /// img url 저장하기
  final selectedDate = ''.obs; /// 사진 등록 할 때 날짜 선택
  final RxList addTagList = [].obs;/// 태그 추가할 리스트

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  ///댓글 리스트
  final RxList<DetailItem> detailList = <DetailItem>[].obs;

  /// 여행 리스트
  final RxList historyList = [].obs;

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

  /// 기록 리스트 가져오기
  Future<void> getHistoryList(int tripId) async {
    final ts = Get.put(TripState());
    historyList.clear();
    List<Map<String, dynamic>> fetchedList = await apiHistoryClient.getHistoryList(tripId);
    Map<String, List<Map<String, dynamic>>> groupedByDate = groupByDate(fetchedList);

    DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
    DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);

    List<Map<String, dynamic>> allDates = [];

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      String currentDate = DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i)));
      allDates.add({
        'date': currentDate,
        'items': groupedByDate[currentDate] ?? [],
      });
    }
    historyList.value = allDates;
    print('Complete Data: ${historyList.value.length}');
  }

  /// 날짜별로 항목을 그룹화하는 함수
  Map<String, List<Map<String, dynamic>>> groupByDate(List<Map<String, dynamic>> items) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in items) {
      String date = item['photoDate'];

      if (groupedItems.containsKey(date)) {
        groupedItems[date]!.add(item);
      } else {
        groupedItems[date] = [item];
      }
    }

    return groupedItems;
  }
  Future<void>addDetailItem()async{
    detailList.add(
      DetailItem(
        imageUrl: 'https://example.com/image.jpg',
        comments: [
          Comment(
            username: 'user1',
            content: '좋은 사진이네요!',
            timestamp: DateTime.now(),

          ),
          Comment(
            username: 'user2',
            content: '멋집니다!',
            timestamp: DateTime.now(),
          ),
        ],
        tagData: []
      ),
    );
  }

  Future<void> addCommentToDetailItem(int index, Comment newComment) async{
    Comment(
      username: 'user2',
      content: '멋집니다!',
      timestamp: DateTime.now(),
    );
    detailList[index].comments.add(newComment);
    detailList[index] = DetailItem(
      imageUrl: detailList[index].imageUrl,
      comments: List.from(detailList[index].comments),
      tagData: []
    );
  }

  /// 사진 업로드
  Future<Map<String, dynamic>> historyFileUpload(List files)async{
    Map<String, dynamic> data = await apiFileClient.historyUrlGet(files.length);
    imgUrl.value = data['preSignedUrls'];
    for(int i=0;i<data['preSignedUrls'].length;i++){
      File? file = await files[i].file;
      final fileBytes = await file!.readAsBytes();
      final response = await http.put(Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: fileBytes,
      );
    }
    return data;
  }

  ///앨범 정보 가져오는 함수
  Future<void> getAlbums() async {
    albums.clear();
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

  Future getSingleCamera(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      // setState(() {
      //   _pickedImage = XFile(pickedFile.path);
      // });
    }
  }
  /// 앨범 선택
  void addToSelectedAlbum(AssetEntity image) {
    selectAlbumList.add(image);
    albums.refresh();
  }
  /// 앨범 지우기
  void removeFromSelectedAlbum(AssetEntity image) async{
    selectAlbumList.remove(image);
    albums.refresh();
  }
  /// 저장 한 후에 앨범에서 지우기
  void removeImage(AssetEntity image,int index) async{
    apiFileClient.historyUrlDelete(imgUrl[index]);
    imgUrl.removeAt(index);
    selectAlbumList.remove(image);
    selectAlbumList.refresh();
    albums.refresh();
  }

  /// 파일 업로드
  Future<List> addHistory(int tripId,List uploadList) async {
    List data = await apiHistoryClient.addHistory(tripId, uploadList);
    return data;
  }
}