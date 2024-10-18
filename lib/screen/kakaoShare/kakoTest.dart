import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/screen/kakaoShare/second.dart';

class KakaoTest extends StatefulWidget {
  const KakaoTest({super.key});

  @override
  State<KakaoTest> createState() => _KakaoTestState();
}

class _KakaoTestState extends State<KakaoTest> {
  @override
  void initState() {
    kakaoSchemeStream.listen((url) {
      Uri uri = Uri.parse(url!);
      /// 쿼리 매개변수 추출
      String? key = uri.queryParameters['tripId'];
      String? key01 = uri.queryParameters['inviteCode'];
      print('key ${key}');
      print('key01 ${key01}');
      Get.to(()=>SecondTest(name: key!));
    }, onError: (e) {
      /// 에러 상황의 예외 처리 코드를 작성합니다.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{
              startKaKao();
              },
              child: Text('121212'))
        ],
      ),
    );
  }
  void startKaKao()async{
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
