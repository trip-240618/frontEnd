import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/textForm/termsForm.dart';
import 'package:tripStory/component/url_launch.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/login/register/profile.dart';

class TermView extends StatefulWidget {
  const TermView({super.key});

  @override
  State<TermView> createState() => _TermViewState();
}

class _TermViewState extends State<TermView> {
  bool allCheck = true;

  /// 전체 동의 체크
  bool policyCheck = false;

  /// 이용약관 체크
  bool privatePolicyCheck = false;

  /// 개인정보 처리방침 체크
  bool locationCheck = false;

  /// 위치 정보 서비스 이용약관
  bool inforCheck = false;

  /// 제3자 정보제공 동의
  bool maratCheck = false;

  /// 마케팅 정보 수신 동의
  bool isChecked = false;

  /// 약관동의 체크
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: gray900),
                  child: Center(
                      child: Text(
                    '1',
                    style: f12Whitew700,
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: gray200),
                  child: Center(
                      child: Text(
                    '2',
                    style: f12Whitew700,
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '가입을 완료하려면',
              style: f22gray900w700,
            ),
            Text(
              '서비스 약관 동의가 필요해요',
              style: f22gray900w700,
            ),
            const SizedBox(height: 35),
            GestureDetector(
              onTap: () {
                allCheck = !allCheck;
                if (!allCheck) {
                  policyCheck = true;
                  privatePolicyCheck = true;
                  locationCheck = true;
                  inforCheck = true;
                  maratCheck = true;
                }
                updateAllCheckStatus();
                setState(() {});
              },
              child: Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                    border: allCheck ? Border.all(color: gray200, width: 1) : Border.all(color: gray900, width: 1.5),
                    color: gray50,
                    borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      allCheck
                          ? Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffE0E0E0), width: 1.5),
                                  borderRadius: BorderRadius.circular(2)),
                            )
                          : Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(color: gray900, borderRadius: BorderRadius.circular(2)),
                              child: SvgPicture.asset('assets/icon/smallCheck.svg', fit: BoxFit.none),
                            ),
                      const SizedBox(width: 8),
                      Text('서비스 이용약관 전체 동의', style: f15gray900w600),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: 44,
                    child: termsForm(
                        text: '(필수) 서비스 이용약관',
                        value: policyCheck,
                        onPressed1: () {
                          policyCheck = !policyCheck;
                          updateAllCheckStatus();
                          setState(() {});
                        },
                        onPressed2: () async {
                          await urlLaunch('https://trip-story.site/policy/service');
                        }),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 44,
                    child: termsForm(
                        text: '(필수) 개인정보 수집 및 이용약관',
                        value: privatePolicyCheck,
                        onPressed1: () {
                          privatePolicyCheck = !privatePolicyCheck;
                          updateAllCheckStatus();
                          setState(() {});
                        },
                        onPressed2: () async {
                          await urlLaunch('https://trip-story.site/policy/privacy');
                        }),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 44,
                    child: termsForm(
                        text: '(필수) 위치정보 서비스 이용약관',
                        value: locationCheck,
                        onPressed1: () {
                          locationCheck = !locationCheck;
                          updateAllCheckStatus();
                          setState(() {});
                        },
                        onPressed2: () async {
                          await urlLaunch('https://trip-story.site/policy/location');
                        }),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 44,
                    child: termsForm(
                        text: '(필수) 제3자 정보제공 동의',
                        value: inforCheck,
                        onPressed1: () {
                          inforCheck = !inforCheck;
                          updateAllCheckStatus();
                          setState(() {});
                        },
                        onPressed2: () async {
                          await urlLaunch('https://trip-story.site/policy/offerl');
                        }),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 44,
                    child: termsForm(
                        text: '(선택) 마케팅 정보 수신 동의',
                        value: maratCheck,
                        onPressed1: () {
                          maratCheck = !maratCheck;
                          updateAllCheckStatus();
                          setState(() {});
                        },
                        onPressed2: () async {
                          await urlLaunch('https://trip-story.site/policy/marketing');
                        }),
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomContainer(
              onTap: () async {
                if (isChecked) {
                  Get.to(() => ProfilePage(
                        marketing: maratCheck,
                      ));
                } else {
                  showOnlyConfirmTapDialog(context, '약관에 동의해주세요', () {
                    Get.back();
                  });
                }
              },
              title: '다음',
              isBlack: isChecked ? true : false,
            )
          ],
        ),
      ),
    );
  }

  /// 권한
  void updateAllCheckStatus() {
    if (policyCheck && privatePolicyCheck && locationCheck && inforCheck) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }
}
