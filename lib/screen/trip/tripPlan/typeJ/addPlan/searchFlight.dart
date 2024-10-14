import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/addFlight.dart';
import '../../../../../component/bottomContainer.dart';
import '../../../../../component/dialog/daySelect.dart';
import '../../../../../util/color.dart';
import '../../../../../util/font.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({super.key});

  @override
  State<SearchFlight> createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  bool _isFlightNotFound = false;
  TextEditingController _carrierCon = TextEditingController();
  TextEditingController _flightNumCon= TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Map<String, String>> airlines = [
    {'name': '대한항공', 'code': 'KE'},
    {'name': '아시아나항공', 'code': 'OZ'},
    {'name': '티웨이항공', 'code': 'TW'},
    {'name': '제주항공', 'code': '7C'},
    {'name': '진에어', 'code': 'LJ'},
  ];
  final List<Map<String, String>> totalAirLine = [
    // 대한민국
    {'name': '대한항공', 'code': 'KE'},
    {'name': '아시아나항공', 'code': 'OZ'},
    {'name': '티웨이항공', 'code': 'TW'},
    {'name': '제주항공', 'code': '7C'},
    {'name': '진에어', 'code': 'LJ'},
    {'name': '에어부산', 'code': 'BX'},
    {'name': '이스타항공', 'code': 'ZE'},
    {'name': '에어서울', 'code': 'RS'},
    {'name': '플라이강원', 'code': '4V'},
    {'name': '하이에어', 'code': '4H'},
    {'name': '에어인천', 'code': 'KJ'},
    {'name': '에어로케이항공', 'code': 'RF'},
    {'name': '에어프레미아', 'code': 'YP'},

    // 태국
    {'name': '타이항공', 'code': 'TG'},
    {'name': 'K-Mile 항공', 'code': '8K'},
    {'name': '녹에어', 'code': 'DD'},
    {'name': '방콕항공', 'code': 'PG'},
    {'name': '에어 피플 인터내셔널', 'code': '3D'},
    {'name': '타이 에어아시아', 'code': 'FD'},
    {'name': '타이 스마일 항공', 'code': 'WE'},
    {'name': '제트 아시아 항공', 'code': 'JF'},
    {'name': '타이 비엣젯 항공', 'code': 'VZ'},

    // 일본
    {'name': '일본항공', 'code': 'JL'},
    {'name': '전일본공수', 'code': 'NH'},
    {'name': '바닐라에어', 'code': 'JW'},
    {'name': '피치 항공', 'code': 'MM'},
    {'name': '에어재팬', 'code': 'NQ'},

    // 중국
    {'name': '중국국제항공', 'code': 'CA'},
    {'name': '중국남방항공', 'code': 'CZ'},
    {'name': '중국동방항공', 'code': 'MU'},
    {'name': '중국해남항공', 'code': 'HU'},
    {'name': '상하이항공', 'code': 'FM'},
    {'name': '샤먼항공', 'code': 'MF'},
    {'name': '춘추항공', 'code': '9C'},
    {'name': '칭다오항공', 'code': 'QW'},
    {'name': '캐피탈항공', 'code': 'JD'},
    {'name': '길상항공(준야오항공)', 'code': 'HO'},

    // 홍콩
    {'name': '캐세이퍼시픽', 'code': 'CX'},
    {'name': '캐세이 드래곤', 'code': 'KA'},
    {'name': '홍콩익스프레스', 'code': 'UO'},

    // 마카오
    {'name': '에어 마카오', 'code': 'NX'},

    // 대만 (중화민국)
    {'name': '중화항공', 'code': 'CI'},
    {'name': '에바항공', 'code': 'BR'},

    // 미국
    {'name': '아메리칸항공', 'code': 'AA'},
    {'name': '델타항공', 'code': 'DL'},
    {'name': '유나이티드항공', 'code': 'UA'},
    {'name': '하와이안 항공', 'code': 'HA'},
    {'name': '알래스카항공', 'code': 'AS'},
    {'name': '사우스웨스트항공', 'code': 'WN'},
    {'name': '버진 아메리카', 'code': 'VX'},

    // 영국
    {'name': '영국항공', 'code': 'BA'},

    // 독일
    {'name': '루프트한자', 'code': 'LH'},

    // 아랍에미리트
    {'name': '에미레이트항공', 'code': 'EK'},
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
          appBar: BackAppBar(text: '항공사 조회', onTap: (){
            js.selectedDateReset();
            Get.back();}, color: Colors.white,),
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
                    controller: _carrierCon,
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
                                      _carrierCon.text = '${airlines[index]['name']} (${airlines[index]['code']})';
                                      setState(() {
                                        selectedAirline = airlines[index]['code']; // 새로운 값으로 업데이트
                                        print('???${selectedAirline}');
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
                                              style: f14Gray800w500,
                                            ),
                                          ),
                                          Radio<String>(
                                            value: airlines[index]['code']!,
                                            groupValue: selectedAirline,
                                            onChanged: (String? newValue) {

                                              _carrierCon.text = '${airlines[index]['name']} (${airlines[index]['code']})';
                                              setState(() {
                                                selectedAirline = airlines[index]['code']; // 새로운 값으로 업데이트
                                                print('???${selectedAirline}');
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
                  Text('편명', style: f12gray600w600,),
                  const SizedBox(height: 8,),
                  TextFormField(
                    style: f15gray800w500,
                    controller: _flightNumCon,
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
                            'assets/icon/pencil.svg',
                            fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  _isFlightNotFound==true?Padding(
                    padding: const EdgeInsets.only(left: 16,top: 4),
                    child: Text('조회되지 않는 편명입니다',style: f11redw500,),
                  ):SizedBox(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 42),
            child: BottomContainer(
                onTap: ()async{
                  print('항공권 요청중 --');
                 await js.searchFlight(int.parse(_flightNumCon.text),selectedAirline!);
                 if(js.flightList.isNotEmpty){
                   print('항공편명은?${_carrierCon.text}');
                   _isFlightNotFound = false;
                   Get.to(()=>AddFlight(flightName: '${_carrierCon.text}',))?.then((v)=>{
                     _flightNumCon.clear(),
                     _carrierCon.clear(),
                   });

                 }
                 else{
                   _isFlightNotFound = true;
                 }
                 setState(() {

                 });
                  //Get.to(()=>AddFlight());
                },title: '조회하기',isBlack: _carrierCon.text.trim().isEmpty||_flightNumCon.text.trim().isEmpty?false:true),
          ),
        ),
    );
  }
}
