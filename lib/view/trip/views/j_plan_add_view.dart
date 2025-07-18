import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/bottom/select_day_bottom_sheet.dart';
import 'package:tripStory/common/bottom/time_picker_bottom_sheet.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/trip/controllers/j_plan_add_controller.dart';

class JPlanAddView extends StatefulWidget {
  final DateTime selectedDate;

  const JPlanAddView({
    super.key,
    required this.selectedDate,
  });

  @override
  State<JPlanAddView> createState() => _JPlanAddViewState();
}

class _JPlanAddViewState extends State<JPlanAddView> {
  final _tripRoomsCreateController = Get.find<JPlanAddController>();

  TextEditingController planTitleCon = TextEditingController();
  TextEditingController memoCon = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tripRoomsCreateController.init(widget.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JPlanAddController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {});
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppAppbar(
              text: "일정 등록",
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 32, bottom: 44),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 날짜 및 시간
                    Text(
                      '날짜 및 시간*',
                      style: context.style.caption1.copyWith(
                        color: context.color.gray600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.color.gray50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: context.color.gray200,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => showDateBottomSheet(
                                controller.state.selectedDate,
                                controller.tripRoomInfo?.startDate ?? DateTime.now(),
                                controller.tripRoomInfo?.endDate ?? DateTime.now(),
                                (selectedDate) => controller.onDateChanged(selectedDate),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.5),
                                    child: SvgIcon(
                                      assetPath: IconConstants.date,
                                      color: controller.tripRoomInfo?.labelColor.toColor(),
                                    ),
                                  ),
                                  Text(
                                    controller.state.selectedDate?.formatDateWithWeekdayKo ?? "",
                                    style: context.style.body2Normal.copyWith(
                                      color: context.color.gray800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                showTimeBottomSheet(
                                  controller.state.selectedTime ?? DateTime.now(),
                                  (selectedTime) => controller.onTimeChanged(selectedTime),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.5),
                                    child: SvgIcon(
                                      assetPath: IconConstants.time,
                                      color: controller.tripRoomInfo?.labelColor.toColor(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    controller.state.selectedTime?.formatTimeKo ?? "",
                                    style: context.style.body2Normal.copyWith(
                                      color: context.color.gray800,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '여행 장소',
                      style: f12gray600w600,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(() => SearchTripPlace());
                    //     // js.searchLocation.isEmpty ? Get.to(() => SearchTripPlace()) : null;
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: gray50,
                    //       borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(4),
                    //         topRight: Radius.circular(4),
                    //         // bottomLeft: js.searchLocation.isEmpty ? Radius.circular(4) : Radius.zero,
                    //         // bottomRight: js.searchLocation.isEmpty ? Radius.circular(4) : Radius.zero,
                    //       ),
                    //       border: Border.all(color: gray200),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    //       child: Obx(() => js.searchLocation.isEmpty
                    //           ? Row(
                    //         children: [
                    //           SvgPicture.asset(
                    //             'assets/icon/search.svg',
                    //             colorFilter:
                    //             ColorFilter.mode(Color(ts.selectTripList[0]['labelColor']), BlendMode.srcIn),
                    //           ),
                    //           const SizedBox(width: 5),
                    //           Text('여행 장소를 검색해주세요', style: f14Gray500w400),
                    //         ],
                    //       )
                    //           : Row(
                    //         children: [
                    //           Text(
                    //             'dada',
                    //             style: f15gray800w500,
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //           ),
                    //           Spacer(),
                    //           GestureDetector(
                    //             onTap: () {
                    //               // js.searchLocation.value = [];
                    //             },
                    //             child: SvgPicture.asset('assets/icon/smallXRound.svg',
                    //                 fit: BoxFit.none, colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn)),
                    //           )
                    //         ],
                    //       )),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   width: Get.width,
                    //   height: 240,
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       left: BorderSide(color: gray200),
                    //       right: BorderSide(color: gray200),
                    //       bottom: BorderSide(color: gray200),
                    //     ),
                    //     borderRadius:
                    //     BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
                    //   ),
                    //   child: FutureBuilder<BitmapDescriptor>(
                    //     future: MarkerHelper.loadCustomMarker(IconConstants.makerImage),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) return const SizedBox.shrink();
                    //
                    //       return GoogleMap(
                    //         initialCameraPosition: CameraPosition(
                    //           target: LatLng(
                    //             double.parse(js.searchLocation[0]['location']['latitude']),
                    //             double.parse(js.searchLocation[0]['location']['longitude']),
                    //           ),
                    //           zoom: 14.4746,
                    //         ),
                    //         markers: {
                    //           MarkerHelper.createMarker(
                    //             id: js.searchLocation[0]['displayName']['text'],
                    //             position: LatLng(
                    //               double.parse(js.searchLocation[0]['location']['latitude']),
                    //               double.parse(js.searchLocation[0]['location']['longitude']),
                    //             ),
                    //             icon: snapshot.data!,
                    //           )
                    //         },
                    //         myLocationButtonEnabled: false,
                    //         gestureRecognizers: {
                    //           Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// 일정
                    Text(
                      '여행 일정*',
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
                        border: Border.all(color: gray200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormFieldComponent(
                              controller: planTitleCon,
                              hintText: '여행 일정을 작성해 주세요',
                              inputFormatters: [LengthLimitingTextInputFormatter(20)],
                              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40),
                              onChanged: (v) {
                                setState(() {});
                              },
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${planTitleCon.text.length}',
                              style: planTitleCon.text.length > 0 ? f11Gray800w600 : f11Gray400w600,
                            ),
                            Text(
                              '/20 ',
                              style: f11Gray400w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '간편 메모',
                      style: f12gray600w600,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: Get.width,
                      height: 180,
                      decoration: BoxDecoration(
                        color: gray50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: gray200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TextMemoFormFields(
                              controller: memoCon,
                              focusNode: focusNode,
                              hintText: '일정 간편 메모를 이용해 보세요',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              onChanged: (v) {
                                setState(() {});
                              },
                              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 130),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${memoCon.text.length}',
                                  style: memoCon.text.length > 0 ? f11Gray800w600 : f11Gray400w600,
                                ),
                                Text(
                                  '/100 ',
                                  style: f11Gray400w600,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom > 130
                            ? MediaQuery.of(context).viewInsets.bottom - 100
                            : 0),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
                child: BlackBottomContainer(
                    onTap: () async {
                      // if (planTitleCon.text.trim().isEmpty) {
                      //   showOnlyConfirmTapDialog(context, '여행 일정을 작성해주세요', () {
                      //     Get.back();
                      //   });
                      // } else {
                      //   DateTime startDate = DateTime.parse(ts.selectTripList[0]['startDate']);
                      //
                      //   /// 시작 날짜
                      //   DateTime selectedDate = DateTime.parse(js.addDate.value.split(' ')[0].replaceAll('.', '-'));
                      //
                      //   /// 선택된 날짜
                      //   int index = selectedDate.difference(startDate).inDays;
                      //   Map data = {
                      //     "dayAfterStart": index + 1,
                      //     "startTime":
                      //         "${DateFormat('HH:mm', 'ko_KR').format(DateTime.parse('${js.addSelectedDateTime}'))}",
                      //     "title": planTitleCon.text,
                      //     "place": js.searchLocation.isNotEmpty ? js.searchLocation[0]['displayName']['text'] : '',
                      //     "memo": memoCon.text,
                      //     "latitude": js.searchLocation.isNotEmpty ? js.searchLocation[0]['location']['latitude'] : '',
                      //     "longitude": js.searchLocation.isNotEmpty ? js.searchLocation[0]['location']['longitude'] : '',
                      //     "locker": false
                      //   };
                      //   if (js.searchLocation.isNotEmpty) {
                      //     CameraPosition cameraPosition = CameraPosition(
                      //         target: LatLng(js.searchLocation[0]['location']['latitude'],
                      //             js.searchLocation[0]['location']['longitude']),
                      //         zoom: 12);
                      //     final GoogleMapController controller = await js.mapController.future;
                      //     js.latitude.value = js.searchLocation[0]['location']['latitude'];
                      //     js.longitude.value = js.searchLocation[0]['location']['longitude'];
                      //     Timer(Duration(milliseconds: 500), () async {
                      //       await controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
                      //     });
                      //   }
                      //   js.addJPlanList(data);
                      //   Get.back();
                      // }
                    },
                    title: '저장'),
              ),
            ),
          ),
        );
      },
    );
  }

  void showDateBottomSheet(
    DateTime? selectedDate,
    DateTime startDate,
    DateTime endDate,
    void Function(DateTime selectedDate) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.color.white,
      builder: (_) => SelectDayBottomSheet(
        title: "여행 날짜를 선택해 주세요",
        edit: false,
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        onChanged: (value) => onChanged(value),
      ),
    );
  }

  void showTimeBottomSheet(
    DateTime selectedTime,
    void Function(DateTime selectedTime) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TimePickerBottomSheet(
        selectedTime: selectedTime,
        onTimeChanged: (value) => onChanged(value),
      ),
    );
  }

  @override
  void dispose() {
    planTitleCon.dispose();
    memoCon.dispose();
    super.dispose();
  }
}
