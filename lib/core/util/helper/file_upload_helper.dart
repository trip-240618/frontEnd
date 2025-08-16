import 'dart:typed_data';

import 'package:http/http.dart' as http;

class FileUploadHelper {
  static Future<void> putUploadImage({
    required String url,
    required Uint8List fileBytes,
  }) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "image/jpeg",
      },
      body: fileBytes,
    );

    if (response.statusCode != 200) {
      throw Exception("upload error ${response.statusCode}");
    }
  }
}
