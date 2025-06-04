import 'package:flutter/material.dart';
import 'package:tripStory/view/rooms/main_page/views/trip_bookmark_view.dart';
import 'package:tripStory/view/rooms/main_page/views/trip_past_view.dart';
import 'package:tripStory/view/rooms/main_page/views/trip_upcoming_view.dart';

enum TripOption {
  tripUpcoming,
  tripPast,
  tripBookmark,
}

extension TripOptionView on TripOption {
  Widget get tripView {
    switch (this) {
      case TripOption.tripUpcoming:
        return const TripUpcomingView();
      case TripOption.tripPast:
        return const TripPastView();
      case TripOption.tripBookmark:
        return const TripBookmarkView();
    }
  }

  String get label {
    switch (this) {
      case TripOption.tripUpcoming:
        return '다가오는 여행';
      case TripOption.tripPast:
        return '지난 여행';
      case TripOption.tripBookmark:
        return '북마크';
    }
  }
}
