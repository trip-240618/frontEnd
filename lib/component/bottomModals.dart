import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/font.dart';

void bottomModel(BuildContext context) {
  final ms = Get.put(MainState());

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: Get.height * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 44),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(color: greyColor),
                        ),
                      ),
                      const SizedBox(height: 33),
                      TabBar(
                        onTap: (int i) {
                          if (i == 1) {
                            ms.tripCitySearchCon.text = '';
                            ms.selectedCity.value = '';
                          } else if (i == 0) {
                            ms.tripDirectSearchCon.text = '';
                            ms.directSelectedCity.value = '';
                          }
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        unselectedLabelColor: Colors.red,
                        unselectedLabelStyle: f16gray300w600,
                        controller: ms.tabController,
                        indicatorColor: gray900,
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        // indicatorPadding: EdgeInsets.only(bottom: 8,top: 12),
                        overlayColor: MaterialStatePropertyAll(
                          Colors.transparent,
                        ),
                        tabs: [
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: Get.width,
                                child: Center(
                                  child: Text(
                                    '여행지 검색',
                                    style: ms.tabController.index == 0 ? f16gray900w700 : f16gray400w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '직접 입력',
                                    style: ms.tabController.index == 1 ? f16gray900w700 : f16gray400w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(
                          controller: ms.tabController,
                          children: [
                            // TripSearchPage(),
                            // TripDirectSearchPage(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => BottomContainer(
                            onTap: () async {
                              await ms.saveDestination();
                            },
                            title: '입력 완료',
                            isBlack: ms.tabController.index == 0
                                ? (ms.selectedCity.value == '' ? false : true)
                                : (ms.tripLeaveType == '해외'
                                    ? (ms.directSelectedCity.value == '' ? false : true)
                                    : (ms.tripDirectSearchCon.text.isEmpty ? false : true)),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}

void timeBottomModel(BuildContext context) {
  final js = Get.put(JPlanState());
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: 270,
                decoration: BoxDecoration(
                  color: Color(0xffF7F6FB),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: gray900,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              '시간 입력',
                              style: f14whitew500,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: SvgPicture.asset(
                                  'assets/icon/close.svg',
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: js.addSelectedDateTime.value,
                          onDateTimeChanged: (DateTime newDateTime) {
                            js.addSelectedDateTime.value = newDateTime;
                          },
                          use24hFormat: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
}

void sendBottomModal(BuildContext context, String inviteCode, int tripId) {
  final ms = Get.put(MainState());
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(color: greyColor),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        '초대 코드를 복사했어요',
                        style: f18gray800w700,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          ms.kakaoShare(tripId, inviteCode);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icon/kakao.svg'),
                                const SizedBox(width: 20),
                                Text(
                                  '카카오톡으로 공유하기',
                                  style: f15gray800w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: inviteCode));
                          fToast.showToast(
                            child: Container(
                              width: Get.width,
                              height: 58,
                              decoration: BoxDecoration(
                                color: Color(0xff212121).withOpacity(0.7), // 반투명한 배경
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x1A000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 9,
                                  ),
                                  BoxShadow(
                                    color: Color(0x17000000),
                                    offset: Offset(0, 16),
                                    blurRadius: 16,
                                  ),
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    offset: Offset(0, 36),
                                    blurRadius: 21,
                                  ),
                                  BoxShadow(
                                    color: Color(0x03000000),
                                    offset: Offset(0, 63),
                                    blurRadius: 25,
                                  ),
                                  BoxShadow(
                                    color: Color(0x00000000),
                                    offset: Offset(0, 99),
                                    blurRadius: 28,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icon/copy.svg',
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '초대코드를 복사했습니다',
                                    style: f14whitew600,
                                  ),
                                ],
                              )),
                            ),
                            gravity: ToastGravity.TOP,
                            toastDuration: Duration(seconds: 2),
                          );
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icon/copy.svg'),
                                const SizedBox(width: 20),
                                Text(
                                  '초대 코드 복사하기',
                                  style: f15gray800w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}

void appSendBottomModal(BuildContext context, String inviteCode) {
  final ms = Get.put(MainState());
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(color: greyColor),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        '앱 초대하기',
                        style: f18gray800w700,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // ms.kakaoShare();
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Container(width: 24, child: SvgPicture.asset('assets/icon/kakao.svg')),
                                const SizedBox(width: 20),
                                Text(
                                  '카카오톡으로 공유하기',
                                  style: f15gray800w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: inviteCode));
                          fToast.showToast(
                            child: Container(
                              width: Get.width,
                              height: 58,
                              decoration: BoxDecoration(
                                color: Color(0xff212121).withOpacity(0.7), // 반투명한 배경
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x1A000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 9,
                                  ),
                                  BoxShadow(
                                    color: Color(0x17000000),
                                    offset: Offset(0, 16),
                                    blurRadius: 16,
                                  ),
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    offset: Offset(0, 36),
                                    blurRadius: 21,
                                  ),
                                  BoxShadow(
                                    color: Color(0x03000000),
                                    offset: Offset(0, 63),
                                    blurRadius: 25,
                                  ),
                                  BoxShadow(
                                    color: Color(0x00000000),
                                    offset: Offset(0, 99),
                                    blurRadius: 28,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icon/copy.svg',
                                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '초대코드를 복사했습니다',
                                    style: f14whitew600,
                                  ),
                                ],
                              )),
                            ),
                            gravity: ToastGravity.TOP,
                            toastDuration: Duration(seconds: 2),
                          );
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  child: SvgPicture.asset('assets/icon/link.svg',
                                      fit: BoxFit.none, colorFilter: ColorFilter.mode(gray600, BlendMode.srcIn)),
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  '다른 방법으로 공유',
                                  style: f15gray800w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
