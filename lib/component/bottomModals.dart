import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/textForm.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/main/tripAdd/tirpDirectSearch.dart';
import '../screen/main/tripAdd/tripSearch.dart';
import '../util/color.dart';
import '../util/font.dart';
import 'bottomContainer.dart';
import 'main/typeChoose.dart';

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