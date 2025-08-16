import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class TimePickerBottomSheet extends StatelessWidget {
  final DateTime selectedTime;
  final void Function(DateTime) onTimeChanged;

  const TimePickerBottomSheet({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      color: context.color.white,
      child: Column(
        children: [
          Container(
            color: context.color.gray900,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  "시간 입력",
                  style: context.style.label1Normal.copyWith(
                    color: context.color.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgIcon(
                    assetPath: IconConstants.close,
                    color: context.color.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: false,
              initialDateTime: selectedTime,
              onDateTimeChanged: (DateTime dateTime) => onTimeChanged(dateTime),
            ),
          ),
        ],
      ),
    );
  }
}
