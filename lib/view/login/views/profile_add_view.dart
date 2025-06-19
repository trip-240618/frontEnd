import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/button/image_button.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/container/circle_badge.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/controller/profile_add_controller.dart';
import 'package:tripStory/view/login/register/success.dart';

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
  final ms = Get.put(MainState());
  final us = Get.put(UserState());
  TextEditingController nameCon = TextEditingController();

  /// 닉네임
  XFile? pickedImage;

  /// 프로필 이미지
  bool isChecked = false;

  /// 약관동의 체크
  bool regexCheck = false;

  /// 주의사항 문구
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileAddController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
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
                    '트립스토리에서\n사용할 프로필을 설정해 주세요',
                    style: context.style.heading1,
                  ),
                  Text(
                    '프로필 사진은 가입 이후에도 설정 가능해요',
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
                    '닉네임',
                    style: f12gray600w600,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: nameCon.text.trim().isEmpty
                            ? Border.all(color: gray200)
                            : Border.all(color: gray900, width: 1.5),
                        color: gray50),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameCon,
                              autofocus: false,
                              style: f16gray800w600,
                              onChanged: (v) {
                                final regex = RegExp(r'^[가-힣a-zA-Z]{1,8}$');
                                if (regex.hasMatch('${nameCon.text}')) {
                                  isChecked = true;
                                  regexCheck = false;
                                } else {
                                  isChecked = false;
                                }
                                setState(() {});
                              },
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(8),
                              ],
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '8자 이내의 한글,영문만 가능해요',
                                hintStyle: f15gray400w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${nameCon.text.length}',
                              style: nameCon.text.trim().isEmpty ? f11Gray400w600 : f11Gray800w600),
                          Text(
                            '/8',
                            style: f11Gray400w600,
                          )
                        ],
                      ),
                    ),
                  ),
                  regexCheck
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            '8자 이내의 한글,영문만 가능해요',
                            style: f11redw500,
                          ),
                        )
                      : SizedBox(),
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
                  BottomContainer(
                      onTap: () async {
                        if (isChecked == true) {
                          if (pickedImage != null) {
                            Map<String, dynamic> url = await us.profileFileUpload(pickedImage!);
                            Map<String, dynamic> thumbnailUrl = await us.profileThumbnailUpload(pickedImage!);
                            await us.userRegister(
                                nameCon.text,
                                '',
                                '${url['preSignedUrls'][0].toString().split('?')[0]}',
                                '${thumbnailUrl['preSignedUrls'][0].toString().split('?')[0]}',
                                widget.marketing);
                            Get.offAll(() => SuccessPage());
                          } else {
                            await us.userRegister(nameCon.text, '', '', '', widget.marketing);
                            Get.offAll(() => SuccessPage());
                          }
                        } else {
                          regexCheck = true;
                          setState(() {});
                        }
                      },
                      title: '다음',
                      isBlack: isChecked ? true : false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
