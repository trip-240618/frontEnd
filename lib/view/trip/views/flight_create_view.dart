import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/tile/deleted_tile_button.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/font.dart';

class FlightCreateView extends StatelessWidget {
  const FlightCreateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        text: "항공편 등록",
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "항공편명",
              style: context.style.caption1.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            DeletedTileButton(
              text: "",
              placeholderText: "여행 장소를 지도에 입력해 보세요",
              iconColor: Colors.red,
              onTilePressed: () => {},
              onDeletePressed: () => {},
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '출발 일정',
              style: f12gray600w600,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icon/smallDate.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.now())}',
                      style: f15gray800w500,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(
                      'assets/icon/time.svg',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '3131',
                      style: f15gray800w500,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '출발 공항',
              style: f12gray600w600,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '대한항공',
                  style: f15gray800w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '도착 일정',
              style: f12gray600w600,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/smallDate.svg',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${DateFormat('yyyy.MM.dd (EEE)', 'ko_KR').format(DateTime.now())}',
                      style: f15gray800w500,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(
                      'assets/icon/time.svg',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '도착일',
                      style: f15gray800w500,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '도착 공항',
              style: f12gray600w600,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: gray50,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: gray200),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '도착공항',
                  style: f15gray800w500,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
        child: BottomContainer(
            onTap: () async {
              // js.createFlight(widget.flightName);
              Get.back();
              Get.back();
            },
            title: '등록 완료',
            isBlack: true),
      ),
    );
  }
}
