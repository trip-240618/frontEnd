import 'package:url_launcher/url_launcher.dart';

Future<void> urlLaunch(String url)async{
  const url = 'http://misnetwork.iptime.org:3344/service';
  final Uri uri = Uri.parse(url);
  await launchUrl(uri);
}