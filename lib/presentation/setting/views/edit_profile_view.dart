import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/bottom_button.dart';
import 'package:tripStory/presentation/common/button/profile_image_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/text/area/text_area_form_field.dart';
import 'package:tripStory/presentation/common/text/input/error_text_form_field.dart';
import 'package:tripStory/presentation/setting/controllers/edit_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _nickCon = TextEditingController();
  final TextEditingController _memoCon = TextEditingController();
  final EditProfileController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _nickCon.text = _controller.user?.nickName ?? "";
    _memoCon.text = _controller.user?.memo ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppAppbar(
          text: "프로필",
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 38,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ProfileImageButton(
                  onPressed: () => controller.onProfilePressed(
                    ImageSource.gallery,
                    context,
                  ),
                  url: controller.user?.profileImg ?? "",
                  pickedImage: controller.state.profileImage,
                  iconPath: IconConstants.photo,
                ),
              ),
              const SizedBox(height: 47),
              Text(
                "닉네임",
                style: context.style.caption1.copyWith(
                  color: context.color.gray700,
                ),
              ),
              const SizedBox(height: 10),
              ErrorTextFormField(
                controller: _nickCon,
                textStyle: context.style.body2Normal,
                backgroundColor: context.color.gray50,
                hintText: "8자 이내의 한글,영문만 가능해요",
                onChanged: (text) => controller.onNickNameChanged(text),
                contentPadding: const EdgeInsets.all(16),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
                showError: !controller.state.isNicknameValid,
                errorText: "8자 이내의 한글,영문만 가능해요",
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${controller.state.nickNameLength}",
                      style: context.style.caption2.copyWith(
                        color: controller.state.nickName.isEmpty ? context.color.gray400 : context.color.gray800,
                      ),
                    ),
                    Text(
                      "/8",
                      style: context.style.caption2.copyWith(
                        color: context.color.gray400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "자기소개",
                style: context.style.caption1.copyWith(
                  color: context.color.gray700,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextAreaFormField(
                controller: _memoCon,
                height: 76,
                hintText: "자기소개를 작성해 주세요",
                backgroundColor: context.color.gray50,
                maxTextLength: 16,
                onChanged: (text) => controller.onMemoChanged(text),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom / 2,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: "저장하기",
          enabled: controller.state.isNicknameValid,
          onTap: () => _showConfirmDialog(
            () => controller.onSaveProfilePressed(),
          ),
        ),
      );
    });
  }

  void _showConfirmDialog(
    VoidCallback onConfirmPressed,
  ) {
    CommonDialog.showConfirmCancel(
      title: "프로필을 수정하시겠습니까?",
      confirmText: "확인",
      onConfirm: onConfirmPressed,
    );
  }

  @override
  void dispose() {
    _nickCon.dispose();
    _memoCon.dispose();
    super.dispose();
  }
}
