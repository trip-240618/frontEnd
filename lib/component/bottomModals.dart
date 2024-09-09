import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/main/tripAdd/tirpDirectSearch.dart';
import '../screen/main/tripAdd/tripSearch.dart';
import '../util/color.dart';
import '../util/font.dart';
import 'bottomContainer.dart';


void bottomModel(BuildContext context) {
  final ms = Get.put(MainState());

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: Get.height * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 44),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color:greyColor
                          ),
                        ),
                      ),
                      const SizedBox(height: 33),
                      TabBar(
                        onTap: (int i) {
                          if(i==1){
                            ms.tripCitySearchCon.text = '';
                            ms.selectedCity = '';
                          }else if(i==0){

                          }
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        unselectedLabelColor: Colors.red,
                        unselectedLabelStyle: f16gray300w600,
                        controller: ms.tabController,
                        indicatorColor: gray600,
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
                                    style: ms.tabController.index==0?f16gray600w700:f16gray300w600,
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
                                    style: ms.tabController.index==1?f16gray600w700:f16gray300w600,
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
                            TripSearchPage(),
                            TripDirectSearchPage(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      BottomContainer(onTap: ()async{
                        await ms.saveDestination();
                      },title: '저장')
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}

void timeBottomModel(BuildContext context, DateTime selectedTime) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: (){
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
                            Text('시간 입력', style: f14whitew500,),
                            Spacer(),
                            GestureDetector(
                                onTap: (){Get.back();},
                                child: SvgPicture.asset('assets/icon/close.svg', color: Colors.white,)),
                          ],
                        ),),

                    ),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: selectedTime,
                          onDateTimeChanged: (DateTime newDateTime) {
                            setState(() {
                              selectedTime = newDateTime;
                            });
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
void sendBottomModal(BuildContext context) {
  showModalBottomSheet(
      context: context,

      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color:greyColor
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text('초대 코드를 복사했어요',style: f18gray800w700,),
                      const SizedBox(height: 20,),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icon/kakao.svg'),
                              const SizedBox(width: 20),
                              Text('카카오톡으로 공유하기',style: f15gray800w600,)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icon/copy.svg'),
                              const SizedBox(width: 20),
                              Text('초대 코드 복사하기',style: f15gray800w600,)
                            ],
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