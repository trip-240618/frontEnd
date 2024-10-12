import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/appbar.dart';
import '../../../controller/notiState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class SettingNotiDetail extends StatefulWidget {
  const SettingNotiDetail({super.key});

  @override
  State<SettingNotiDetail> createState() => _SettingNotiDetailState();
}

class _SettingNotiDetailState extends State<SettingNotiDetail> {
  final notiS = Get.put(Notistate());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '',onTap: (){Get.back();},color: Colors.white,),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('[${notiS.notiDetailList['type']}] ${notiS.notiDetailList['title']}',style: f20gray800w700,),
            const SizedBox(height: 6,),
            Text('${notiS.notiDetailList['createDate'].split('T')[0]??''}',style: f12gray400w500,),
            const SizedBox(height: 27,),
            Container(
                height: Get.height*0.6,
                child: SingleChildScrollView(child: Text('${notiS.notiDetailList['content']}',style: f14gray600w500,))),
            Spacer(),
            Text('관련하여 궁금하신 사항은 고객센터 이메일(help@tripstory.com)으로 문의주시면 확인 후 빠르게 도움 드릴 수 있도록 하겠습니다. 감사합니다',style: f14gray600w500,),
          ],
        ),
      )),
    );
  }
}
