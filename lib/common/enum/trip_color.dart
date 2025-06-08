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
}
