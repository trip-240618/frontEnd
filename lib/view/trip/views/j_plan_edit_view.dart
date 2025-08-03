import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/view/trip/controllers/j_plan_edit_controller.dart';
import 'package:tripStory/view/trip/models/j_plan_edit_param.dart';
import 'package:tripStory/view/trip/widgets/j_plan_editor_view.dart';

class JPlanEditView extends StatelessWidget {
  final JPlanEditParams params;

  const JPlanEditView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JPlanEditController>();

    return JPlanEditorView(
      appbarTitle: "일정 수정",
      bottomButtonText: "수정",
      selectedDate: params.selectedDate,
      jPlanEntity: params.jPlan,
      onBottomButtonPressed: (state) => controller.onEditSavePressed(state),
    );
  }
}
