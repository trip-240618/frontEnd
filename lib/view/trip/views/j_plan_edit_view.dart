import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/view/trip/controllers/j_plan_edit_controller.dart';
import 'package:tripStory/view/trip/widgets/j_plan_editor_view.dart';

class JPlanEditView extends StatelessWidget {
  final DateTime selectedDate;

  const JPlanEditView({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JPlanEditController>();

    return JPlanEditorView(
      appbarTitle: "일정 수정",
      bottomButtonText: "수정",
      selectedDate: selectedDate,
      planId: 34,
      place: "",
      latitude: 0.0,
      longitude: 0.0,
      startTime: "01:00:00",
      title: "김밥",
      memo: "다기",
      onBottomButtonPressed: (state) => controller.onEditSavePressed(state),
    );
  }
}
