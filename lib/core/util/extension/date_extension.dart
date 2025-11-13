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

  String get timeAgo {
    final now = this;
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return "방금 전";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}분 전";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}시간 전";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}일 전";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()}주 전";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()}개월 전";
    } else {
      return "${(difference.inDays / 365).floor()}년 전";
    }
  }
}
