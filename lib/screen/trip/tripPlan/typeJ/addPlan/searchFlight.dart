import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import '../../../../../component/bottomContainer.dart';
import '../../../../../component/dialog/daySelect.dart';
import '../../../../../util/color.dart';
import '../../../../../util/font.dart';
import 'addFlight.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({super.key});

  @override
  State<SearchFlight> createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  TextEditingController _startDateCon = TextEditingController();
  TextEditingController _airlineCon = TextEditingController();
  TextEditingController _airCodeCon = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Map<String, String>> airlines = [
    {'name': '대한항공', 'code': 'KE'},
    {'name': '아시아나항공', 'code': 'OZ'},
    {'name': '티웨이항공', 'code': 'TW'},
    {'name': '제주항공', 'code': '7C'},
    {'name': '진에어', 'code': 'LJ'},
  ];
  final List<Map<String, String>> totalAirLine = [
    {'name': '대한항공', 'code': 'KE'},
    {'name': '아시아나항공', 'code': 'OZ'},
    {'name': '티웨이항공', 'code': 'TW'},
    {'name': '제주항공', 'code': '7C'},
    {'name': '진에어', 'code': 'LJ'},
    {'name': '에어부산', 'code': 'BX'},
    {'name': '이스타항공', 'code': 'ZE'},
    {'name': '에어서울', 'code': 'RS'},
  ];
  List<Map<String, String>> filteredAirlines = [];
  String? selectedAirline;
  @override
  void initState() {
    super.initState();
    js.selectedDateReset();

    _focusNode.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: BackAppBar(text: '항공편명 조회', onTap: (){Get.back();}),
          body: Padding(
            padding: const EdgeInsets.only(top: 36,left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('출발일', style: f12gray600w600,),
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
                              SelectDayBottomSheet(context,'항공편의 출발 날짜를 선택해 주세요', (){});
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
                                Obx(()=>Text('${DateFormat('yyyy.MM.dd (EEE)', 'ko').format(DateFormat('yyyy-MM-dd').parse(js.selectedDate.value))}', style: f15gray800w500,),)
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
                    style: f15gray800w500,
                    controller: _airlineCon,
                    focusNode: _focusNode,
                    onFieldSubmitted: (value){
                      // Get.to(()=>SearchHistoryResult());
                    },
                    onChanged: (v){
                      if(v==''){
                        print('v?? ${v}');
                        airlines = [
                          {'name': '대한항공', 'code': 'KE'},
                          {'name': '아시아나항공', 'code': 'OZ'},
                          {'name': '티웨이항공', 'code': 'TW'},
                          {'name': '제주항공', 'code': '7C'},
                          {'name': '진에어', 'code': 'LJ'},
                        ];
                      }else{
                        airlines = totalAirLine
                            .where((airline) => airline['name']!.contains(v))
                            .toList();
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      hintText: "항공사명 또는 코드를 입력해주세요",
                      hintStyle: f15gray400w500,
                      filled: true,
                      fillColor: gray50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset('assets/icon/search.svg',
                          fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  _focusNode.hasFocus?GestureDetector(
                    onTap: (){},
                    child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4), // border-radius: 0px 0px 4px 4px
                            bottomRight: Radius.circular(4),
                          ),
                          border: Border(
                            left: BorderSide(width: 1, color: gray200), // border-width: 1px
                            right: BorderSide(width: 1, color: gray200),
                            bottom: BorderSide(width: 1, color: gray200),
                        ),),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16,top: 16),
                            child: Text('주요 항공사',style: f12Gray400w600,),
                          ),
                          const SizedBox(height: 12,),
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: airlines.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return airlines.length==0?Container():Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      _airlineCon.text = '${airlines[index]['name']} (${airlines[index]['code']})';
                                      setState(() {
                                        selectedAirline = airlines[index]['name']; // 새로운 값으로 업데이트
                                      });
                                    },
                                    child: Container(
                                      width:Get.width,
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16),
                                            child: Text(
                                              '${airlines[index]['name']} (${airlines[index]['code']})',
                                              style: f16Gray500w500,
                                            ),
                                          ),
                                          Radio<String>(
                                            value: airlines[index]['name']!,
                                            groupValue: selectedAirline,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedAirline = newValue; // 새로운 값으로 업데이트
                                              });
                                            },
                                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(MaterialState.disabled)) {
                                                  return gray400.withOpacity(.32);
                                                } else if (states.contains(MaterialState.selected)) {
                                                  return gray900;
                                                }
                                                return gray400.withOpacity(.32);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ):SizedBox(),
                  _focusNode.hasFocus?const SizedBox(height: 20,):const SizedBox(),
                  const SizedBox(height: 20,),
                  Text('항공편명', style: f12gray600w600,),
                  const SizedBox(height: 8,),
                  TextFormField(
                    style: f15gray800w500,
                    controller: _airCodeCon,
                    onFieldSubmitted: (value){
                      // Get.to(()=>SearchHistoryResult());
                    },
                    onChanged: (v){
                      setState(() {});
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      hintText: "항공편명을 입력해주세요",
                      hintStyle: f15gray400w500,
                      filled: true,
                      fillColor: gray50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide: BorderSide(color: gray200, width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(
                            'assets/icon/search.svg',
                            fit: BoxFit.none, color: Color(0xff5E91EE)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 42),
            child: BottomContainer(
                onTap: ()async{
                  Get.to(()=>AddFlight());
                },title: '저장',isBlack: _airlineCon.text.trim().isEmpty&&_airCodeCon.text.trim().isEmpty?true:false),
          ),
        ),
    );
  }
}
