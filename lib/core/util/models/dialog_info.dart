import 'package:flutter/animation.dart';

class DialogInfo {
  final String title;
  final String? message;
  final VoidCallback onConfirm;

  DialogInfo({
    required this.title,
    this.message,
    required this.onConfirm,
  });
}
