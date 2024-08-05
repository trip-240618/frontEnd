import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('트립스토리에서 활동할'),
            Text('프로필을 등록해봐요'),
            const SizedBox(height: 14),
            Text('프로필 사진은 나중에도 등록 가능해요.'),
            const SizedBox(height: 32),
            Center(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 109,
                      height: 109,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff666666)
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                      ),
                    ),
                  )
                ],),
            ),
            const SizedBox(height: 32),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('서비스 이용약관 전체 동의')),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Get.to(()=>ProfileScreen());
              },
              child: Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffEEEEEE)
                ),
                child: Center(child: Text('다음으로')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
