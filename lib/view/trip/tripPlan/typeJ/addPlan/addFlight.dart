import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/trip/tripPlan/typeJ/addPlan/searchFlight.dart';

class AddFlight extends StatefulWidget {
  final flightName; /// 필수 아규먼트 : 항공편 이름
  const AddFlight({super.key, required this.flightName});

  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {
  final ts = Get.put(TripState());
  final js = Get.put(JPlanState());


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '항공편 등록', onTap: (){js.flightList.clear(); Get.back();}, color: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('항공편명', style: f12gray600w600,),
            const SizedBox(height: 8,),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text('${widget.flightName} ${js.flightList[0]['airlineNumber']}', style: f15gray800w500,),
                    Spacer(),
                    js.flightList.isNotEmpty
                        ? GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.to(SearchFlight());
                        },
                        child: SvgPicture.asset(
                            'assets/icon/smallXRound.svg',
                            colorFilter:
                            ColorFilter.mode(gray900, BlendMode.srcIn)))
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text('출발 일정', style: f12gray600w600,),
            const SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icon/smallDate.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                    const SizedBox(width: 5,),
                    Text('${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.parse(js.flightList[0]['departureDate']).toLocal())}', style: f15gray800w500,),
                    const SizedBox(width: 16,),
                    SvgPicture.asset('assets/icon/time.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                    const SizedBox(width: 5,),
                    Text('${js.flightList[0]['departureDate'].split('T')[1].split('+')[0]}', style: f15gray800w500,),
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
              child: Padding(padding: EdgeInsets.all(16),
                child: Text('${js.flightList[0]['departureAirport_kr']}(${js.flightList[0]['departureAirport']})', style: f15gray800w500,),
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
              child: Padding(padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icon/smallDate.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                    const SizedBox(width: 5,),
                    Text('${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.parse(js.flightList[0]['arrivalDate']).toLocal())}', style: f15gray800w500,),
                    const SizedBox(width: 16,),
                    SvgPicture.asset('assets/icon/time.svg', colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn)),
                    const SizedBox(width: 5,),
                    Text('${js.flightList[0]['arrivalDate'].split('T')[1].split('+')[0]}', style: f15gray800w500,),
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
              child: Padding(padding: EdgeInsets.all(16),
                child: Text('${js.flightList[0]['arrivalAirport_kr']}(${js.flightList[0]['arrivalAirport']})', style: f15gray800w500,),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 42),
        child: BottomContainer(
            onTap: ()async{
              js.createFlight(widget.flightName);
              Get.back();
              Get.back();
            },title: '등록 완료',isBlack: true),
      ),
    );
  }
}
