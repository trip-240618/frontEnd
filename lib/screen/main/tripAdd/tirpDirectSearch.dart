import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/mainState.dart';
import '../../../component/main/typeChoose.dart';
import '../../../component/textForm.dart';
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
        Text('어디로 떠나실 예정이신가요?',style: f16gray400w700,),
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
        Text('여행지를 직접 입력해주세요',style: f16gray400w700,),
        const SizedBox(height: 8),
        TextIconFormFields(
            controller: ms.tripDirectSearchCon,
            hintText: '여행지를 입력해주세요',
            icon: 'assets/icon/pencil.svg'),
      ],
    );
  }
}
