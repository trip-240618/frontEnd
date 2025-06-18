import 'dart:async';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart' as imgCom;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripStory/app/api/countryApi.dart';
import 'package:tripStory/model/userModel.dart';
import 'package:version/version.dart';

import '../app/api/fileApi.dart';
import '../app/api/notificationApi.dart';
import '../app/api/userApi.dart';
import '../component/dialog/dialog.dart';
import '../data/network/dio_client.dart';

class UserState extends GetxController {
  final userList = <UserModel>[].obs;

  /// 유저 정보 리스트
  final mapFirstLoading = false.obs;

  /// 처음 맵 로딩
  final notiDuplicationList = [].obs;

  /// 로컬 노티 두번울리는거 방지 (ios 18 이상 에러)
  final userAlimSetting = {}.obs;

  /// 유저 알림 셋팅
  final countryList = [].obs;

  /// 다녀온 여행지 리스트
  final versionList = {}.obs;

  /// 버전 리스
  final dio = Get.find<DioClient>();
  late final apiUserClient = ApiUserClient(dio);
  late final apiFileClient = ApiFileClient(dio);
  late final apiNotificationClient = ApiNotificationClient(dio);
  late final apiCountryClient = ApiCountryClient(dio);

  Future<void> checkNetworkAndProceed() async {
    /// 초기 네트워크 상태 확인
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult[0] == ConnectivityResult.none) {
      FlutterNativeSplash.remove();
      await netWorkingDialog();
    }

    /// 네트워크 상태 변화 감지
    StreamSubscription<List<ConnectivityResult>> subscription =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result[0] == ConnectivityResult.none) {
        netWorkingDialog();
      }
    });
  }

  /// 버전관리
  Future<void> versionCheck(BuildContext context) async {
    await apiUserClient.getVersionList();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final prefs = await SharedPreferences.getInstance();
    final lastIgnoredVersion = prefs.getString('lastIgnoredVersion') ?? '';
    String fullVersion = "${packageInfo.version}+${packageInfo.buildNumber}";

    if (Version.parse(fullVersion) < Version.parse('${versionList['iosVersion']}')) {
      if (versionList['forceUpdate'] == true) {
        FlutterNativeSplash.remove();
        await forceUpdateVersionDialog(context);
      } else if (lastIgnoredVersion != '${versionList['iosVersion']}') {
        FlutterNativeSplash.remove();
        await updateVersionDialog(context);
      }
    }
  }

  /// 로그아웃
  Future<void> logOut() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final token = await TokenManagerProvider.instance.manager.getToken();
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    } else if (token != null) {
      await UserApi.instance.logout();
    }
    apiUserClient.logOut();
  }

  /// 자동로그인
  Future<void> autoLogin() async {
    await apiUserClient.autoLogin();
  }

  /// 유저 삭제
  Future<void> userDelete() async {
    await apiUserClient.userDelete();
  }

  /// 토큰 업데이트
  Future<void> tokenUpdate(String token) async {
    await apiUserClient.updateToken(token);
  }

  /// 다녀온 여행지 가져오기
  Future<void> getCountrySetting() async {
    countryList.value = await apiCountryClient.getCountry();
  }

  /// 알림 셋팅 가져오기
  Future<void> getNotificationSetting() async {
    userAlimSetting.value = await apiNotificationClient.getNotificationSetting();
  }

  /// 알림 셋팅 변경하기
  Future<void> changeNotificationSetting(Map maps) async {
    userAlimSetting.value = await apiNotificationClient.changeNotificationSetting(maps);
  }

  /// 프로필 권한 요청
  Future<Map<String, dynamic>> profileFileUpload(XFile xfile) async {
    Map<String, dynamic> data = await apiFileClient.fileUrlGet(1);
    for (int i = 0; i < 1; i++) {
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
        body: compressedBytes, // 압축된 이미지를 업로드
      );
    }
    return data;
  }

  /// 프로필 상세 등록 11-19 테스트해봐야함
  Future<void> userRegister(String name, String memo, String profileImg, String thumbnailImg, bool marketing) async {
    String? tokens = await FirebaseMessaging.instance.getToken();
    userList.value = [
      UserModel.fromJson(await apiUserClient.userRegister(name, memo, profileImg, thumbnailImg, marketing))
    ];
    if (tokens != null) {
      apiUserClient.updateToken(tokens);
    }
  }

  /// 프로필 수정
  Future<void> userModify(String nickName, String memo, String thumbnailImg, String profileImg) async {
    apiUserClient.userModify(nickName, memo, thumbnailImg, profileImg);
  }
}
