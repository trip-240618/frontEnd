import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String formatYMDWithHyphen() => DateFormat("yyyy-MM-dd").format(this);

  String formatYMDWithDot() => DateFormat("yyyy.MM.dd").format(this);

  String formatYMDInKorean() => DateFormat("yyyy년 M월 d일").format(this);

  String formatShortYMD() => DateFormat("yy.MM.dd").format(this);

  String get weekKo => DateFormat("E", "ko").format(this);

  String get dayKo => DateFormat("d").format(this);

  String get formatDateWithWeekdayKo => DateFormat("yyyy.MM.dd (EEE)", "ko_KR").format(this);

  String get formatTimeKo => DateFormat("a HH:mm", "ko_KR").format(this);

  String get formatTime => DateFormat("HH:mm").format(this);
}
