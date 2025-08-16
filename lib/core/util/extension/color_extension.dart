import 'dart:ui';

extension ColorExtension on Color {
  String toHex() => "0x${value.toRadixString(16).padLeft(8, "0").toUpperCase()}";

  String toJson() => "0x${value.toRadixString(16).toUpperCase()}";
}
