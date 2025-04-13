import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/notiState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/myPage/notice/setting_noti_detail.dart';


class SettingNotiMain extends StatefulWidget {
  const SettingNotiMain({super.key});

  @override
  State<SettingNotiMain> createState() => _SettingNotiMainState();
}

class _SettingNotiMainState extends State<SettingNotiMain> {
  final notiS = Get.put(Notistate());
  int selectField = 0;
  List filedList = ['전체','일반','업데이트','시스템'];

  @override
  void initState() {
    notiS.getNoti('전체');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '공지사항',onTap: (){Get.back();},color: Colors.white,),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Row(
              children: [
                GestureDetector(
                  onTap: ()async{
                    selectField = 0;
                    notiS.getNoti('전체');
                    setState(() {});
                  },
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
                    selectField = 1;
                    notiS.getNoti('일반');
                    setState(() {});
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
                    selectField = 2;
                    notiS.getNoti('업데이트');
                    setState(() {});
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
                    selectField = 3;
                    notiS.getNoti('시스템');
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectField==3?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('시스템',style: selectField==3?f14Whitew700:f14gray400w700),
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
                    itemCount: notiS.notiList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (contexts, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: ()async{
                          notiS.notiDetailList.clear();
                          await notiS.getDetailNoti(notiS.notiList[index]['id'], notiS.notiList[index]['type']);
                          Get.to(()=>SettingNotiDetail());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12,),
                            Text('[${notiS.notiList[index]['type']}] ${notiS.notiList[index]['title']}',style: f14Gray600w600,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 2,),
                            Text('${notiS.notiList[index]['createDate']}',style: f12gray400w500,),
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
      )),
    );
  }
}
