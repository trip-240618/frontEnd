import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/tag/tag_day.dart';

class HistoryItemHeader extends StatelessWidget {
  final int day;
  final Color labelColor;
  final String photoDate;
  final int historyCount;
  final VoidCallback? onHeaderPressed;

  const HistoryItemHeader({
    super.key,
    required this.day,
    required this.labelColor,
    required this.photoDate,
    required this.historyCount,
    this.onHeaderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onHeaderPressed,
      child: SizedBox(
        width: context.screenWidth,
        child: Row(
          children: [
            TagDay(
              day: day,
              color: labelColor,
              dayType: TagDayType.day,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              photoDate,
              style: context.style.caption1,
            ),
            Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: historyCount == 0 ? context.color.gray400 : context.color.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "$historyCount",
                  style: context.style.caption1.copyWith(
                    color: context.color.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
