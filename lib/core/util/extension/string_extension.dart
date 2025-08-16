import 'package:flutter/material.dart';

extension StringExtension on String {
  Color toColor({
    Color fallback = Colors.black,
  }) {
    final parsed = int.tryParse(this);
    return parsed != null ? Color(parsed) : fallback;
  }

  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  String get formatDeleteSecondTime => substring(0, 5);

  DateTime toTodayTime() {
    final parts = split(":");
    if (parts.length < 2) return DateTime.now();

    final now = DateTime.now();
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    final second = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;

    return DateTime(now.year, now.month, now.day, hour, minute, second);
  }
}
