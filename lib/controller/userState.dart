import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart' as imgCom;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../app/api/fileApi.dart';
import '../app/api/userApi.dart';
import '../app/config/dio_client.dart';
class UserState extends GetxController{

  final userList =[].obs; /// 유저 정보 리스트
  final mapFirstLoading = false.obs; /// 처음 맵 로딩
  final dioClient = DioClient();
  final apiUserClient = ApiUserClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());

  /// 로그아웃
  Future<void> logOut()async{
    apiUserClient.logOut();
  }
  /// 자동로그인
  Future<void> autoLogin()async{
    await apiUserClient.autoLogin();
  }
  /// 유저 삭제
  Future<void> userDelete()async{
    await apiUserClient.userDelete();
  }
  /// 토큰 업데이트
  Future<void> tokenUpdate(String token)async{
    await apiUserClient.updateToken(token);
  }

  /// 프로필 권한 요청
  Future<Map<String, dynamic>> profileFileUpload(XFile xfile)async{
    Map<String, dynamic> data = await apiFileClient.fileUrlGet(1);
    for(int i=0;i<1;i++){
      final fileBytes = await xfile.readAsBytes();
      final response = await http.put(Uri.parse(data['preSignedUrls'][i]),
        headers: {
          'Content-Type': "image/jpeg",
        },
        body: fileBytes,
      );
    }
    return data;
  }
  /// 프로필 썸네일 요청
  Future<Map<String, dynamic>> profileThumbnailUpload(XFile xfile) async {
    final fileBytes = await xfile.readAsBytes();
    Uint8List? compressedBytes = await imgCom.FlutterImageCompress.compressWithList(
      fileBytes,
      quality: 10,
      minWidth: 100,
      minHeight: 100,
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
  /// 프로필 상세 등록
  Future<void> userRegister(String name,String memo,String profileImg,String thumbnailImg,bool marketing)async{
    String? tokens = await FirebaseMessaging.instance.getToken();
    userList.value=[await apiUserClient.userRegister(name, memo,profileImg,thumbnailImg,marketing)];
    if(tokens!=null){
      apiUserClient.updateToken(tokens);
    }
  }
  /// 프로필 수정
  Future<void> userModify(String nickName,String memo,String thumbnailImg,String profileImg)async{
    apiUserClient.userModify(nickName, memo,thumbnailImg,profileImg);
  }
}