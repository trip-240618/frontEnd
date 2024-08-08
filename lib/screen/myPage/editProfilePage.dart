import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '프로필',onTap: (){Get.back();},),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 38,bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffD9D9D9)
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 31,
                      height: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(width: 1, color: Color(0xffECECEC))
                      ),
                      child: Icon(Icons.camera_alt, size: 20,),
                    ),
                  )
                ],),
            ),
            const SizedBox(height: 66),
            Container(
              width: Get.width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(child: Text('')),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
              },
              child: Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffEEEEEE)
                ),
                child: Center(child: Text('저장하기')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
