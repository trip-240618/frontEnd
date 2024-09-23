import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';

import '../../../util/color.dart';
import '../../../util/font.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  bool isSearch = false;
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  List searchHistoryList = ['도쿄타워','음식','시부야'];
  int? selectedColor;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        appBar: TrailingBackAppBar(text: '사진 검색', backTap: (){Get.back();}, svgPicture: SvgPicture.asset( 'assets/icon/map.svg',fit: BoxFit.none,),trailingTap: (){print('12');},),
        body: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                style: f15gray800w500,
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  hintText: "태그, 닉네임으로 사진을 검색해보세요",
                  hintStyle: f15gray400w500,
                  filled: true,
                  fillColor: gray50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: gray200, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: gray200, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xff5E91EE), width: 1.5),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(
                      'assets/icon/search.svg',
                      fit: BoxFit.none, color: Color(0xff5E91EE)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 44,),
              searchHistoryList.isEmpty?Container():Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('검색 기록', style: f12gray900w700,),
                        Spacer(),
                        Text('전체 삭제', style: f12gray400W700,),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchHistoryList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Text(searchHistoryList[index], style: f14Gray800w500,),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    searchHistoryList.removeAt(index);
                                    setState(() {

                                    });
                                  },
                                    child: SvgPicture.asset('assets/icon/close.svg')),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: focusNode.hasFocus?
        Container(
          width: Get.width,
          height: 86,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1AD4D4D4),
                offset: Offset(0, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Color(0x17D4D4D4),
                offset: Offset(0, -10),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Color(0x0DD4D4D4),
                offset: Offset(0, -23),
                blurRadius: 14,
              ),
              BoxShadow(
                color: Color(0x03D4D4D4),
                offset: Offset(0, -40),
                blurRadius: 16,
              ),
              BoxShadow(
                color: Color(0x00D4D4D4),
                offset: Offset(0, -63),
                blurRadius: 18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('태그 컬러 검색', style: f12gray600w600,),
                const SizedBox(height: 2,),
                Container(
                  width: Get.width,
                  height: 44,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                selectedColor = index;
                                setState(() {});
                              },
                              child: selectedColor==index
                                  ? Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: gray900,width: 2),
                                    color: colorList[index]
                                ),
                                child: SvgPicture.asset('assets/icon/checkIcon.svg',fit: BoxFit.none,),
                              )
                                  :  Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorList[index],
                                    border: colorList[index] == whiteColor?Border.all(color: gray200):null
                                ),
                              ),
                            ),
                            const SizedBox(width: 12)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ):null,
      ),
    );
  }
}
