import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../component/button.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';

class PPlanB extends StatefulWidget {
  const PPlanB({super.key});

  @override
  State<PPlanB> createState() => _PPlanBState();
}

class _PPlanBState extends State<PPlanB> {
  List planBList = [
    {'content':'항공편 KE371 도쿄행 인천 출발', 'checked':true, 'order': 0},
    {'content':'도쿄 디즈리랜드', 'checked':false, 'order': 1},
    {'content':'도쿄타워 보기', 'checked':true, 'order': 2},
    {'date':'2024-05-11','content':'타코야끼 먹기', 'checked':true, 'order': 3},
    {'date':'2024-05-12','content':'멘야무사시 츠케멘', 'checked':false, 'order': 4},
    {'date':'2024-05-13','content':'숙소 체크인', 'checked':false, 'order': 5}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      body: Padding(
        padding: const EdgeInsets.only(top:32, left: 20, right: 20),
        child: Column(
          children: [
            ReorderableListView.builder(
                shrinkWrap: true,
                itemCount: planBList.length,
                buildDefaultDragHandles: false,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    key: Key('${index}'),
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              planBList[index]['checked'] = !planBList[index]['checked'];
                              setState(() {
                              });
                            },
                            child: planBList[index]['checked']
                                ? Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Color(0xff5E91EE),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 6),
                                child: SvgPicture.asset(
                                  'assets/icon/check2.svg',
                                ),
                              ),
                            )
                                : SvgPicture.asset('assets/icon/unchecked.svg',),
                          ),
                          const SizedBox(width: 8,),
                          ReorderableDragStartListener(
                              index : index,
                              child: Text('${planBList[index]['content']}${index}',style: f14gray800w700,)),
                          Spacer(),
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                                child: SvgPicture.asset('assets/icon/rowEllipsis.svg'),
                              )),
                        ]
                      ),
                      const SizedBox(height: 24,),
                    ],
                  );
                }, onReorder: (int oldIndex, int newIndex) {

            },
            )

        ],
        ),
      ),
        floatingActionButton: PlusFloatingButton(
          backgroundColor: gray900,
          onPressed: ()  {
          },)


    );
  }
}
