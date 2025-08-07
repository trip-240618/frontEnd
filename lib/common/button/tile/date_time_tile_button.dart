import 'package:flutter/material.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class DateTimeTileButton extends StatelessWidget {
  final Color iconColor;
  final String date;
  final String time;
  final VoidCallback? onDatePressed;
  final VoidCallback? onTimePressed;

  const DateTimeTileButton({
    super.key,
    required this.iconColor,
    required this.date,
    required this.time,
    this.onDatePressed,
    this.onTimePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.gray50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: context.color.gray200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: onDatePressed,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.5),
                    child: SvgIcon(
                      assetPath: IconConstants.date,
                      color: iconColor,
                    ),
                  ),
                  Text(
                    date,
                    style: context.style.body2Normal.copyWith(
                      color: context.color.gray800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: onTimePressed,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.5),
                    child: SvgIcon(
                      assetPath: IconConstants.time,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    time,
                    style: context.style.body2Normal.copyWith(
                      color: context.color.gray800,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
