import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/screen/myPage/notice/setting_noti_detail.dart';
import '../../../component/appbar.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class SettingNotiMain extends StatefulWidget {
  const SettingNotiMain({super.key});

  @override
  State<SettingNotiMain> createState() => _SettingNotiMainState();
}

class _SettingNotiMainState extends State<SettingNotiMain> {
  int selectField = 0;
  List filedList = ['전체','일반','업데이트','시스템'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '공지사항',onTap: (){Get.back();},color: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Row(
              children: [
                GestureDetector(
                  onTap: ()async{},
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectField==0?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('전체',style: selectField==0?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()async{
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectField==1?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('일반',style: selectField==1?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()async{

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectField==2?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('업데이트',style: selectField==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()async{

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectField==2?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('시스템',style: selectField==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 3,
                    padding: EdgeInsets.zero,
                    itemBuilder: (contexts, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Get.to(()=>SettingNotiDetail());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12,),
                            Container(
                                child: Text('[${filedList[selectField]}] 전산시스템 점검에 따른 서비스 일부 제한 안내 (8월 2일 04시 - 06시)',style: f14Gray600w600,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                            const SizedBox(height: 2,),
                            Text('2024.07.31',style: f12gray400w500,),
                            const SizedBox(height: 16,),
                            Divider(
                              thickness: 1,
                              color: gray200,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
