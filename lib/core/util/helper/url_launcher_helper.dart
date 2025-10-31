import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {

  static Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      throw Exception('실행할 수 없는 URL: $url');
    }

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}