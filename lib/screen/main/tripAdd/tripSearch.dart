import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/textForm.dart';
import '../../../controller/mainState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class TripSearchPage extends StatefulWidget {
  const TripSearchPage({super.key});

  @override
  State<TripSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripSearchPage> {
  final ms = Get.put(MainState());

  @override
  void initState() {
    ms.tripCitySearchCon = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    ms.tripCitySearchCon.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextIconFormFields(controller: ms.tripCitySearchCon, hintText: '여행지를 검색해주세요', icon: 'assets/icon/search.svg'),
        const SizedBox(height: 16,),
        Expanded(
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index==0?Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: Column(
                        children: [
                          Text('국내',style: f12gray400W700,),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ):SizedBox(),
                    index==1?Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Text('아시아',style: f12gray400W700,),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ):SizedBox(),
                    RadioListTile<String>(
                      title: Text('Item $index',style: f16Gray500w500,), // 각 아이템의 텍스트
                      value: '$index', // 각 라디오 버튼의 값
                      groupValue: ms.selectedCity, // 현재 선택된 라디오 버튼의 값
                      onChanged: (String? newValue) {
                        ms.selectedCity = newValue!;
                        setState(() {});
                      },
                      dense:true,
                      contentPadding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 0),
                      controlAffinity: ListTileControlAffinity.trailing,
                      secondary: Container(
                        child: Text('33'),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return gray400.withOpacity(.32);
                        } else if(states.contains(MaterialState.selected)){
                          return Colors.red;
                        }
                        return gray400.withOpacity(.32);
                        // return Colors.orange;
                      }),
                      // visualDensity: VisualDensity(vertical: -4), // 위아래 밀도 조정
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
