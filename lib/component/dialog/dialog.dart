import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/trip/bottomNavigator.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/flight_edit.dart';
import '../../util/color.dart';
import '../../util/font.dart';
import '../../util/upper_case.dart';
import '../textForm/textform.dart';

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


InviteDialog(BuildContext context, VoidCallback onTap) {
  TextEditingController con = TextEditingController();
  final ms = Get.put(MainState());
  final ts = Get.put(TripState());
  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  bool isRegCheck = false;
  bool isFirstCheck = false;
  bool isValue =false; /// 값이 있나없나
  showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
         builder: (context, StateSetter setState){
           return GestureDetector(
             onTap: (){
               FocusScope.of(context).unfocus();
             },
             child: AlertDialog(
               backgroundColor: Colors.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(14),
               ),
               content: SingleChildScrollView(
                 physics: const NeverScrollableScrollPhysics(),
                 child: Column(
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
                     Text(
                       '초대 코드 입력',
                       style: f18Gray800w600,
                     ),
                     const SizedBox(height: 10),
                     TextIconFormFields2(
                       controller: con,
                       hintText: '영문+숫자 8자리를 입력해 주세요',
                       icon: 'assets/icon/invitation.svg',
                       onChanged: (values){
                         if (con.text.length == 8 && regex.hasMatch(con.text)) {
                           isRegCheck = true;
                         }
                         setState(() {});
                       },
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(8),
                         UpperCaseTextFormatter(),
                       ],
                     ),
                     !isFirstCheck?SizedBox():isRegCheck==true?SizedBox():Padding(
                       padding: const EdgeInsets.only(left: 16,top: 4),
                       child: Text('초대 코드는 영문+숫자 8자리입니다',style: f12redw500,),
                     ),
                     isFirstCheck&&isRegCheck && !isValue?Padding(
                       padding: const EdgeInsets.only(left: 16,top: 4),
                       child: Text('존재하지 않는 초대 코드입니다',style: f12redw500,),
                     ):const SizedBox(),
                     const SizedBox(height: 80),
                   ],
                 ),
               ),
               contentPadding: const EdgeInsets.symmetric(vertical: 24,horizontal:20 ),
               insetPadding: const EdgeInsets.symmetric(vertical: 24 ,horizontal:20 ),
               actions: [
                 GestureDetector(
                   onTap: ()async{
                     ts.selectTripList.clear();
                     isFirstCheck = true;
                     if (con.text.length == 8 && regex.hasMatch(con.text)) {
                       isRegCheck = true;
                       Map<String,dynamic> data = await ms.tripJoin('${con.text}');
                       if(data.isEmpty){
                        isValue = false;
                       }else{
                         await ts.getSelectTrip(data['id']);
                         Get.back();
                         Get.to(()=>BottomNavigator());
                       }
                     }else{
                       isRegCheck = false;
                     }
                     setState(() {});
                   },
                   behavior: HitTestBehavior.opaque,
                   child: Center(
                     child: Container(
                       width: Get.width,
                       height: 60,
                       decoration: BoxDecoration(
                           color: isRegCheck?gray900:gray300,
                           borderRadius: BorderRadius.circular(4)
                       ),
                       child: Center(
                           child: Text(
                             '연결하기',
                             style: isRegCheck?f16Whitew600:f16gray400w700,
                           )),
                     ),
                   ),
                 )
               ],
             ),
           );
         }
        );
      });
}

CodeDialog(BuildContext context,int tripId,String code) {
  final ms = Get.find<MainState>();
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async =>false,
          child: AlertDialog(
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
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '초대코드 생성',
                    textAlign: TextAlign.center,
                    style: f20gray600w700,
                  ),
                ),
                const SizedBox(height: 8),
                Center(child: Text('${code}',style: f28gray600w700,)),
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
                      ms.kakaoShare(tripId,'${code}');
                      // ms.kakaoShare();
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
                            color: gray900,
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
          ),
        );
      });
}

/// 확인버튼 함수 주는거
showOnlyConfirmTapDialog(BuildContext context, String title, VoidCallback confirmTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          content: Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32,top: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${title}',
                    style: f18Gray800w600,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: confirmTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),color: Colors.black,),
                      child: Center(
                          child: Text(
                            '확인', style: f16whitew400,
                          )),
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
showConfirmCancelTapDialog(BuildContext context, String title,String actionText, String? message, VoidCallback confirmTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          content: Container(
            width: Get.width,
            child: Padding(
                  padding: const EdgeInsets.only(bottom: 32,top: 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${title}',
                        style: f18Gray800w600,
                        textAlign: TextAlign.center,
                      ),
                      message!=null?
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('${message}',style: f14Gray400w500, textAlign: TextAlign.center,),
                      ) :SizedBox()
                    ],
                  ),
                ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), color: gray200,),
                      child: Center(
                          child: Text(
                            '취소',
                            style: f16gray600w400,
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: GestureDetector(
                    onTap: confirmTap,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),color: Colors.black,),
                      child: Center(
                          child: Text(
                            '${actionText}', style: f16whitew400,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      });
}


