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
import '../../../../../component/dialog/daySelect.dart';
import '../../../../../controller/jPlanState.dart';
import '../../../../../util/color.dart';
import '../../../../../util/font.dart';

class EditPlanBJ extends StatefulWidget {
  const EditPlanBJ({super.key});

  @override
  State<EditPlanBJ> createState() => _EditPlanBJState();
}

class _EditPlanBJState extends State<EditPlanBJ> {
  BitmapDescriptor? customIcon;
  final ts = Get.put(TripState());
  final js = Get.put(JPlanState());
  bool isLoading = true;
  bool isDateTBD = false; /// 날짜 미정
  Set<Marker> markers = {};
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  DateFormat timeFormatter = DateFormat('a hh:mm', 'ko_KR');
  DateTime now = DateTime.now();
  TextEditingController planTitleCon = TextEditingController();
  TextEditingController memoCon = TextEditingController();
  String selectTime = DateFormat('a hh:mm', 'ko_KR').format(DateTime.now()); /// 시간

  @override
  void initState() {
    print('선택된 플랜B JList?${js.selectPlanBJList}');
    /// 날짜 정렬
    if(js.selectPlanBJList['dayAfterStart']==-1){
      isDateTBD = true;
      js.selectedDate.value = ts.selectTripList[0]['startDate'];
    }else{
      js.selectedDate.value = DateFormat('yyyy-MM-dd').format(
          DateFormat('yyyy-MM-dd').parse(ts.selectTripList[0]['startDate']).add(
              Duration(days: js.selectPlanBJList['dayAfterStart']-1)
          )
      );
    }
    js.addDate.value = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.parse('${js.selectedDate.value}'));
    /// 시간
    js.addSelectedDateTime.value = DateTime(
      DateTime.parse(js.selectedDate.value).year,
      DateTime.parse(js.selectedDate.value).month,
      DateTime.parse(js.selectedDate.value).day,
      int.parse(js.selectPlanBJList['startTime'].split(':')[0]), // Hour
      int.parse(js.selectPlanBJList['startTime'].split(':')[1]), // Minute
      int.parse(js.selectPlanBJList['startTime'].split(':')[2]), // Second
    );
    if(js.selectPlanBJList['place']!=null&&js.selectPlanBJList['place']!=''){
      Map data = {
        "formattedAddress": "",
        "location": {
          "latitude": js.selectPlanBJList['latitude'],
          "longitude": js.selectPlanBJList['longitude']
        },
        "displayName": {
          "text": js.selectPlanBJList['place'],
          "languageCode": "ko"
        }
      };
      js.searchLocation.value = [data];
      js.searchLocation.refresh();
    }

    Future.delayed(Duration.zero,()async{
      planTitleCon.text = js.selectPlanBJList['title'];
      if(js.selectPlanBJList['memo']!=''){
        memoCon.text =  js.selectPlanBJList['memo'];
      }
      await _setCustomMarker();
      isLoading = false;
    });
    super.initState();
  }

  Future<void> _setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icon/marker.png',
    );
    setState(() {});
  }

  @override
  void dispose() {
    js.searchLocation.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(text: '일정 B안',color: Colors.white,
            onTap: (){
              js.searchLocation.clear();
              Get.back();
            }),
        body: isLoading?SizedBox():Obx(()=>SingleChildScrollView(
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
                        isDateTBD?
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 1.67, bottom: 2.5, left: 2.5, right: 6.5),
                              child: SvgPicture.asset('assets/bottomNavi/schedule.svg', width: 15, height: 15.83, colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),
                              ),
                            ),
                            Text('YYYY.MM.DD', style: f15gray400w500,),
                            const SizedBox(width: 11,),
                          ],
                        ) :
                        GestureDetector(
                          onTap: (){
                            /*SelectDayBottomSheet2(context,'여행 날짜를 선택해 주세요');*/
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
                              Text('${js.addDate}', style: f15gray800w500,),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12,),
                        GestureDetector(
                          onTap: (){
                            timeBottomModel(context);
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
                              Text('${DateFormat('a hh:mm', 'ko_KR').format(js.addSelectedDateTime.value)}', style: f15gray800w500),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6,),
                Row(
                  children: [
                    Spacer(),
                    isDateTBD?
                    GestureDetector(
                        onTap: (){
                          isDateTBD = !isDateTBD;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: gray900,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: SvgPicture.asset('assets/icon/check2.svg'),
                          ),
                        )
                    )
                        :GestureDetector(
                        onTap: (){
                          isDateTBD = !isDateTBD;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1.5,
                                color: gray300,
                              ),
                              borderRadius: BorderRadius.circular(100)
                          ),
                        )
                    ),
                    const SizedBox(width: 6,),
                    Text('날짜 미정', style: f12gray600w600,),

                  ],
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
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom + 40),
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
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom + 160),
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
        )),
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
            child: BlackBottomContainer(onTap: ()async{
              DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']); /// 시작 날짜
              DateTime selectedDate = DateTime.parse(js.addDate.value.split(' ')[0].replaceAll('.', '-'));/// 선택된 날짜
              int index = selectedDate.difference(startDate).inDays;
              Map data =
               {
                "planId": js.selectPlanBJList['planId'],
                "dayAfterStart": isDateTBD?-1:index+1,
                "startTime": "${DateFormat('HH:mm', 'ko_KR').format(DateTime.parse('${js.addSelectedDateTime}'))}",
                "title": planTitleCon.text,
                "place": js.searchLocation.isNotEmpty?js.searchLocation[0]['displayName']['text']:'',
                "memo": memoCon.text,
                "latitude":js.searchLocation.isNotEmpty?js.searchLocation[0]['location']['latitude']:'',
                "longitude": js.searchLocation.isNotEmpty?js.searchLocation[0]['location']['longitude']:'',
                "locker": true
              };
              print('내가 보낼 data?${data}');

              await js.editJPlanList(data);
              await js.getPlanBJList();
              Get.back();
            }, title: '일정 B안 수정'),
          ),
        ),

      ),
    );
  }
}