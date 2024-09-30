import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/addPlanPage.dart';

import '../../../../component/button.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';

class JPlanB extends StatefulWidget {
  const JPlanB({super.key});

  @override
  State<JPlanB> createState() => _JPlanBState();
}

class _JPlanBState extends State<JPlanB> {
  List planBList = [
    {"dayAfterStart": 1, "startTime": "18:00", "title": "신주쿠 빔즈 재팬 쇼핑",},
    {"dayAfterStart": 1, "startTime": "18:00", "title": "이세탄 백화점 쇼핑",},
    {"dayAfterStart": 1, "startTime": "20:00", "title": "도쿄 스카이트리 야경",},
    {"dayAfterStart": 2, "startTime": "13:00", "title": "도쿄 해리포터 스튜디오",},
  ];
  List dateList = ['2024-05-10', '2024-05-11', '2024-05-12', '2024-05-13', '2024-05-14'];

  /// M월/d일(E) 포멧터
  String customDateFormatter2(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('M.d (E)', 'ko').format(date);
    return formattedDate;
  }

  @override
  void initState() {
    print('dddd');
    print(customDateFormatter2('2024-05-10'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: dateList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // 부모와 충돌 방지
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(width: 1, color: gray200),
                            bottom: BorderSide(width: 1, color: gray200),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xff5E91EE), width: 1.5),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 12),
                                  child: Text(
                                    'Day${index + 1}',
                                    style: f12mainw700(Color(0xff5E91EE)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                customDateFormatter2('${dateList[index]}'),
                                style: f14Gray800w500,
                              ),
                              Spacer(),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0xff5E91EE),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Text('${planBList.where((item) => item["dayAfterStart"] == index + 1).length}', style: f12Whitew700,)),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  print('클릭클릭');
                                  setState(() {});
                                },
                                child: SvgPicture.asset(
                                    'assets/icon/caretDown.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (planBList.where((item) => item["dayAfterStart"] == index + 1).length == 0)
                          ? Container(height: 16, color: gray50,)
                          : Container(
                            color: gray50,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container(
                                      child: ListView.builder(
                                        shrinkWrap: true, // 자식 ListView가 크기를 확장할 수 있도록 설정
                                        physics: NeverScrollableScrollPhysics(), // 충돌 방지
                                        itemCount: planBList.where((item) => item["dayAfterStart"] == index + 1).length,
                                        itemBuilder: (context, planIndex) {
                                          var plan = planBList.where((item) => item["dayAfterStart"] == index + 1).toList()[planIndex];
                                          return Container(
                                            width: Get.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: gray200,
                                                        border:
                                                            Border.all(color: gray200),
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(4),
                                                          // 좌측 상단 반경 4px
                                                          topRight: Radius.circular(0),
                                                          // 우측 상단 반경 0px
                                                          bottomRight:
                                                              Radius.circular(0),
                                                          // 우측 하단 반경 0px
                                                          bottomLeft: Radius.circular(
                                                              4), // 좌측 하단 반경 4px
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 13.5,
                                                                vertical: 16),
                                                        child: Text(
                                                          plan["startTime"],
                                                          style: f12Gray800w500,
                                                        ),
                                                      )),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border:
                                                            Border.all(color: gray200),
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(0),
                                                          // 좌측 상단 반경 4px
                                                          topRight: Radius.circular(4),
                                                          // 우측 상단 반경 0px
                                                          bottomRight:
                                                              Radius.circular(4),
                                                          // 우측 하단 반경 0px
                                                          bottomLeft: Radius.circular(
                                                              0), // 좌측 하단 반경 4px
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 14),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              plan["title"],
                                                              style: f12Gray800w500,
                                                            ),
                                                            Spacer(),
                                                            SvgPicture.asset(
                                                                'assets/icon/columnEllipsis.svg')
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );

                                          //   Container(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 8, horizontal: 16),
                                          //   margin: const EdgeInsets.only(bottom: 4),
                                          //   child: Row(
                                          //     children: [
                                          //       Icon(Icons.check, color: Colors.blue),
                                          //       SizedBox(width: 8),
                                          //       Text(
                                          //         plan["title"] ?? '',
                                          //         style: TextStyle(fontSize: 14),
                                          //       ),
                                          //       Spacer(),
                                          //       Text(
                                          //         plan["startTime"] ?? '',
                                          //         style: TextStyle(color: Colors.grey),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: gray200),
                  bottom: BorderSide(width: 1, color: gray200),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 20),
                child: Row(
                  children: [

                    Text(
                      '날짜 미정',
                      style: f14Gray800w500,
                    ),
                    Spacer(),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xff5E91EE),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(child: Text('0', style: f12Whitew700,)),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        print('클릭클릭');
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                          'assets/icon/caretDown.svg'),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 100,color: gray50,),
          ],
        ),
      ),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: ()  {
            Get.to(()=>AddPlanPage());
          },)
    );
  }
}
