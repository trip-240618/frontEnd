import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/toast/custom_toast.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/widgets/j_plan_list_tile.dart';

class JPlanSwapView extends StatefulWidget {
  const JPlanSwapView({super.key});

  @override
  State<JPlanSwapView> createState() => _JPlanSwapViewState();
}

class _JPlanSwapViewState extends State<JPlanSwapView> {
  // final js = Get.find<JPlanState>();
  // final ts = Get.find<TripState>();
  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast?.init(context);
    super.initState();
  }

  // Future<bool> _handleWillPop(BuildContext context) async {
  //   if (Platform.isAndroid) {
  //     showConfirmCancelTapDialog(context, '순서 변경을 종료하시겠습니까?', '확인', null, () async {
  //       js.jPlanList[0]['checked'] = true;
  //       js.isSorting.value = false;
  //       js.deleteSwapJPlan(js.editPlanJList[0]['dayAfterStart']);
  //       js.firstSwapList.value = {};
  //       Get.back();
  //       Get.back();
  //     });
  //     return false;
  //   }
  //   return false; // iOS는 뒤로가기 방지
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, dynamic) {
        // TODO: 안드로이드 실기기에서 테스트 진행해야 함
      },
      child: Scaffold(
        appBar: AppAppbar(),
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
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        JPlanListTile(
                          startTime: "00:00",
                          title: "wpa",
                          labelColor: context.color.white,
                          onTap: () {},
                        ),
                        const SizedBox(height: 4)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: "순서변경",
          onTap: () => {showToast()},
        ),
      ),
    );
  }

  void showToast() {
    CustomToast.show(
      context: context,
      message: '일정 순서 변경이 완료됐습니다.',
      gravity: ToastGravity.TOP,
    );
  }
}
