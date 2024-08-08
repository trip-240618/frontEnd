import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/screen/register/profile.dart';
import '../../component/register/termsForm.dart';
import '../../util/font.dart';

class TermPage extends StatefulWidget {
  const TermPage({Key? key}) : super(key: key);

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  bool policyCheck = false; // 이용약관 체크
  bool privatePolicyCheck = false; // 개인정보 처리방침 체크
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 81,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('트립스토리',style: f24gray900w700,),
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: '약관 동의', style:f24mainRedw700),
                      TextSpan(text: '가 필요해요',style: f24gray900w700),
                    ])
            ),
            const SizedBox(height: 30),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icon/check.svg'),
                  const SizedBox(width: 10),
                  Text('서비스 이용약관 전체 동의',style: f16Gray500w600),
                ],
              ),
            ),
            const SizedBox(height: 46),
            Container(
              height: 44,
              child: termsForm(
                  text: '(필수) 서비스 이용약관',
                  value: policyCheck,
                  onPressed1: () {
                    policyCheck = !policyCheck;
                    setState(() {});
                  },
                  onPressed2: () async {
                  }),
            ),
            const SizedBox(height: 10),
            Container(
              height: 44,
              child: termsForm(
                  text: '(필수) 개인정보 수집 및 이용약관',
                  value: policyCheck,
                  onPressed1: () {
                    policyCheck = !policyCheck;
                    setState(() {});
                  },
                  onPressed2: () async {

                  }),
            ),
            const SizedBox(height: 10),
            Container(
              height: 44,
              child: termsForm(
                  text: '(필수) 위치정보 서비스 이용약관',
                  value: policyCheck,
                  onPressed1: () {
                    policyCheck = !policyCheck;
                    setState(() {});
                  },
                  onPressed2: () async {
                  }),
            ),
            const SizedBox(height: 10),
            Container(
              height: 44,
              child: termsForm(
                  text: '(필수) 제3자 정보제공 동의',
                  value: policyCheck,
                  onPressed1: () {
                    policyCheck = !policyCheck;
                    setState(() {});
                  },
                  onPressed2: () async {
                  }),
            ),
            const SizedBox(height: 10),
            Container(
              height: 44,
              child: termsForm(
                  text: '(선택) 마케팅 정보 수신 동의',
                  value: policyCheck,
                  onPressed1: () {
                    policyCheck = !policyCheck;
                    setState(() {});
                  },
                  onPressed2: () async {

                  }),
            ),
            Spacer(),
            BottomContainer(onTap: (){
              Get.to(()=>ProfilePage());
            })
          ],
        ),
      ),
    );
  }
}
