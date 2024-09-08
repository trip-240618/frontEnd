import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchTripPlace.dart';
import '../../../../../component/bottomModals.dart';
import '../../../../../controller/jPlanState.dart';
import '../../../../../util/color.dart';
import '../../../../../util/font.dart';



class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  /// 지역변수로 수정 예정
  final js = Get.put(JPlanState());
  Set<Marker> markers = {};
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  DateFormat timeFormatter = DateFormat('a hh:mm', 'ko_KR');
  DateTime now = DateTime.now();
  TextEditingController placeCon = TextEditingController();
  TextEditingController planTitleCon = TextEditingController();
  TextEditingController memoCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController timeCon = TextEditingController();
  TextEditingController flightCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateCon.text = dateFormatter.format(now);
    timeCon.text = timeFormatter.format(now);
    js.placeLat.value = 0.0;
    js.placeLng.value = 0.0;

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
        appBar: BackAppBar(text: '일정 추가', onTap: (){Get.back();}),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 44),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=> Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        js.selectIdx.value = 0;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: js.selectIdx==0?gray900:gray200,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          child: Text('여행 일정',style: js.selectIdx==0?f14Whitew700:f14gray400w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: (){
                        js.selectIdx.value = 1;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: js.selectIdx==1?gray900:gray200,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                          child: Text('항공편',style: js.selectIdx==1?f14Whitew700:f14gray400w700),
                        ),
                      ),
                    ),
                  ],
                )),

                Obx(()=>js.selectIdx.value == 0?
                TripPlan()
                    :addFlight(),)



              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
            child: BlackBottomContainer(onTap: (){}, title: '저장'),
          ),
        ),

      ),
    );
  }
  Widget addFlight(){
    return Column(
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
    );
  }
  Widget TripPlan(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24,),
        /// 날짜 및 시간
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
                      Text(dateCon.text, style: f15gray800w500,),
                    ],
                  ),
                ),
                const SizedBox(width: 12,),
                GestureDetector(
                  onTap: (){
                    timeBottomModel(context, DateTime.now());
                  },
                  child: Row(
                    children: [
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
                      Text(timeCon.text, style: f15gray800w500),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Text('여행 장소', style: f12gray600w600,),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Get.to(()=>SearchTripPlace());
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: gray200)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icon/search.svg',fit: BoxFit.none),
                  const SizedBox(width: 4),
                  Obx(()=>js.placeName.value ==''?Text('여행 장소를 검색해주세요',style: f14Gray500w400):Text('${js.placeName.value}',style: f14Gray500w400,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,)),
                ],
              ),
            ),
          ),
        ),
        Obx(()=> js.placeLat.value == 0.0&&js.placeLng.value==0.0?Container():Container(
          width: Get.width,
          height: 240,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(js.placeLat.value, js.placeLng.value),
              zoom: 14.4746,
            ),
            markers: {
              Marker(
                  markerId: MarkerId(js.placeName.value),
                  position: LatLng(js.placeLat.value, js.placeLng.value),
                  onTap: (){
                    //navigateTo(latitude,longitude, '고기극장');
                  }
              )
            },
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              if (!js.mapController.isCompleted) {
                js.mapController.complete(controller);
              }
            },
          ),
        )),
        const SizedBox(height: 20,),
        /// 일정
        Text('여행 일정*', style: f12gray600w600,),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            print('3123');
          },
          child:
          TextFormField(
            controller: planTitleCon,
            textAlignVertical: TextAlignVertical.center,
            style: f15gray800w500,
            decoration: InputDecoration(
              hintText: '여행 일정을 작성해 주세요 ',
              hintStyle: f15gray400w500,
              fillColor: gray50,
              filled: true,
              isDense: true,
              contentPadding:EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: gray200),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: gray200),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Text('간편 메모', style: f12gray600w600,),
        const SizedBox(height: 8,),
        TextFormField(
          controller: memoCon,
          textAlignVertical: TextAlignVertical.center,
          style: f15gray800w500,
          decoration: InputDecoration(
            hintText: '일정 간편 메모를 이용해 보세요',
            hintStyle: f15gray400w500,
            fillColor: gray50,
            filled: true,
            isDense: true,
            contentPadding:EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray200),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        const SizedBox(height: 35,),
      ],
    );
  }
}
