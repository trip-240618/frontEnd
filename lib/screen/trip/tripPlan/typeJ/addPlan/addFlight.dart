import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  List flightList = [{
    "airlineCode": "KE",
    "airlineNumber": 101,
    "departureDate": "2024-09-16T10:15+09:00",
    "departureAirport": "ICN",
    "departureAirport_kr": "인천 국제공항",
    "arrivalDate": "2024-09-16T11:45+08:00",
    "arrivalAirport": "NRT",
    "arrivalAirport_kr": "나리타 국제공항"
  }];

  String hourFormatter(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime.toLocal());
  }
  String dayFormatter(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(dateTime.toLocal());
  }
  @override
  void initState() {
    print('---');
    print(hourFormatter(flightList[0]['arrivalDate']));
    super.initState();
  }


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
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                child: Text('대한항공(KE) 101', style: f15gray800w500,),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 1.67, bottom: 2.5, left: 2.5, right: 6.5),
                      child: SvgPicture.asset(
                        'assets/bottomNavi/schedule.svg',
                        width: 15,
                        height: 15.83,
                        color: Color(0xff647AED),
                      ),
                    ),
                    Text(dayFormatter(flightList[0]['departureDate']), style: f15gray800w500,),
                    const SizedBox(width: 12,),
                    Padding(
                      padding: const EdgeInsets.all(1.67),
                      child: SvgPicture.asset(
                        'assets/icon/time.svg',
                        width: 16.67,
                        height: 16.67,
                        color: Color(0xff647AED),
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Text(hourFormatter(flightList[0]['departureDate']), style: f15gray800w500),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('출발 공항', style: f12gray600w600,),
            const SizedBox(height: 8,),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                child: Text('${flightList[0]['departureAirport_kr']}(${flightList[0]['departureAirport']})', style: f15gray800w500,),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 1.67, bottom: 2.5, left: 2.5, right: 6.5),
                      child: SvgPicture.asset(
                        'assets/bottomNavi/schedule.svg',
                        width: 15,
                        height: 15.83,
                        color: Color(0xff647AED),
                      ),
                    ),
                    Text(dayFormatter(flightList[0]['arrivalDate']), style: f15gray800w500,),
                    const SizedBox(width: 12,),
                    Padding(
                      padding: const EdgeInsets.all(1.67),
                      child: SvgPicture.asset(
                        'assets/icon/time.svg',
                        width: 16.67,
                        height: 16.67,
                        color: Color(0xff647AED),
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Text(hourFormatter(flightList[0]['arrivalDate']), style: f15gray800w500),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('도착 공항', style: f12gray600w600,),
            const SizedBox(height: 8,),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                child: Text('${flightList[0]['arrivalAirport_kr']}(${flightList[0]['arrivalAirport']})', style: f15gray800w500,),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
