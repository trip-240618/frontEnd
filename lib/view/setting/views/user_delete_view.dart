import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/dialog/common_dialog.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/setting/controllers/user_delete_controller.dart';

class UserDeleteView extends GetView<UserDeleteController> {
  const UserDeleteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        text: "회원탈퇴",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "회원탈퇴를 신청하기 전에\n안내 사항을 꼭 확인해주세요!",
              style: context.style.title3,
            ),
            const SizedBox(
              height: 47,
            ),
            Text(
              "탈퇴 후 회원 정보 및 서비스 이용기록은 모두 삭제되어\n복구가 불가능합니다.",
              style: context.style.label1Normal.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _HeadLineCircle(),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "삭제된 데이터는 복구되지 않습니다. 삭제되는 내용을\n확인하시고 필요한 데이터는 미리 백업을 해주세요.",
                        style: context.style.caption1.copyWith(
                          color: context.color.gray600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      _HeadLineCircle(),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "삭제된 데이터는 복구되지 않습니다. 삭제되는 내용을\n확인하시고 필요한 데이터는 미리 백업을 해주세요.",
                        style: context.style.caption1.copyWith(
                          color: context.color.gray600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        text: "확인했어요",
        onTap: () => _showConfirmDialog(
          () => controller.onUserDeletePressed(),
        ),
      ),
    );
  }

  void _showConfirmDialog(
    VoidCallback onConfirmPressed,
  ) {
    CommonDialog.show(
      title: "회원탈퇴를 하시겠어요?",
      confirmText: "탈퇴",
      onConfirm: onConfirmPressed,
    );
  }
}

class _HeadLineCircle extends StatelessWidget {
  const _HeadLineCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: context.color.gray600,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
