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
  final RxList albums = [].obs; /// 앨범 목록
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
  final RxList historyList = [].obs; /// 여행 총 리스트
  final RxMap historyDetailList = {}.obs; /// 여행방 상세보기 리스트
  final RxList historyComment = [].obs; /// 댓글 리스트
  final RxList tagAllList = [].obs; /// 태그 전체 리스트

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

  /// 디테일 리스트 가져오기
  Future<void> getDetailHistoryList(int tripId,int historyId) async {
    historyDetailList.clear();
    historyDetailList.value = await apiHistoryClient.getDetailHistoryList(tripId,historyId);
    historyDetailList.refresh();
  }

  /// 댓글 목록 가져오기
  Future<void> getDetailHistoryCommentList(int tripId,int historyId) async {
    historyComment.clear();
    historyComment.value = await apiHistoryClient.getDetailHistoryCommentList(tripId,historyId);
    historyComment.refresh();
  }

  /// 댓글 추가하기
  Future<void> addHistoryComment(int tripId,int historyId,String comment) async {
    historyComment.value = await apiHistoryClient.addHistoryComment(tripId,historyId,comment);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['items']) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
    }
    historyList.refresh();
    historyComment.refresh();
  }

  /// 댓글 수정하기
  Future<void> editHistoryComment(int tripId,int historyId,int replyId,String content) async {
    historyComment.value = await apiHistoryClient.editHistoryComment(tripId,historyId,replyId,content);
    historyComment.refresh();
  }

  /// 댓글 삭제
  Future<void> deleteHistoryComment(int tripId,int historyId,int replyId) async {
    historyComment.value = await apiHistoryClient.deleteHistoryComment(tripId,historyId,replyId);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['items']) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
    }
    historyList.refresh();
    historyComment.refresh();
  }

  /// 좋아요 토글
  Future<void> historyListToggle(int tripId,int historyId) async {
    await apiHistoryClient.historyListToggle(tripId,historyId);
    bool isLiked = historyDetailList['like'] = !historyDetailList['like'];
    historyDetailList['likeCnt'] += isLiked ? 1 : -1;

    for (var day in historyList) {
      for (var item in day['items']) {
        if (item['id'] == historyId) {
          item['likeCnt'] += isLiked ? 1 : -1;
          break;
        }
      }
    }
    historyList.refresh();
    historyDetailList.refresh();
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

  /// 태그 전체 가져오기
  Future<void> getTagAll(int tripId) async {
    tagAllList.clear();
    tagAllList.value = await apiHistoryClient.getTagAll(tripId);
    tagAllList.refresh();
  }
}