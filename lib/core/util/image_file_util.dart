import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageFileUtil {
  static Future<void> deletePreviousImage({
    required XFile? previousImage,
    required XFile newImage,
  }) async {
    if (previousImage == null || previousImage.path == newImage.path) return;

    final prevFile = File(previousImage.path);
    if (await prevFile.exists()) {
      await prevFile.delete();
    }
  }

  static Future<Uint8List> compressImage(
    XFile file, {
    int quality = 10,
    int minWidth = 400,
    int minHeight = 400,
  }) async {
    final fileBytes = await file.readAsBytes();
    final compressedBytes = await FlutterImageCompress.compressWithList(
      fileBytes,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
    );
    return compressedBytes;
  }

  static Future<Uint8List> compressBytes(
    Uint8List bytes, {
    int quality = 40,
    int minWidth = 400,
    int minHeight = 400,
  }) async {
    return await FlutterImageCompress.compressWithList(
      bytes,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
    );
  }

  static Future<void> deleteFile(XFile file) async {
    final filePath = File(file.path);
    if (await filePath.exists()) await filePath.delete();
  }
}
