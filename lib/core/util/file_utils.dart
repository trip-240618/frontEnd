import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> shareImage(String imgUrl) async {
  try {
    /// 이미지 URL에서 파일 다운로드
    final uri = Uri.parse(imgUrl);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}');
    }
    /// 이미지 파일로 로컬 저장
    var uint8list = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/img.jpg';
    File file = File(filePath);
    await file.writeAsBytes(uint8list);

    /// 파일 공유
    XFile sharedFile = XFile(file.path);
    await Share.shareXFiles([sharedFile]);
  } catch (e) {
    print('에러 발생: $e');
  }
}