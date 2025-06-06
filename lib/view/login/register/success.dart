import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/view/hoom/views/rooms_view.dart';

import '../../../component/bottomContainer.dart';
import '../../../util/font.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 44),
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(color: gray900, shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    'assets/icon/successCheck.svg',
                    fit: BoxFit.none,
                  )),
              const SizedBox(height: 18),
              Text(
                '회원가입을 완료했어요',
                style: f24gray900w700,
              ),
              Spacer(),
              BottomContainer(
                  onTap: () async {
                    Get.offAll(() => TripRoomListView());
                  },
                  title: '다음',
                  isBlack: true),
            ],
          ),
        ),
      ),
    );
  }
}
