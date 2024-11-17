import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/util/color.dart';
import '../../../../../app/api/tripApi.dart';
import '../../../../../app/config/dio_client.dart';
import '../../../../../component/loading/loading.dart';
import '../../../../../util/font.dart';


class SearchTripPlace extends StatefulWidget {
  const SearchTripPlace({super.key});

  @override
  State<SearchTripPlace> createState() => _SearchTripPlaceState();
}

class _SearchTripPlaceState extends State<SearchTripPlace> {
  TextEditingController _placeCon = TextEditingController();
  final apiTripClient = ApiTripClient(DioClient());
  final js = Get.put(JPlanState());
  final ts = Get.put(TripState());
  List placeList = [];
  bool isLoading = false;

  /// 주소와 세컨드 주소의 중복값을 제거해서 장소 이름을 추출
  String getPlaceName(String address, String secondaryAddress) {
    // 중복된 부분을 제거한 주소 생성
    String reducedAddress = address.replaceAll(secondaryAddress, "").trim();
    if (reducedAddress.startsWith(', ')) {
      reducedAddress = reducedAddress.substring(2);
    }

    return reducedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: BackAppBar(text: '여행 장소 검색', color: Colors.white,onTap: (){Get.back();}),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('여행 장소', style: f12gray600w600,),
              const SizedBox(height: 8,),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4)),
                  border: Border.all(color: gray200,),
                  color: gray50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          'assets/icon/search.svg', fit: BoxFit.none, colorFilter: ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']),BlendMode.srcIn),),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: TextFormFieldComponent(
                            controller: _placeCon,
                            hintText: '여행장소를 지도에 입력해 보세요',
                            onChanged: (v){
                                setState(() {});
                            },
                            onFieldSubmitted: (value) async {
                              setState(() {
                                isLoading = true;
                              });
                              placeList = await apiTripClient.autoLocationGet(_placeCon.text);
                              setState(() {
                                isLoading = false;
                              });
                            },
                        )
                      ),
                    ],
                  ),
                ),
              ),
             isLoading?LoadingList(context):placeList.isEmpty ? const SizedBox():
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                  itemCount: placeList.length,
                  itemBuilder: (context, index){
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: gray200),
                          right: BorderSide(color: gray200),
                          bottom: index == placeList.length - 1
                              ? BorderSide(color: gray200)
                              : BorderSide.none,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await apiTripClient.detailLocationGet(placeList[index]['placeId']);
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: gray200,
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.location_on_outlined),
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${getPlaceName(placeList[index]['address'],placeList[index]['secondaryAddress'])}",  style: f12gray600W700,),
                                          const SizedBox(height: 4,),
                                          Text("${placeList[index]['address'] ?? ""}", overflow: TextOverflow.ellipsis, style: f12Gray600w500,maxLines: 1,),
                                          const SizedBox(height: 2,),
                                          index != placeList.length - 1?
                                          Container(
                                            width: Get.width,
                                            height: 1,
                                            color: lightGray1,
                                          ):const SizedBox()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
