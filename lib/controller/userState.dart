import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../app/api/fileApi.dart';
import '../app/api/userApi.dart';
import '../app/config/dio_client.dart';
import 'package:http_parser/http_parser.dart';
class UserState extends GetxController{
  final userList =[].obs; /// 유저 정보 리스트
  final dioClient = DioClient();
  final apiUserClient = ApiUserClient(DioClient());
  final apiFileClient = ApiFileClient(DioClient());

  /// 로그아웃
  Future<void> logOut()async{
    apiUserClient.logOut();
  }
  /// 자동로그인
  Future<void> autoLogin()async{
    apiUserClient.autoLogin();
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

  /// 프로필 상세 등록
  Future<void> userModify(String nickName,String profileImg)async{
    apiUserClient.userModify(nickName, profileImg);
  }
}