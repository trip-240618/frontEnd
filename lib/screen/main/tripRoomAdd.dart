import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/main/typeChoose.dart';
import 'package:tripStory/util/color.dart';

import '../../component/bottomContainer.dart';
import '../../util/font.dart';

class TripRoomAddScreen extends StatefulWidget {
  const TripRoomAddScreen({super.key});

  @override
  State<TripRoomAddScreen> createState() => _TripRoomAddScreenState();
}

class _TripRoomAddScreenState extends State<TripRoomAddScreen> {
  TextEditingController tripName = TextEditingController(); /// 여행방 입력
  TextEditingController tripDestination = TextEditingController(); /// 여행지 입력
  TextEditingController tripDate = TextEditingController(); /// 여행일정 입력
  String tripType = ''; /// 여행 타입

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('여행방 만들기'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 71,left: 20,right: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: tripName,
                    textAlignVertical: TextAlignVertical.center,
                    style: f16Gray800w600,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
                      ),
                      hintText: '여행지를 검색해주세요',
                      hintStyle: f14Gray500w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('여행방 타입 선택'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: TypeChoose(text: 'J형',onTap: (){
                          tripType = 'J형';
                          setState(() {});
                        },value: tripType,),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TypeChoose(text: 'P형',onTap: (){
                          tripType = 'P형';
                          setState(() {});
                        },value: tripType,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('여행지'),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: tripDestination,
                    textAlignVertical: TextAlignVertical.center,
                    style: f16Gray800w600,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
                      ),
                      hintText: '여행지를 검색해주세요',
                      hintStyle: f14Gray500w400,
                      prefixIcon: Padding(
                        padding:  EdgeInsets.only(left: 8),
                        child: SvgPicture.asset('assets/icon/search.svg',fit: BoxFit.none),
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('여행일정'),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: tripDate,
                    textAlignVertical: TextAlignVertical.center,
                    style: f16Gray800w600,
                    scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
                      ),
                      hintText: '여행지를 검색해주세요',
                      hintStyle: f14Gray500w400,
                        prefixIcon: Padding(
                          padding:  EdgeInsets.only(left: 8),
                          child: SvgPicture.asset('assets/icon/calender.svg',fit: BoxFit.none,),
                        )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],),
            ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 44),
        child: BottomContainer(onTap: (){
          // Get.to(()=>ProfileScreen());
        }),
      ),
      ),
    );
  }
}
