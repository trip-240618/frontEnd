import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/dialog/common_dialog.dart';
import 'package:tripStory/common/toast/custom_toast.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/j_plan_swap_controller.dart';
import 'package:tripStory/view/trip/models/j_plan_swap_param.dart';
import 'package:tripStory/view/trip/widgets/j_plan_list_tile.dart';

class JPlanSwapView extends StatefulWidget {
  final List<JPlanSwapParam> plans;

  const JPlanSwapView({
    super.key,
    required this.plans,
  });

  @override
  State<JPlanSwapView> createState() => _JPlanSwapViewState();
}

class _JPlanSwapViewState extends State<JPlanSwapView> {
  final controller = Get.find<JPlanSwapController>();

  @override
  void initState() {
    super.initState();
    controller.init(widget.plans);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backDialog(
          () => controller.onBackButtonPressed(),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppAppbar(
          onTap: () => backDialog(
            () => controller.onBackButtonPressed(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "일정 선택 후 다른 일정과\n시간순서를 바꿀 수 있어요",
                style: context.style.heading2,
              ),
              const SizedBox(
                height: 66,
              ),
              GetBuilder<JPlanSwapController>(
                builder: (controller) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.state.planLength,
                      itemBuilder: (context, index) {
                        final plan = controller.state.plans[index];
                        final isSelected = controller.state.selectedPlan?.planId == plan.planId;
                        return Column(
                          children: [
                            _EditJPlanListTile(
                              plan: plan,
                              isSelected: isSelected,
                              labelColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.white,
                              onTap: () => controller.onSwapPlanPressed(index),
                            ),
                            const SizedBox(height: 4)
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: "순서변경",
          onTap: () => controller.onSwapSavePressed(),
        ),
      ),
    );
  }

  void showToast(BuildContext context) {
    CustomToast.show(
      context: context,
      message: "일정 순서 변경이 완료됐습니다.",
      gravity: ToastGravity.TOP,
    );
  }

  void backDialog(
    VoidCallback onConfirm,
  ) {
    CommonDialog.show(
      title: "순서 변경을 종료하시겠습니까?",
      confirmText: "확인",
      onConfirm: onConfirm,
    );
  }
}

class _EditJPlanListTile extends StatelessWidget {
  final JPlanSwapParam plan;
  final Color labelColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _EditJPlanListTile({
    required this.plan,
    required this.isSelected,
    required this.onTap,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? context.color.gray900 : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: JPlanListTile(
        startTime: plan.startTime.formatDeleteSecondTime,
        title: plan.title,
        memo: plan.memo,
        labelColor: labelColor,
        onTap: onTap,
      ),
    );
  }
}
