import 'package:flutter/material.dart';

extension StringExtension on String {
  Color toColor({
    Color fallback = Colors.black,
  }) {
    final parsed = int.tryParse(this);
    return parsed != null ? Color(parsed) : fallback;
  }
}
