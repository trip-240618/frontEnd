import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/api/scrapApi.dart';
import '../app/api/fileApi.dart';
import '../app/config/dio_client.dart';
import '../app/permission/permission.dart';
import 'package:http/http.dart' as http;


class ScrapState extends GetxController{

  final RxList scrapList = <dynamic>[].obs; /// 스크랩 목록 리스트
  final RxList selectScrapList = <dynamic>[].obs; /// 선택한 스크랩 리스트
  final apiScrapClient = ApiScrapClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());
  final ImagePicker _picker = ImagePicker();
  final addImgUrl = ''.obs;

  /// 스크랩 생성
  Future<void> createScrap(
      String title,
      String content,
      bool hasImage,
      String color,
      List? photoList)async {
    await apiScrapClient.createScrap(
      title,
      content,
      hasImage,
      color,
      photoList!.isEmpty?[]:photoList,
    );
  }

  /// 스크랩 리스트 가져오기
  Future<void> getScrapList()async{
    scrapList.clear();
    scrapList.value = await apiScrapClient.getScrap();
    print('scrapList?${scrapList.value}');
    scrapList.refresh();
  }

  /// 스크랩 북마크 리스크 가져오기
  Future<void> getScrapBookmark()async{
    scrapList.clear();
    scrapList.value = await apiScrapClient.getScrapBookmark();
    print('bookmark scrapList?${scrapList.value}');
  }

  /// 스크랩 북마크 클릭 요청
  Future<void> clickScrapBookmark(int scrapId)async{
    await apiScrapClient.clickScrapBookmark(scrapId);
  }

  /// 선택한 스크랩 리스트 가져오기
  Future<void> getSelectScrapList(int scrapId)async{
    selectScrapList.clear();
    selectScrapList.value = await apiScrapClient.getSelectScrap(scrapId);
    print('selectScrapList?${selectScrapList.value}');
    print('길이?${selectScrapList.length}');
    scrapList.refresh();
  }

  /// 스크랩 삭제
  Future<void> deleteScrap(int scrapId)async{
    await apiScrapClient.deleteScrap(scrapId);
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

  /// hs.imgUrl[i].toString().split('?')[0]

  /// 사진 업로드
  Future<Map<String, dynamic>> scrapFileUpload(XFile xfile)async{
    Map<String, dynamic> data = await apiFileClient.scrapUrlGet(1);
    addImgUrl.value = data['preSignedUrls'][0];
    print('imgUrl???${addImgUrl.value}');
    for(int i=0;i<data['preSignedUrls'].length;i++){
      final fileBytes = await xfile.readAsBytes();
      final response = await http.put(Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: fileBytes,
      );
    }
    print('data??${data}');
    return data;
  }

  Future<void> removeImage()async {
    await apiFileClient.historyUrlDelete(addImgUrl.value);
  }



}