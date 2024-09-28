import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';

import '../../../../../util/color.dart';
import '../../../../../util/font.dart';

class FlightView extends StatefulWidget {
  const FlightView({super.key});

  @override
  State<FlightView> createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrailingBackAppBar(text: '항공권',backTap: (){Get.back();},svgPicture: SvgPicture.asset( 'assets/icon/rowEllipsis.svg',width: 17,),trailingTap: (){print('12');}),
      body: Padding(
        padding: const EdgeInsets.only(top: 42, left: 21, right: 21),
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: 540,
              decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(4)
              ),
              child: Stack(
                children: [
                  SvgPicture.asset('assets/icon/flightTicket.svg',
                      width: Get.width,
                      height:Get.height,
                      fit: BoxFit.fill),
                  Positioned(
                      top: 32,
                      left: 23,
                      right: 23,
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('항공편명', style: f12gray600w600,),
                            const SizedBox(height: 8,),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: gray200),
                              ),
                              child: Padding(padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icon/plane.svg', colorFilter: ColorFilter.mode(pastelBlue,BlendMode.srcIn)),
                                    const SizedBox(width: 7,),
                                    Text('대한항공(KE) 101', style: f15gray800w500,),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text('출발 공항', style: f12gray600w600,),
                            const SizedBox(height: 8,),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: gray200),
                              ),
                              child: Padding(padding: EdgeInsets.all(16),
                                child: Text('${flightList[0]['departureAirport_kr']}(${flightList[0]['departureAirport']})', style: f15gray800w500,),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text('출발 일정', style: f12gray600w600,),
                            const SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: gray200),
                              ),
                              child: Padding(padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icon/departureFlight.svg', colorFilter: ColorFilter.mode(pastelBlue,BlendMode.srcIn)),
                                    const SizedBox(width: 6,),
                                    Text('${dayFormatter(flightList[0]['departureDate'])} ${hourFormatter(flightList[0]['departureDate'])}', style: f15gray800w500,),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                            Text('도착 공항', style: f12whitew600,),
                            const SizedBox(height: 8,),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: gray50,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: gray200),
                              ),
                              child: Padding(padding: EdgeInsets.all(16),
                                child: Text('${flightList[0]['arrivalAirport_kr']}(${flightList[0]['arrivalAirport']})', style: f15gray800w500,),
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text('도착 일정', style: f12whitew600,),
                            const SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 1, color: gray200),
                              ),
                              child: Padding(padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icon/arrivalFlight.svg', colorFilter: ColorFilter.mode(pastelBlue,BlendMode.srcIn)),
                                    const SizedBox(width: 6,),
                                    Text('${dayFormatter(flightList[0]['arrivalDate'])} ${hourFormatter(flightList[0]['arrivalDate'])}', style: f15gray800w500,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
