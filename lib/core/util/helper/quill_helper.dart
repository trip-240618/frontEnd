import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';

class QuillHelper {
  /// Quill Delta JSON -> Plain text 반환
  static String quillDeltaToText(String deltaJson) {
    try {
      final decoded = jsonDecode(deltaJson);
      final doc = Document.fromJson(decoded);
      return doc.toPlainText().trim();
    } catch (_) {
      return '';
    }
  }
}
