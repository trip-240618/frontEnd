import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

enum TagDayType {
  dDay,
  day,
  duringTrip,
}

class TagDay extends StatelessWidget {
  final int day;
  final Color color;
  final TagDayType dayType;

  const TagDay({
    super.key,
    required this.day,
    required this.color,
    required this.dayType,
  });

  String get _label {
    switch (dayType) {
      case TagDayType.dDay:
        return "D-$day";
      case TagDayType.day:
        return "Day $day";
      case TagDayType.duringTrip:
        return "여행중";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: context.color.white,
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        _label,
        style: context.style.label1Normal.copyWith(
          color: color,
        ),
      ),
    );
  }
}
