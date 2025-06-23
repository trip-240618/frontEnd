import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/button/image_button.dart';
import 'package:tripStory/common/text/error_text_form_field.dart';
import 'package:tripStory/component/container/circle_badge.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/validator/regex_patterns.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/login/controller/profile_add_controller.dart';

class ProfileAddView extends StatefulWidget {
  final bool marketing;

  const ProfileAddView({
    super.key,
    required this.marketing,
  });

  @override
  State<ProfileAddView> createState() => _ProfileAddViewState();
}

class _ProfileAddViewState extends State<ProfileAddView> {
  final TextEditingController _nickNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileAddController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleBadge(
                      text: "1",
                      backgroundColor: context.color.gray200,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleBadge(
                      text: "2",
                      backgroundColor: context.color.gray900,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "트립스토리에서\n사용할 프로필을 설정해 주세요",
                  style: context.style.heading1,
                ),
                Text(
                  "프로필 사진은 가입 이후에도 설정 가능해요",
                  style: context.style.label1Normal,
                ),
                const SizedBox(height: 48),
                Center(
                  child: ImageButton(
                    pickedImage: controller.state.profileImage,
                    onPressed: () => controller.onProfilePressed(
                      ImageSource.gallery,
                      context,
                    ),
                    iconPath: IconConstants.plus,
                  ),
                ),
                Text(
                  "닉네임",
                  style: context.style.caption1.copyWith(
                    color: context.color.gray600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ErrorTextFormField(
                  controller: _nickNameCon,
                  textStyle: context.style.body2Normal,
                  hintText: "8자 이내의 한글,영문만 가능해요",
                  onChanged: (text, isValid) => controller.onTextChanged(text, isValid),
                  contentPadding: const EdgeInsets.all(16),
                  inputFormatters: [LengthLimitingTextInputFormatter(8)],
                  trailing: Text(
                    "${_nickNameCon.text.length}/8",
                    style: context.style.caption2.copyWith(
                      color: context.color.gray400,
                    ),
                  ),
                  regexText: "8자 이내의 한글,영문만 가능해요",
                  regexPattern: RegexPatterns.nickname,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 42,
            ),
            child: BottomButton(
              text: "다음",
              enabled: controller.state.isNicknameValid,
              onTap: () => controller.onNextPressed(
                widget.marketing,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nickNameCon.dispose();
    super.dispose();
  }
}
