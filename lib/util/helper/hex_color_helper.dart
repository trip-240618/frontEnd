import 'package:flutter/material.dart';

class HexColorHelper {
  static Color fromHex(
    String? hexString, {
    Color fallback = Colors.black,
  }) {
    if (hexString == null) return fallback;
    final parsed = int.tryParse(hexString);
    return parsed != null ? Color(parsed) : fallback;
  }
}
