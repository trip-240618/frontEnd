import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../util/color.dart';
import '../util/font.dart';

/// 메세지만 있는 확인용 다이얼로그
showConfirmTapDialog(
    BuildContext context){
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.only(top: 40,bottom: 25),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 350,
          child: Text('에러가 감지되었습니다 잠시후 다시 접속해주세요',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              SystemNavigator.pop();
            },
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '확인',
                ),
              ),
            ),
          ),
        )
      ],
    );
  });
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.only(top: 40,bottom: 25),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 350,
          child: Text('잠시후 다시 접속해주세요',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              if(Platform.isAndroid){
                SystemNavigator.pop();
              }else{
                exit(0);
              }
            },
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '확인',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


InviteDialog(BuildContext context, String title, VoidCallback onTap) {
  TextEditingController con = TextEditingController();
  showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 24,horizontal:20 ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight, // 오른쪽 끝으로 정렬
                  child: SvgPicture.asset('assets/icon/close.svg'),
                ),
              ),
              const SizedBox(height: 68),
              Center(
                child: Text(
                  '초대코드를 입력해주세요',
                  textAlign: TextAlign.center,
                  style: f16gray600w700,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: con,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 17.5, 15, 15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEEEEEE)), // 색상 설정
                    borderRadius: BorderRadius.circular(4), // radius 설정
                  ),
                    hintText: '숫자 6자리 코드를 입력해주세요',
                    hintStyle: f14Gray400w500,
                    counterText:'',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SvgPicture.asset(
                      'assets/icon/send.svg',
                      width: 12,
                      fit: BoxFit.none,
                      color: Color(0xFFBDBDBD), // 아이콘 색상
                    ),
                  ),
                  ),
              ),
              const SizedBox(height: 80),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Container(
                  width: Get.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: gray500,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Center(
                      child: Text(
                        '연결하기',
                        style: f16Whitew600,
                      )),
                ),
              ),
            )
          ],
        );
      });
}