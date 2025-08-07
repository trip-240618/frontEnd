import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/button/tile/date_time_tile_button.dart';
import 'package:tripStory/common/button/tile/deleted_tile_button.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/flight_create_controller.dart';
import 'package:tripStory/view/trip/models/flight_create_param.dart';

class FlightCreateView extends GetView<FlightCreateController> {
  final FlightCreateParam param;

  const FlightCreateView({
    super.key,
    required this.param,
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
              text: "${param.flightName} (${param.flightEntity?.airlineNumber})",
              placeholderText: "여행 장소를 지도에 입력해 보세요",
              iconColor: controller.tripRoomInfo?.labelColor.toColor(),
              onTilePressed: () => {},
              onDeletePressed: () => Get.back(),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "출발 일정",
              style: context.style.caption1.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            DateTimeTileButton(
              iconColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.black,
              date: param.flightEntity?.departureDateTime.formatDateWithWeekdayKo ?? "",
              time: param.flightEntity?.departureDateTime.formatTimeKo ?? "",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "출발 공항",
              style: context.style.caption1.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BaseTileButton(
              text: "${param.flightEntity?.departureAirportKr ?? ""} (${param.flightEntity?.departureAirport})",
              tileColor: context.color.gray50,
              borderColor: context.color.gray200,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "도착 일정",
              style: context.style.caption1.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            DateTimeTileButton(
              iconColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.black,
              date: param.flightEntity?.arrivalDateTime.formatDateWithWeekdayKo ?? "",
              time: param.flightEntity?.arrivalDateTime.formatTimeKo ?? "",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "도착 공항",
              style: context.style.caption1.copyWith(
                color: context.color.gray600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BaseTileButton(
              text: "${param.flightEntity?.arrivalAirportKr ?? ""} (${param.flightEntity?.arrivalAirport})",
              tileColor: context.color.gray50,
              borderColor: context.color.gray200,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
          text: "등록 완료",
          onTap: () {
            if (param.flightEntity != null) {
              controller.onSavePressed(param.flightEntity!);
            }
          }),
    );
  }
}
