import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import '../../../app/api/tripApi.dart';
import '../../../app/config/dio_client.dart';
import '../../../component/button/typeChoose.dart';
import '../../../component/textForm/textform.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class TripDirectSearchPage extends StatefulWidget {
  const TripDirectSearchPage({super.key});

  @override
  State<TripDirectSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripDirectSearchPage> {
  final ms = Get.put(MainState());
  final apiTripClient = ApiTripClient(DioClient());
  List searchCountryList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text('여행지 선택',style: f12gray600w600,),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TypeChoose(text: '해외',onTap: (){
                ms.tripDirectSearchCon.text = '';
                ms.tripLeaveType.value = '해외';
                setState(() {});
              },value: ms.tripLeaveType.value),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TypeChoose(text: '국내',onTap: (){
                ms.tripDirectSearchCon.text = '';
                searchCountryList.clear();
                ms.tripLeaveType.value = '국내';
                setState(() {});
              },value: ms.tripLeaveType.value),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('여행지 이름',style: f12gray600w600,),
        const SizedBox(height: 8),
        TextIconFormFields(
            controller: ms.tripDirectSearchCon,
            hintText: '여행지를 직접 입력해주세요',
            colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn),
            icon: 'assets/icon/pencil.svg',
            onFieldSubmitted: (value) async {
              searchCountryList = await apiTripClient.autoCountryGet(ms.tripDirectSearchCon.text);
              setState(() {
              });
            },
            onChanged: (v) {
              setState(() {
              });
            },
        ),
        ms.tripLeaveType.value == '해외'?
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: searchCountryList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: RadioListTile<String>(
                          title: Text(searchCountryList[index], style: f16gray800w500),
                          value: searchCountryList[index],
                          groupValue: ms.directSelectedCity.value,
                          onChanged: (String? newValue) {
                            ms.directSelectedCity.value = newValue!;
                            setState(() {});
                        },
                          dense: true,
                          hoverColor: gray900,
                          contentPadding: const EdgeInsets.only(left: 16, right: 16,bottom: 0),
                          controlAffinity: ListTileControlAffinity.trailing,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return gray400.withOpacity(.32);
                                } else if (states.contains(MaterialState.selected)) {
                                  return gray900;
                                }
                                return gray400.withOpacity(.32);
                              }),
                        ),
              
                      )
                    ],
                  );
                }
              ),
            ):
            SizedBox()

      ],
    );
  }
}
