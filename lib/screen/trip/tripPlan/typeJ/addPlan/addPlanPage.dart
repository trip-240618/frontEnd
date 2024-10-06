import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/googleMap_searchPlace.dart';
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
  BitmapDescriptor? customIcon;
  final ts = Get.put(TripState());
  final js = Get.put(JPlanState());
  Set<Marker> markers = {};
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  DateFormat timeFormatter = DateFormat('a hh:mm', 'ko_KR');
  DateTime now = DateTime.now();
  TextEditingController planTitleCon = TextEditingController();
  TextEditingController memoCon = TextEditingController();
  String selectDay = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.now());
  String selectTime = DateFormat('a hh:mm', 'ko_KR').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _setCustomMarker();
  }
  Future<void> _setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icon/marker.png',
    );
    setState(() {});
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
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(text: '일정 등록',color: Colors.white,
            onTap: (){js.searchLocation.value = []; Get.back();}),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 44),
            child: Column(
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
                                  colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),
                                ),
                              ),
                              Text(selectDay, style: f15gray800w500,),
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
                                  'assets/icon/time.svg', width: 16.67, height: 16.67, colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(selectTime, style: f15gray800w500),
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
                    js.searchLocation.isEmpty?Get.to(()=>SearchTripPlace()):null;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gray50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: js.searchLocation.isEmpty?Radius.circular(4):Radius.zero,
                        bottomRight: js.searchLocation.isEmpty?Radius.circular(4):Radius.zero,
                      ),
                      border: Border.all(color: gray200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                      child: Obx(()=>js.searchLocation.isEmpty?Row(
                        children: [
                          SvgPicture.asset('assets/icon/search.svg',colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                          const SizedBox(width: 5),
                          Text('여행 장소를 검색해주세요',style: f14Gray500w400),
                        ],
                      ):Row(
                        children: [
                          Text('${js.searchLocation[0]['displayName']['text']}',style: f15gray800w500,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              js.searchLocation.value = [];
                            },
                            child: SvgPicture.asset(
                              'assets/icon/smallXRound.svg', fit: BoxFit.none, colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Obx(()=> js.searchLocation.isEmpty?Container():
                Container(
                  width: Get.width,
                  height: 240,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: gray200),
                      right: BorderSide(color: gray200),
                      bottom: BorderSide(color: gray200),
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse('${js.searchLocation[0]['location']['latitude']}'), double.parse('${js.searchLocation[0]['location']['longitude']}')),
                      zoom: 14.4746,
                    ),
                    onTap: (argument) {
                      if(js.searchLocation.isNotEmpty) Get.to(()=>GoogleMapSearchPlace());
                    },
                    markers: {
                      Marker(
                          markerId: MarkerId('${js.searchLocation[0]['displayName']['text']}'),
                          position: LatLng(double.parse('${js.searchLocation[0]['location']['latitude']}'), double.parse('${js.searchLocation[0]['location']['longitude']}')),
                          onTap: (){
                            //navigateTo(latitude,longitude, '고기극장');
                          },
                        icon: customIcon!,
                      )
                    },
                    myLocationButtonEnabled: false,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                    },
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
                              hintText: '여행 일정을 작성해 주세요',
                              hintStyle: f15gray400w500,
                            ),
                            controller: planTitleCon,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(20),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text('${planTitleCon.text.length}', style: planTitleCon.text.length>0?f11Gray800w600:f11Gray400w600,),
                        Text('/20 ', style: f11Gray400w600,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('간편 메모', style: f12gray600w600,),
                const SizedBox(height: 8,),
                Container(
                  width: Get.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color: gray50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: gray200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              hintText: '일정 간편 메모를 이용해 보세요',
                              hintStyle: f15gray400w500,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: memoCon,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(100),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('${memoCon.text.length}', style: memoCon.text.length>0?f11Gray800w600:f11Gray400w600,),
                            Text('/100 ', style: f11Gray400w600,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 75,),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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
}