FlightDialog(BuildContext context, VoidCallback onTap) {
  final ts = Get.put(TripState());
  final js = Get.put(JPlanState());

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation1, animation2) {
      return Material(
        color: Colors.transparent, // 투명 배경
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: gray900,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                    child: Row(
                      children: [
                        Text('항공권', style: f15Whitew600,),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                            Get.to(()=>FlightEdit());

                          },
                          child: SvgPicture.asset('assets/icon/pencil.svg',width: 25,),
                        ),
                        const SizedBox(width: 14,),
                        GestureDetector(
                          onTap: (){
                            Get.back();

                          },
                          child: SvgPicture.asset('assets/icon/xicon.svg',width: 22,),
                        )
                      ],
                    ),

                  ),
                ),
                Container(
                  width: Get.width,
                  height: 540,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/icon/ticketBox.svg',
                        width: Get.width, // 크기 조정
                        height: Get.height,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: 32,
                        left: 24,
                        right: 24,
                        child: Container(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('항공편명', style: f12gray600w600,),
                              const SizedBox(height: 8,),
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1, color: gray200),
                                ),
                                child: Padding(padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/plane.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                                      const SizedBox(width: 7,),
                                      Text(js.flightList[0]['airlineCode']==null?'':'${js.flightList[0]['airlineCode']} ${js.flightList[0]['airlineNumber']}', style: f15gray800w500,),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Text('출발 공항', style: f12gray600w600,),
                              const SizedBox(height: 8,),
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1, color: gray200),
                                ),
                                child: Padding(padding: EdgeInsets.all(16),
                                  child: Text('${js.flightList[0]['departureAirport_kr']}(${js.flightList[0]['departureAirport']})', style: f15gray800w500,),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Text('출발 일정', style: f12gray600w600,),
                              const SizedBox(height: 8,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1, color: gray200),
                                ),
                                child: Padding(padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/departureFlight.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                                      const SizedBox(width: 6,),
                                      Text('${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.parse(js.flightList[0]['departureDate']).toLocal())}', style: f15gray800w500,),
                                      Text(' ${js.flightList[0]['departureDate'].split('T')[1].split('+')[0]}', style: f15gray800w500,),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                              Text('도착 공항', style: f12gray600w600,),
                              const SizedBox(height: 8,),
                              Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1, color: gray200),
                                ),
                                child: Padding(padding: EdgeInsets.all(16),
                                  child: Text('${js.flightList[0]['arrivalAirport_kr']}(${js.flightList[0]['arrivalAirport']})', style: f15gray800w500,),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Text('도착 일정', style: f12gray600w600,),
                              const SizedBox(height: 8,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1, color: gray200),
                                ),
                                child: Padding(padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icon/arrivalFlight.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                                      const SizedBox(width: 6,),
                                      Text('${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.parse(js.flightList[0]['arrivalDate']).toLocal())}', style: f15gray800w500,),
                                      Text(' ${js.flightList[0]['arrivalDate'].split('T')[1].split('+')[0]}', style: f15gray800w500,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


Future<void> updateVersionDialog(BuildContext context) {
  final us = Get.put(UserState());
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.only(top: 35, bottom: 35),
          content: Container(
            width: Get.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: Text('새로운 버전이 출시되었습니다!\n여러분의 소중한 의견을 반영해 더 편리하게\n개선했어요.',style: f14gray900w500,)),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: ()async{
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('lastIgnoredVersion', us.versionList['iosVersion']);
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      height: 42,
                      decoration: BoxDecoration(
                        color: gray200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '나중에',
                          style: f16gray600w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      StoreRedirect.redirect(androidAppId: "com.tripStorys.tripstorys", iOSAppId: "6529530493");
                    },
                    child: Container(
                      width: Get.width,
                      height: 42,
                      decoration: BoxDecoration(
                        color: gray900,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '업데이트',
                          style: f16whitew400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}

Future<void> forceUpdateVersionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.only(top: 35, bottom: 35),
          content: Container(
            width: Get.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(child: Text('새로운 버전이 출시되었습니다!\n여러분의 소중한 의견을 반영해 더 편리하게\n개선했어요.',style: f14gray900w500,)),
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                StoreRedirect.redirect(androidAppId: "com.tripStorys.tripstorys", iOSAppId: "6529530493");
              },
              child: Container(
                width: Get.width,
                height: 42,
                decoration: BoxDecoration(
                  color: gray900,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '업데이트',
                    style: f16whitew400,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

/// 네트워크 다이얼로그
Future<void> netWorkingDialog() async{
  if (!(Get.isDialogOpen ?? false)) {
    return await Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          content: Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32,top: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '네트워크 연결 후 다시 시도해주세요',
                    style: f18Gray800w600,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: ()async{
                      final connectivityResult = await Connectivity().checkConnectivity();
                      if (connectivityResult[0] != ConnectivityResult.none) {
                        Get.back();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),color: Colors.black,),
                      child: Center(
                          child: Text(
                            '재시도',
                            style: f16whitew400,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}

