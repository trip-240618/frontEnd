import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImage(
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
