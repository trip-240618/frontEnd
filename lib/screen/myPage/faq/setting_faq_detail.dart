import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/faqState.dart';
import '../../../component/appbar.dart';
import '../../../controller/notiState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class SettingFaqDetail extends StatefulWidget {
  const SettingFaqDetail({super.key});

  @override
  State<SettingFaqDetail> createState() => _SettingFaqDetailState();
}

class _SettingFaqDetailState extends State<SettingFaqDetail> {
  final fs = Get.put(FaqState());
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
            const SizedBox(height: 18,),
            Text('${fs.faqDetailList['title']}',style: f20gray800w700,),
            const SizedBox(height: 6,),
            Text('${fs.faqDetailList['type']}',style: f12gray400w500,),
            const SizedBox(height: 27,),
            Container(
                height: Get.height*0.6,
                child: SingleChildScrollView(child: Text('${fs.faqDetailList['content']}',style: f14gray600w500,))),
          ],
        ),
      )),
    );
  }
}
