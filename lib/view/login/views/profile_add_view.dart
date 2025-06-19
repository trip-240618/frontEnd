import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/button/image_button.dart';
import 'package:tripStory/common/text/error_text_form_field.dart';
import 'package:tripStory/component/container/circle_badge.dart';
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
                // Container(
                //   width: Get.width,
                //   // height: 64,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Color(0xffE0E0E0)),
                //       borderRadius: BorderRadius.circular(12)
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left:12,top: 8,),
                //         child: Text('닉네임',style: f14Gray500w400,),
                //       ),
                //       Container(
                //         child: TextFormField(
                //           controller: nameCon,
                //           textAlignVertical: TextAlignVertical.center,
                //           style: f16gray800w600,
                //           decoration: InputDecoration(
                //             isDense: true,
                //             contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                //             border: OutlineInputBorder(
                //               borderSide: BorderSide.none,
                //             ),
                //             hintText: '닉네임을 입력해주세요',
                //             hintStyle: f14Gray500w400,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Spacer(),
                // BottomContainer(
                //     onTap: () async {
                //       // if (isChecked == true) {
                //       //   if (pickedImage != null) {
                //     Map<String, dynamic> url = await us.profileFileUpload(pickedImage!);
                //       //     Map<String, dynamic> thumbnailUrl = await us.profileThumbnailUpload(pickedImage!);
                //       //     await us.userRegister(
                //       //         nameCon.text,
                //       //         '',
                //       //         '${url['preSignedUrls'][0].toString().split('?')[0]}',
                //       //         '${thumbnailUrl['preSignedUrls'][0].toString().split('?')[0]}',
                //       //         widget.marketing);
                //       //     Get.offAll(() => SuccessPage());
                //       //   } else {
                //       //     await us.userRegister(nameCon.text, '', '', '', widget.marketing);
                //       //     Get.offAll(() => SuccessPage());
                //       //   }
                //       // } else {
                //       //   regexCheck = true;
                //       //   setState(() {});
                //       // }
                //     },
                //     title: '다음',
                //     isBlack: isChecked ? true : false),
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
              onTap: () => {},
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
