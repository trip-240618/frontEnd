import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../component/bottomContainer.dart';
import '../../util/font.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  TextEditingController nameCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('트립스토리에서 활동할',style: f24gray900w700,),
            Text('프로필을 등록해봐요',style: f24gray900w700,),
            const SizedBox(height: 14),
            Text('프로필 사진은 나중에도 등록 가능해요.',style: f14Gray500w500,),
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
                        color: Color(0xffD9D9D9)
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 40,
                      height: 36,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffECECEC)),
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: SvgPicture.asset('assets/icon/camera.svg',fit: BoxFit.none),
                    ),
                  )
                ],),
            ),
            const SizedBox(height: 32),
            Container(
              width: Get.width,
              // height: 64,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:12,top: 8,),
                    child: Text('닉네임',style: f14Gray500w400,),
                  ),
                  Container(
                    child: TextFormField(
                      controller: nameCon,
                      textAlignVertical: TextAlignVertical.center,
                      style: f16gray800w600,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: '닉네임을 입력해주세요',
                        hintStyle: f14Gray500w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomContainer(onTap: (){
              // Get.to(()=>ProfileScreen());
            }),
          ],
        ),
      ),
    );
  }
}
