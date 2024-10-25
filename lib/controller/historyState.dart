import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
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
  final ts = Get.put(TripState());
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

  ///댓글 리스트
  final RxList<DetailItem> detailList = <DetailItem>[].obs;

  /// 여행 리스트
  final RxList historyList = [].obs; /// 여행 총 리스트
  final RxMap historyDetailList = {}.obs; /// 여행방 상세보기 리스트
  final RxList historyComment = [].obs; /// 댓글 리스트
  final RxList tagAllList = [].obs; /// 태그 전체 리스트
  final RxList tagSearchList = [].obs; /// 검색한 태그 리스트
  final RxList tagFilterColor = [].obs; /// 태그에서 컬러로 필터하고 싶을 때 리스트
  final RxList searchList = [].obs; /// 검색한 리스트들
  final RxList selectedTagList = [].obs; /// 선택한 태그

  @override
  void onInit() {
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
    List allData = await apiHistoryClient.getHistoryList(tripId);
    List filterDate = [];

    DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
    DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      String currentDate = DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i)));
      Map<String, dynamic>? matchedData;
      for (var data in allData) {
        if (data['photoDate'] == currentDate) {
          matchedData = data;
          break;
        }
      }
      filterDate.add({
        'photoDate': currentDate,
        'historyList': matchedData != null ? matchedData['historyList'] : [],
      });
    }
    historyList.value = filterDate;
  }

  /// 댓글 목록 가져오기
  Future<void> getDetailHistoryCommentList(int tripId,int historyId) async {
    historyComment.clear();
    historyComment.value = await apiHistoryClient.getDetailHistoryCommentList(tripId,historyId);
    historyComment.refresh();
  }

  /// 댓글 추가하기
  Future<void> addHistoryComment(int tripId,int historyId,String comment,bool search) async {
    historyComment.value = await apiHistoryClient.addHistoryComment(tripId,historyId,comment);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['historyList']) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
    }
    if(search){
      /// 댓글 추가
      for (var item in searchList) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
      searchList.refresh();
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
  Future<void> deleteHistoryComment(int tripId,int historyId,int replyId,bool search) async {
    historyComment.value = await apiHistoryClient.deleteHistoryComment(tripId,historyId,replyId);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['historyList']) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
    }
    if(search){
      /// 댓글 추가
      for (var item in searchList) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
      searchList.refresh();
    }
    historyList.refresh();
    historyComment.refresh();
  }

  /// 좋아요 토글
  Future<void> historyListToggle(int tripId,int historyId,bool isSearch) async {
    bool checked = await apiHistoryClient.historyListToggle(tripId,historyId);
    List list = isSearch?searchList:historyList;

    for (var day in list) {
      for (var item in day['historyList']) {
        if (item['id'] == historyId) {
          item['likeCnt'] += checked ? 1 : -1;
          item['like'] = checked?true:false;
          break;
        }
      }
    }
    if(isSearch){
      searchList.refresh();
    }else{
      historyList.refresh();
    }
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
      for (AssetPathEntity asset in paths) {
        await asset.getAssetListRange(start: 0, end: 5000).then((images)async{
          if (images.isNotEmpty) {
            final album = AlbumModel(id: asset.id, name: asset.name, images: images);
            albums.add(album);
            if(images.length!=0){
              await PhotoCachingManager().requestCacheAssets(
                assets: images,
                option: ThumbnailOption(
                  size: ThumbnailSize.square(25), // 요청할 썸네일 크기
                ),
              );
              }
            albums.refresh();
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

  /// 히스토리 업로드
  Future<void> addHistory(int tripId,List uploadList) async {
    final ts = Get.put(TripState());
    historyList.clear();
    List allData = await apiHistoryClient.addHistory(tripId, uploadList);
    List filterDate = [];
    DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
    DateTime endDate = DateTime.parse(ts.selectTripList[0]['endDate']);

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      String currentDate = DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i)));
      Map<String, dynamic>? matchedData;
      for (var data in allData) {
        if (data['photoDate'] == currentDate) {
          matchedData = data;
          break;
        }
      }
      filterDate.add({
        'photoDate': currentDate,
        'historyList': matchedData != null ? matchedData['historyList'] : [],
      });
    }
    print('추가 ${filterDate}');
    historyList.value = filterDate;
    selectAlbumList.clear();
    addTagList.clear();
    selectAlbumIndex.value = 0;
    selectAlbumList.refresh();
    historyList.refresh();
  }

  /// 히스토리 삭제
  Future<void> deleteHistory(int tripId,int historyId) async {
     await apiHistoryClient.deleteHistory(tripId,historyId);
  }

  /// 태그 전체 가져오기
  Future<void> getTagAll(int tripId) async {
    tagAllList.clear();
    tagAllList.value = await apiHistoryClient.getTagAll(tripId);
    tagAllList.refresh();
  }

  /// 태그 선택 할 때
  Future<void> getSelectedTag(int tripId,String tagName,String tagColor) async {
    searchList.clear();
    searchList.value = await apiHistoryClient.getTagSelect(tripId,tagName,tagColor);
    searchList.refresh();
  }

  /// 이름 선택 할 때
  Future<void> getSelectedName(int tripId,String uuid) async {
    searchList.clear();
    searchList.value = await apiHistoryClient.getUserSelect(tripId,uuid);
    searchList.refresh();
  }

  /// 태그 검색하기 닉네임,태그 검색했을 때
  Future<void> searchTagName(String searchText) async {
    tagSearchList.clear();

    List filteredNick = ts.selectTripList[0]['tripMemberDtoList'].where((init) {
      return init['nickname'] != null && init['nickname'].contains(searchText);
    }).toList();

    List filteredTags = tagAllList.where((tag) {
      return tag['tagName'] != null && tag['tagName'].contains(searchText);
    }).toList();

    if (filteredTags.isNotEmpty) {
      tagSearchList.addAll(filteredTags);
    }

    if (filteredNick.isNotEmpty) {
      tagSearchList.addAll(filteredNick);
    }
  }

  /// 검색 댓글 추가하기
  Future<void> searchAddHistoryComment(int tripId,int historyId,String comment) async {
    historyComment.value = await apiHistoryClient.addHistoryComment(tripId,historyId,comment);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['historyList']) {
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
  Future<void> searchEditHistoryComment(int tripId,int historyId,int replyId,String content) async {
    historyComment.value = await apiHistoryClient.editHistoryComment(tripId,historyId,replyId,content);
    historyComment.refresh();
  }

  /// 댓글 삭제
  Future<void> searchDeleteHistoryComment(int tripId,int historyId,int replyId) async {
    historyComment.value = await apiHistoryClient.deleteHistoryComment(tripId,historyId,replyId);
    historyDetailList['replyCnt'] = historyComment.length;
    for (var day in historyList) {
      for (var item in day['historyList']) {
        if (item['id'] == historyId) {
          item['replyCnt'] = historyComment.length;
          break;
        }
      }
    }
    historyList.refresh();
    historyComment.refresh();
  }

}