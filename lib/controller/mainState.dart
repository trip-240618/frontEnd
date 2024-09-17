import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../app/permission/permission.dart';

class MainState extends GetxController with GetSingleTickerProviderStateMixin {
  final selectIdx = 0.obs; /// (탭바 클릭)

  /// tripRoomAdd
  late TabController tabController; /// 탭

  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final tripType = ''.obs; /// 여행타입 선택
  final tripDestination = ''.obs; /// 여행지 목적
  final tripDate = ''.obs; /// 여행일정
  TextEditingController tripCitySearchCon = TextEditingController(); /// 여행지 검색
  TextEditingController tripDirectSearchCon = TextEditingController(); /// 여행지 직접 검색
  String selectedCity = ''; /// 선택한 여행지
  final tripLeaveType = ''.obs; /// 여행타입 선택

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    tripCitySearchCon.dispose();
    tripDirectSearchCon.dispose();
    super.onClose();
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
    tripType.value ='';
    tripDestination.value ='';
    tripDate.value='';
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
  Future<bool> createRoom() async {
   if(tripType.value==''
       ||tripDestination.value ==''
       ||tripDate.value==''){
     print('빈칸을 확인해주세요');
     return false;
   }else{
     print('여행방 만들기');
     return true;
   }
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