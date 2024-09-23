import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../app/api/fileApi.dart';
import '../app/api/tripApi.dart';
import '../app/config/dio_client.dart';
import '../app/permission/permission.dart';
import 'package:http/http.dart' as http;
class MainState extends GetxController with GetSingleTickerProviderStateMixin {
  final selectIdx = 0.obs; /// (탭바 클릭)
  final apiTripClient = ApiTripClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());
  /// tripRoomAdd
  late TabController tabController; /// 탭
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  final tripDestination = ''.obs; /// 여행지 목적
  RxList<DateTime> tripDate = <DateTime>[].obs;
  TextEditingController tripCitySearchCon = TextEditingController(); /// 여행지 검색
  TextEditingController tripDirectSearchCon = TextEditingController(); /// 여행지 직접 검색
  String selectedCity = ''; /// 선택한 여행지
  final tripLeaveType = ''.obs; /// 여행타입 선택

  /// trip main
  final tripList = <dynamic>[].obs; /// 여행지 목록 리스트
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    apiTripClient.inComingTripGet();
    print('처음시작');
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    tripCitySearchCon.dispose();
    tripDirectSearchCon.dispose();
    super.onClose();
  }

  /// 여행방 가져오기
  Future<void> getComingTrip()async{
    tripList.clear();
    tripList.value = await apiTripClient.inComingTripGet();
  }


  /// 여행지 캐쉬 저장
  void preCacheFlagImages(BuildContext context,List<Map<String, dynamic>> country) {
    for (var region in country) {
      for (var country in region['countries']) {
        final imageUrl = country['image'];
        precacheImage(CachedNetworkImageProvider(imageUrl), context);
      }
    }
  }
  /// 여행방 만들기 변수 초기화
  Future<void> roomReset()async{
    selectedCity = '';
    tripLeaveType.value = '';
    pickedImage.value =null;

    tripDestination.value ='';
    tripDate.value = [];
  }

  /// 여행지 바텀 리셋
  Future<void> bottomModalReset()async{
    selectedCity = '';
    tripLeaveType.value = '';
    tabController.index =0;
  }

  /// 여행지 선택 저장
  Future<void> saveDestination ()async{
    if(tabController.index==0){
      if(selectedCity==''){
        print('나라를 선택안했습니다');
      }else{
        tripDestination.value = selectedCity;
        Get.back();
      }
    }else{
      if(tripLeaveType=='' || tripDirectSearchCon.text==''){
        print('빈칸을 선택해주세요');
      }else{
        tripDestination.value = tripDirectSearchCon.text;
        Get.back();
      }
    }
  }

  /// 사진 넣기
  Future<XFile?> getSingleImage(ImageSource imageSource,BuildContext context, XFile? file) async {
    bool requestCheck = await requestCameraPermission(context);
    if(requestCheck){
      final XFile? pickedFile = await _picker.pickImage(source: imageSource);
      if (pickedFile != null) {
          file = XFile(pickedFile.path);
          return file;
      }
    }
  }

  /// 여행방 add
  Future<bool> createRoom(
      String thumbnailUrl,
      String name,
      String color,
      String type,
      List tripDate,
      String tripDestination) async {
   if(type==''
       ||tripDestination ==''
       ||tripDate.length==0){
     print('빈칸을 확인해주세요');
     return false;
   }else{
     String code = await apiTripClient.tripCreate(
         thumbnailUrl,
         name,
         color,
         type,
         '${tripDate[0]}',
         tripDate.length==1?'':'${tripDate[1]}',
         tripDestination);
        print('여행방 만들기 ${code}');
     return true;
   }
  }

  /// 여행방 썸네일 요청
  Future<Map<String, dynamic>> tripThumbnailUpload(XFile xfile) async {
    final fileBytes = await xfile.readAsBytes();
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
      fileBytes,
      quality: 10,
      minWidth: 400,
      minHeight: 400,
    );
    Map<String, dynamic> data = await apiFileClient.fileUrlGet(1);
    for (int i = 0; i < 1; i++) {
      final response = await http.put(
        Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: compressedBytes,  // 압축된 이미지를 업로드
      );
    }
    return data;
  }
  ///카카오 공유하기
  void kakaoShare()async{
    /// 사용자 정의 템플릿 ID
    int templateId = 109315;
    /// 카카오톡 실행 가능 여부 확인
    bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri = await ShareClient.instance.shareCustom(templateId: templateId,templateArgs: {'key1': '땃땃슈22!'});
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance.makeCustomUrl(
            templateId: templateId, templateArgs: {'key1': 'value1'});
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }
}