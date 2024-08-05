import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/termsForm.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({Key? key}) : super(key: key);

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
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
            Text('트립스토리'),
            Text('약관 동의가 필요해요'),
            const SizedBox(height: 30),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('서비스 이용약관 전체 동의')),
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
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffEEEEEE)
              ),
              child: Center(child: Text('다음으로')),
            )


          ],
        ),
      ),
    );
  }
}
