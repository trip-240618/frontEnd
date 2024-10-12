import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/faqState.dart';
import 'package:tripStory/screen/myPage/faq/setting_faq_detail.dart';
import 'package:tripStory/screen/myPage/faq/setting_faq_search.dart';
import 'package:tripStory/screen/myPage/notice/setting_noti_detail.dart';

import '../../../component/appbar.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class SettingFaqMain extends StatefulWidget {
  const SettingFaqMain({super.key});

  @override
  State<SettingFaqMain> createState() => _SettingFaqMainState();
}

class _SettingFaqMainState extends State<SettingFaqMain> {
  final fs = Get.put(FaqState());
  int selectField = 0;
  List filedList = ['전체', '자주 찾는', '여행 일정', '여행 기록','계정','기타'];
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    fs.getFaq('전체');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: 'FAQ', onTap: () { Get.back(); }, color: Colors.white),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Container(
              width: Get.width,
              height: 28,
              child: ListView.builder(
                itemCount: filedList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context, index) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          fs.getFaq('${filedList[index]}');
                          selectField=index;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectField == index ? gray900 : gray200,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: Text('${filedList[index]}', style: selectField == index ? f14Whitew700 : f14gray400w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: (){ Get.to(()=>SettingFaqSearch());},
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: gray200, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: focusNode,
                        style: f15gray800w500,
                        controller: controller,
                        onFieldSubmitted: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                          hintText: "궁금하신 사항을 키워드로 검색해 보세요",
                          hintStyle: f15gray400w500,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(
                              'assets/icon/search.svg',
                              fit: BoxFit.none,
                              color: Color(0xff5E91EE),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(()=>Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: fs.faqList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (contexts, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        fs.getFaqDetail(fs.faqList[index]['id']);
                        Get.to(() => SettingFaqDetail());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            '${fs.faqList[index]['title']}',
                            style: f14Gray600w600,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text('${fs.faqList[index]['type']}', style: f12gray400w500),
                          const SizedBox(height: 16),
                          Divider(
                            thickness: 1,
                            color: gray200,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
