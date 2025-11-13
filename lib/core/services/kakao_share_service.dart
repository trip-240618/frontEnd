import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class KakaoShareService {
  static final int _templateId = int.parse(AppConstants.kakaoShareTemplateId);

  /// 카카오톡으로 여행 초대 공유

  Future<void> shareTrip(int tripId, String inviteCode) async {
    final args = {'value1': '$tripId', 'value2': inviteCode};

    try {
      final available = await ShareClient.instance.isKakaoTalkSharingAvailable();

      final uri = available
          ? await ShareClient.instance.shareCustom(
              templateId: _templateId,
              templateArgs: args,
            )
          : await WebSharerClient.instance.makeCustomUrl(
              templateId: _templateId,
              templateArgs: args,
            );

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('❌ Kakao share failed: $e');
      rethrow;
    }
  }

  /// 공유 링크를 통해 앱으로 들어왔을 때 호출
  Future<void> handleIncomingLink(Uri uri) async {
    if (uri.host == 'share') {
      final tripId = uri.queryParameters['tripId'];
      final inviteCode = uri.queryParameters['inviteCode'];

      if (tripId != null && inviteCode != null) {
        print('📩 공유 받은 여행 ID: $tripId / 초대 코드: $inviteCode');
        // 예시: Get.toNamed('/trip/invite', arguments: { 'tripId': tripId, 'inviteCode': inviteCode });
      }
    }
  }
}
