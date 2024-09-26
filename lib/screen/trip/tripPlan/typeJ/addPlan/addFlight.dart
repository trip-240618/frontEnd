import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';

import '../../../../../util/color.dart';
import '../../../../../util/font.dart';

class AddFlight extends StatefulWidget {
  const AddFlight({super.key});

  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {
  TextEditingController flightCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '항공권 등록', onTap: (){Get.back();}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            Text('항공편명', style: f12gray600w600,),
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
                        Get.to(()=>SearchFlight());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/search.svg',
                            width: 20,
                            height: 20,
                            color: Color(0xff647AED),
                          ),
                          const SizedBox(width: 5,),
                          flightCon.text ==''?Text('항공편명을 조회해 보세요',style: f14Gray500w400):Text(flightCon.text,style: f15gray800w500,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('출발일정', style: f12gray600w600,),
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
                          print('출발 일정');
                        },
                        child: Text('', style: f15gray800w500,)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('출발 공항', style: f12gray600w600,),
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
                          print('출발 공항');
                        },
                        child: Text('', style: f15gray800w500,)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('도착 일정', style: f12gray600w600,),
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
                          print('도착 일정');
                        },
                        child: Text('', style: f15gray800w500,)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('도착 공항', style: f12gray600w600,),
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
                          print('도착 공항');
                        },
                        child: Text('', style: f15gray800w500,)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
