import 'dart:ui';

enum TripColor {
  pastelBlue,
  mainRed,
  yellow,
  green;

  Color get color {
    switch (this) {
      case TripColor.pastelBlue:
        return const Color(0xFF5E91EE);
      case TripColor.mainRed:
        return const Color(0xFFFF6187);
      case TripColor.yellow:
        return const Color(0xFFF4DC59);
      case TripColor.green:
        return const Color(0xFF83CF75);
    }
  }

  factory TripColor.fromHex(String hex) {
    var s = hex.trim();
    if (s.startsWith("0x") || s.startsWith("0X")) s = s.substring(2);

    final parsed = int.tryParse(s, radix: 16);

    return TripColor.values.firstWhere(
      (color) => color.color.toARGB32() == parsed,
    );
  }
}
