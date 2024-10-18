import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import '../../../component/main/typeChoose.dart';
import '../../../component/textForm/textform.dart';
import '../../../util/font.dart';

class TripDirectSearchPage extends StatefulWidget {
  const TripDirectSearchPage({super.key});

  @override
  State<TripDirectSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripDirectSearchPage> {
  final ms = Get.put(MainState());

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
                ms.tripLeaveType.value = '해외';
                setState(() {});
              },value: ms.tripLeaveType.value),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TypeChoose(text: '국내',onTap: (){
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
            icon: 'assets/icon/pencil.svg'),
      ],
    );
  }
}
