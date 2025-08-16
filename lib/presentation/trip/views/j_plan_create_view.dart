import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/presentation/trip/controllers/j_plan_create_controller.dart';
import 'package:tripStory/presentation/trip/widgets/j_plan_editor_view.dart';

class JPlanCreateView extends StatelessWidget {
  final DateTime selectedDate;

  const JPlanCreateView({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JPlanCreateController>();

    return JPlanEditorView(
      appbarTitle: "일정 등록",
      bottomButtonText: "저장",
      selectedDate: selectedDate,
      onBottomButtonPressed: (state) => controller.onPlanSavePressed(state),
    );
  }
}
