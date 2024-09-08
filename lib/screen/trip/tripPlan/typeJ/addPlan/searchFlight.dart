import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';

import '../../../../../util/color.dart';
import '../../../../../util/font.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({super.key});

  @override
  State<SearchFlight> createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  TextEditingController _startDateCon = TextEditingController();
  TextEditingController _airlineCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDateCon.text = dateFormatter.format(DateTime.now());

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {});
        },
        child: Scaffold(
          appBar: BackAppBar(text: '항공편명 조회', onTap: (){Get.back();}),
          body: Padding(
            padding: const EdgeInsets.only(top: 36,left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('날짜 및 시간*', style: f12gray600w600,),
                const SizedBox(height: 8,),
                Container(
                  decoration: BoxDecoration(
                    color: gray50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: gray200),
                  ),
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            print('달력 클릭');
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 1.67, bottom: 2.5, left: 2.5, right: 6.5),
                                child: SvgPicture.asset(
                                  'assets/bottomNavi/schedule.svg',
                                  width: 15,
                                  height: 15.83,
                                  color: Color(0xff647AED),
                                ),
                              ),
                              Text(_startDateCon.text, style: f15gray800w500,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('항공사', style: f12gray600w600,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _airlineCon,
                  textAlignVertical: TextAlignVertical.center,
                  style: f15gray800w500,
                  decoration: InputDecoration(
                    // SvgPicture.asset(
                    //   'assets/icon/search.svg',
                    //   width: 16,
                    //   height: 16,
                    //   color: Color(0xff647AED),
                    // ),
                    hintText: '여행 일정을 작성해 주세요 ',
                    hintStyle: f15gray400w500,
                    fillColor: gray50,
                    filled: true,
                    isDense: true,
                    contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gray200),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
