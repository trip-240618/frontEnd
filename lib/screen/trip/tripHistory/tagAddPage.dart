import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/util/font.dart';

import '../../../util/color.dart';

class TagAddPage extends StatefulWidget {
  final int index;
  const TagAddPage({super.key, required this.index});

  @override
  State<TagAddPage> createState() => _TagAddPageState();
}

class _TagAddPageState extends State<TagAddPage> {
  final hs = Get.put(HistoryState());
  TextEditingController _tagCon = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List colorList = [whiteColor,pastelBlue,mainRed,yellowColor,greenColor];
  int selectedColor = 0;
  List tagList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      if(hs.addTagList[widget.index].length!=0){
        tagList = hs.addTagList[widget.index];
        setState(() {});
      }
    });
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
        setState(() {});
      },
      child: Scaffold(
        appBar: BackAppBar(text: '태그 추가', onTap: (){
          Get.back();
          },color: Colors.white,),
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
                          onFieldSubmitted: (v){
                            if(tagList.length!=2){
                              tagList.add({'name': _tagCon.text, 'color':colorList[selectedColor]});
                              _tagCon.clear();
                              setState(() {});
                            }else{
                              _tagCon.clear();
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: '태그는 2개까지 등록 가능합니다.',
                            hintStyle: f15gray400w500,
                          ),
                          enabled: tagList.length!=2?true:false,
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
                      tagList.length!=2&&_tagCon.text.length>0?GestureDetector(onTap: (){
                        if(tagList.length!=2){
                          tagList.add({'name': _tagCon.text, 'color':colorList[selectedColor]});
                          _tagCon.clear();
                          setState(() {});
                        }else{
                          _tagCon.clear();
                          setState(() {});
                        }
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
                  return Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8,right: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: gray200)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width:16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: entry.value['color'],
                                      shape: BoxShape.circle
                                    ),
                                    child: Center(child: Text('#',style: entry.value['color'] == Color(0xffffffff)?f12gray900w500:f12whitew500,)),
                                  ),
                                  const SizedBox(width: 4,),
                                  Text('${entry.value['name']}',style: f12gray900w500),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              tagList.removeAt(entry.key);
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              'assets/icon/minix.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
                  :const SizedBox(),
            ],
          ),
        ),
        bottomSheet: _focusNode.hasFocus?
        GestureDetector(
          onTap: (){},
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
            child: BlackBottomContainer(onTap: (){
              hs.addTagList[widget.index] = tagList;
              Get.back();
            }, title: '저장'),
          ),
        ),
      ),
    );
  }
}
