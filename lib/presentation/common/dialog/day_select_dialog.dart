import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/enum/button_type.dart';
import 'package:tripStory/presentation/common/button/app_button.dart';
import 'package:tripStory/presentation/common/dialog/base_dialog.dart';
import 'package:tripStory/presentation/common/selected_day_content.dart';

class DaySelectDialog extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? selectedDate;
  final void Function(DateTime selectedDate) onChanged;
  final VoidCallback onConfirmPressed;

  const DaySelectDialog({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.selectedDate,
    required this.onChanged,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: SizedBox(
          height: 470,
          child: SelectedDayContent(
            title: "등록하려는 사진의\n여행 날짜를 선택해주세요",
            startDate: startDate,
            endDate: endDate,
            selectedDate: selectedDate,
            onChanged: onChanged,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: "취소",
                level: ButtonLevel.secondary,
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: AppButton(
                label: "확인",
                level: ButtonLevel.primary,
                onPressed: onConfirmPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static void show({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required void Function(DateTime selectedDate) onChanged,
    required VoidCallback onConfirmPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      DaySelectDialog(
        title: title,
        startDate: startDate,
        endDate: endDate,
        onChanged: onChanged,
        onConfirmPressed: onConfirmPressed,
      ),
    );
  }
}
