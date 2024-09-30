import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/util/color.dart';
import '../../../../../util/font.dart';


class SearchTripPlace extends StatefulWidget {
  const SearchTripPlace({super.key});

  @override
  State<SearchTripPlace> createState() => _SearchTripPlaceState();
}

class _SearchTripPlaceState extends State<SearchTripPlace> {
  TextEditingController controller = TextEditingController();
  final js = Get.put(JPlanState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '일정 등록', color: Colors.white,onTap: (){Get.back();}),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('여행 장소', style: f12gray600w600,),
            const SizedBox(height: 8,),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }
  placesAutoCompleteTextField() {
    return Container(
      child: GooglePlaceAutoCompleteTextField(
        textStyle: f14gray600w500,
        textEditingController: controller,
        googleAPIKey: "AIzaSyCbQF5gcJSoIrrWO1NWK5eNuFZHRzo-cpc",
        inputDecoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          hintText: "여행 장소를 검색해주세요",
          hintStyle: f14Gray500w400,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          prefixIcon: SvgPicture.asset('assets/icon/search.svg',fit: BoxFit.none,color: Color(0xff5E91EE),)
        ),
        boxDecoration: BoxDecoration(
          color: gray50,
          border: Border.all(width: 1, color: gray200),
          borderRadius: BorderRadius.circular(4)
        ),
        
        debounceTime: 400,
        isLatLngRequired: true,
        showError: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print('플레이스 아이디?${prediction.placeId}');
          js.placeName.value = '${prediction.structuredFormatting?.mainText}';
          js.placeLat.value = double.parse('${prediction.lat}');
          js.placeLng.value = double.parse('${prediction.lng}');
          print('name?${js.placeName}');
          print('placeLat?${js.placeLat}');
          print('placeLng?${js.placeLng}');
          Get.back();
          // setState(() {});
        },
        itemClick: (Prediction prediction) async{
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        //seperatedBuilder: Divider(),
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white
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
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${prediction.structuredFormatting?.mainText ?? ""}",  style: f12gray600W700,),
                      const SizedBox(height: 4,),
                      Text("${prediction.description ?? ""}", overflow: TextOverflow.ellipsis, style: f12Gray600w500,maxLines: 1,),
                      const SizedBox(height: 2,),
                      Divider(
                        thickness: 1,
                        color: lightGray1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        isCrossBtnShown: true,
        // default 600 ms ,
      ),
    );
  }
}
