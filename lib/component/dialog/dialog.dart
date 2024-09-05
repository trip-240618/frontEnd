import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/screen/trip/bottomNavigator.dart';
import 'package:tripStory/controller/mainState.dart';
import '../../util/color.dart';
import '../../util/font.dart';

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
                textAlignVertical: TextAlignVertical.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
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

CodeDialog(BuildContext context) {
  final ms = Get.find<MainState>();
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 24,horizontal:20 ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // GestureDetector(
              //   onTap: (){
              //     Get.back();
              //   },
              //   child: Align(
              //     alignment: Alignment.centerRight, // 오른쪽 끝으로 정렬
              //     child: SvgPicture.asset('assets/icon/close.svg'),
              //   ),
              // ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '초대코드 생성',
                  textAlign: TextAlign.center,
                  style: f20gray600w700,
                ),
              ),
              const SizedBox(height: 8),
              Center(child: Text('245860',style: f40gray600w700,)),
              const SizedBox(height: 18),
              Text('초대코드로 친구를 초대해보세요.',style: f14Gray400w500,),
              Text('방 생성 이후에도 초대코드를',style: f14Gray400w500,),
              Text('공유할 수 있습니다.',style: f14Gray400w500,),
              const SizedBox(height: 50)
            ],
          ),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    ms.kakaoShare();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: gray200,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: SvgPicture.asset('assets/icon/send.svg',fit: BoxFit.none,),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      ms.roomReset();
                      Get.back();
                      Get.back();
                      Get.to(()=>BottomNavigator());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: Get.width,
                      height: 60,
                      decoration: BoxDecoration(
                          color: gray500,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                          child: Text(
                            '여행방 이동',
                            style: f16Whitew600,
                          )),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      });
}

/// 확인버튼 함수 주는거
showOnlyConfirmTapDialog(BuildContext context, String title, VoidCallback confirmTap) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.only(top: 35, bottom: 35),
          content: Container(
            width: Get.width,
            child: Text(
              '${title}',
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: confirmTap,
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Container(
                        width: Get.width,
                        height: 42,
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                              '확인',
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      });
}

/// 확인 취소 다이얼로그
showConfirmCancelTapDialog(BuildContext context, String title, String message, VoidCallback confirmTap) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          title: Container(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Text(
                '${title}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          content:
              Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: Container(
                  width: Get.width,
                  child: Text(
                    '${message}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          actions: [
            Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      width: 130,
                      height: 60,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), color: gray200,),
                      child: Center(
                          child: Text(
                            '취소',
                          )),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: confirmTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 130,
                      height: 60,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),color: Colors.black,),
                      child: Center(
                          child: Text(
                            '확인', style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      });
}