import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/dialog.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/main/tripAdd/tripRoomAdd.dart';
import '../../util/color.dart';
import '../../util/font.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ms = Get.put(MainState());

@override
  void dispose() {
    print('조옹');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
       titleSpacing: 0,
       toolbarHeight: 44,
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: GestureDetector(
               onTap: (){},
               child: SvgPicture.asset('assets/icon/person.svg')),
         )
       ],
     ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 44),
        child: Column(
          children: [
            Obx(()=> Row(
              children: [
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 0;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==0?gray700:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('다가오는 여행',style: ms.selectIdx==0?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 1;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==1?gray700:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('지난 여행',style: ms.selectIdx==1?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 2;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==2?gray700:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('북마크',style: ms.selectIdx==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                )
              ],
            )),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('최신순',style: f14gray400w700,),
                const SizedBox(width: 7),
                SvgPicture.asset('assets/icon/underArrow.svg')
              ],
            ),
            const SizedBox(height: 10),
            // EmptyScreen(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(4)
                            ),
                            child: Row(
                              children: [
                                Stack(
                                    children:[
                                      Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: gray300,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: gray400,
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                                            child: Text('D-31',style: f12Whitew700,),
                                          ),
                                        ),
                                      )
                                    ]
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 1.0, color: gray200),
                                        right: BorderSide(width: 1.0, color: gray200),
                                        bottom: BorderSide(width: 1.0, color: gray200),
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:10,right: 10,top: 12,bottom: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 6),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('5월 도쿄 여행방'),
                                                    Text('24.04.01 ~ 24.04.07')
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  SvgPicture.asset('assets/icon/send.svg',width: 20,),
                                                  const SizedBox(width: 12),
                                                  SvgPicture.asset('assets/icon/bookmark.svg',width: 16),
                                                ],
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('대한민국'),
                                              Container(
                                                height: 16,
                                                constraints: BoxConstraints(
                                                    maxWidth: Get.width * 0.3
                                                ),
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: 5,
                                                  shrinkWrap: true,
                                                  physics: const ClampingScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    return Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icon/user.svg',
                                                        ),
                                                        index==4?SizedBox():SizedBox(width: 4,)
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          index==4?SizedBox():SizedBox(height: 12)
                        ],
                      );
                    }),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    print('3132');
                    InviteDialog(context, 'dasdas', () {
                      print('2222');
                      Get.back();
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: gray200,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: SvgPicture.asset('assets/icon/chain.svg',fit: BoxFit.none,),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>TripRoomAddScreen());
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: gray500,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(child: Text('새 여행방 생성',style: f16Whitew600,)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
