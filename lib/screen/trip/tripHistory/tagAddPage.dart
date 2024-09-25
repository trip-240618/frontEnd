import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/util/font.dart';

import '../../../util/color.dart';

class TagAddPage extends StatefulWidget {
  const TagAddPage({super.key});

  @override
  State<TagAddPage> createState() => _TagAddPageState();
}

class _TagAddPageState extends State<TagAddPage> {
  TextEditingController _tagCon = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;
  List tagList = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _tagCon.dispose();
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
        appBar: BackAppBar(text: '태그 추가', onTap: (){Get.back();}),
        body: Padding(
          padding: const EdgeInsets.only(top: 27, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('태그 입력', style: f12gray600w600,),
              const SizedBox(height: 8,),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: gray200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (con){
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: '태그는 2개까지 등록 가능합니다.',
                            hintStyle: f15gray400w500,
                          ),
                          controller: _tagCon,
                          focusNode: _focusNode,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(7),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('${_tagCon.text.length}', style: _tagCon.text.length>0?f11Gray800w600:f11Gray400w600,),
                      Text('/7 ', style: f11Gray400w600,),
                      const SizedBox(width: 8,),
                      _tagCon.text.length>0?GestureDetector(onTap: (){
                        tagList.add({'name': _tagCon.text, 'color':colorList[selectedColor]});
                        _tagCon.clear();
                        setState(() {

                        });
                      }, child: SvgPicture.asset('assets/icon/roundArrowRight.svg')):Container(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              tagList.isNotEmpty?
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 12,
                children: tagList.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return Container(
                    decoration: BoxDecoration(
                      color: gray50,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 1.5,
                        color: gray900,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(100),
                              border: item['color'] == whiteColor
                                  ? Border.all(color: gray200)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                '#',
                                style: item['color'] == whiteColor
                                    ? f10Gray800w500
                                    : f10Whitew500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item['name']}',
                            style: f14Gray800w500,
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tagList.removeAt(index); // 해당 인덱스 아이템 삭제
                              });
                            },
                            child: SvgPicture.asset('assets/icon/close.svg', color: gray900),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
                  :Container(),


            ],
          ),
        ),
        bottomSheet: _focusNode.hasFocus?
        GestureDetector(
          onTap: (){

          },
          child: Container(
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
          ),
        ):Container(
          color : Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
            child: BlackBottomContainer(onTap: (){}, title: '저장'),
          ),
        ),
      ),
    );
  }
}
