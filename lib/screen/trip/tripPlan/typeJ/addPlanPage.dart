import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/searchTripPlace.dart';
import '../../../../controller/jPlanState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';



class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
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
        backgroundColor: gray50,
        appBar: BackAppBar(text: '일정 추가', onTap: (){Get.back();}),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 44),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 날짜 및 시간
                Padding(
                  padding: const EdgeInsets.only(left: 16,bottom: 4),
                  child: Text('날짜 및 시간', style: f14gray400w700,),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                  color: gray400,
                                ),
                              ),
                              Text(dateCon.text, style: f14gray600w500,),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12,),
                        GestureDetector(
                          onTap: (){
                            print('시간 클릭');
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.67),
                                child: SvgPicture.asset(
                                  'assets/icon/time.svg',
                                  width: 16.67,
                                  height: 16.67,
                                  color: gray400,
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(timeCon.text, style: f14gray600w500),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                /// 장소
                Padding(
                  padding: const EdgeInsets.only(left: 16,bottom: 4),
                  child: Text('장소 입력', style: f14gray400w700,),
                ),
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
                const SizedBox(height: 12,),
                /// 일정
                Padding(
                  padding: const EdgeInsets.only(left: 16,bottom: 4),
                  child: Text('일정 입력', style: f14gray400w700,),
                ),
                GestureDetector(
                  onTap: (){
                    print('3123');
                  },
                  child:
                  TextFormField(
                    controller: planTitleCon,
                    textAlignVertical: TextAlignVertical.center,
                    style: f16gray800w600,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: gray200),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(left: 16,bottom: 4),
                  child: Text('메모', style: f14gray400w700,),
                ),
                TextFormField(
                  controller: memoCon,
                  textAlignVertical: TextAlignVertical.center,
                  style: f16gray800w600,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
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
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: gray500,
                    ),
                    child: Center(child: Text('저장', style: f16Whitew600,)),
                  ),
                )
          
              ],
            ),
          ),
        ),

      ),
    );
  }

}
