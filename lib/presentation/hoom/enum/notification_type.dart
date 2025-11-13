enum NotificationType {
  all,
  tripSchedule,
  tripLog;

  String get title {
    switch (this) {
      case NotificationType.all:
        return "전체";
      case NotificationType.tripSchedule:
        return '여행 일정';
      case NotificationType.tripLog:
        return '여행 기록';
    }
  }
}
