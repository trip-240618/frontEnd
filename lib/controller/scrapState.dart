import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/api/scrapApi.dart';

import '../app/api/fileApi.dart';
import '../app/permission/permission.dart';
import '../data/network/dio_client.dart';

class ScrapState extends GetxController {
  final RxList scrapList = <dynamic>[].obs;

  /// 스크랩 목록 리스트
  final RxList selectScrapList = <dynamic>[].obs;

  /// 선택한 스크랩 리스트
  final apiScrapClient = ApiScrapClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());
  final ImagePicker _picker = ImagePicker();
  final addImgUrl = ''.obs;

  /// 추가한 스크랩 이미지

  /// 스크랩 생성
  Future<void> createScrap(String title, String content, bool hasImage, String color, List? photoList) async {
    await apiScrapClient.createScrap(
      title,
      content,
      hasImage,
      color,
      photoList!.isEmpty ? [] : photoList,
    );
  }

  /// 스크랩 수정
  Future<void> modifyScrap(int id, String title, String content, bool hasImage, String color, List? photoList) async {
    if (hasImage) {
      /// 기존 이미지를 그대로 유지 text만 변경할 경우, photoList 값은 screen 에서 조절
      /// 기존 이미지를 새로운 이미지 대체할 경우
      if (selectScrapList[0]['hasImage'] && addImgUrl.isNotEmpty)
        await removeImage(selectScrapList[0]['imageDtos'][0]['imageUrl']);
    } else {
      if (addImgUrl.isNotEmpty) await removeImage(addImgUrl.value);
      if (selectScrapList[0]['hasImage']) await removeImage(selectScrapList[0]['imageDtos'][0]['imageUrl']);
    }
    await apiScrapClient.modifyScrap(
      id,
      title,
      content,
      hasImage,
      color,
      photoList!.isEmpty ? [] : photoList,
    );
  }

  /// 스크랩 리스트 가져오기
  Future<void> getScrapList() async {
    scrapList.clear();
    scrapList.value = await apiScrapClient.getScrap();
    scrapList.refresh();
  }

  /// 스크랩 북마크 리스크 가져오기
  Future<void> getScrapBookmark() async {
    scrapList.clear();
    scrapList.value = await apiScrapClient.getScrapBookmark();
  }

  /// 스크랩 북마크 클릭 요청
  Future<void> clickScrapBookmark(int scrapId) async {
    await apiScrapClient.clickScrapBookmark(scrapId);
  }

  /// 선택한 스크랩 리스트 가져오기
  Future<void> getSelectScrapList(int scrapId) async {
    selectScrapList.value = await apiScrapClient.getSelectScrap(scrapId);
    scrapList.refresh();
  }

  /// 스크랩 삭제
  Future<void> deleteScrap(int scrapId) async {
    await apiScrapClient.deleteScrap(scrapId);
  }

  /// 사진 넣기
  Future<XFile?> getSingleImage(ImageSource imageSource, BuildContext context, XFile? file) async {
    bool requestCheck = await requestCameraPermission(context);
    if (requestCheck) {
      final XFile? pickedFile = await _picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        file = XFile(pickedFile.path);
        return file;
      }
    }
  }

  /// 사진 업로드
  Future<Map<String, dynamic>> scrapFileUpload(XFile xfile) async {
    Map<String, dynamic> data = await apiFileClient.scrapUrlGet(1);
    addImgUrl.value = data['preSignedUrls'][0];
    for (int i = 0; i < data['preSignedUrls'].length; i++) {
      final fileBytes = await xfile.readAsBytes();
      final response = await http.put(
        Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: fileBytes,
      );
    }
    return data;
  }

  Future<void> removeImage(String imgUrl) async {
    await apiFileClient.historyUrlDelete(imgUrl);
  }

  /// 스크랩 이미지 url 리셋
  Future<void> scrapImgUrlReset() async {
    addImgUrl.value = '';
  }
}
