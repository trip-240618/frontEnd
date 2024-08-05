import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key}) : super(key: key);

  @override
  State<LoginPage2> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 81,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('가장 편한 방법으로'),
            Text('빠르게 시작해 보세요!'),
            Spacer(),
            Center(child: Text('10초면 됩니다. 여행이 편해질 거예요!')),
            const SizedBox(height: 18),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffFEE500),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('카카오로 시작하기')),
            ),
            const SizedBox(height: 18),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('구글로 시작하기')),
            ),
            const SizedBox(height: 18),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('Apple로 시작하기')),
            )

          ],
        ),
      ),
    );
  }
}
