import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/bottom/select_day_bottom_sheet.dart';
import 'package:tripStory/common/bottom/time_picker_bottom_sheet.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/text/common_text_form_field.dart';
import 'package:tripStory/common/text/text_area_form_field.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/domain/entities/location_entity.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/util/helper/maker_helper.dart';
import 'package:tripStory/view/trip/controllers/j_plan_create_controller.dart';

class JPlanCreateView extends StatefulWidget {
  final DateTime selectedDate;

  const JPlanCreateView({
    super.key,
    required this.selectedDate,
  });

  @override
  State<JPlanCreateView> createState() => _JPlanCreateViewState();
}

class _JPlanCreateViewState extends State<JPlanCreateView> {
  final _tripRoomsCreateController = Get.find<JPlanCreateController>();

  final TextEditingController _planTitleCon = TextEditingController();
  final TextEditingController _planMemoCon = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tripRoomsCreateController.init(widget.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JPlanCreateController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppbar(
            text: "일정 등록",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 32,
                bottom: 44,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 날짜 및 시간
                  Text(
                    "날짜 및 시간*",
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
                            onTap: () => showTimeBottomSheet(
                              controller.state.selectedTime ?? DateTime.now(),
                              (selectedTime) => controller.onTimeChanged(selectedTime),
                            ),
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
                    "여행 장소",
                    style: context.style.caption1.copyWith(
                      color: context.color.gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _LocationTile(
                    iconColor: controller.tripRoomInfo?.labelColor.toColor(),
                    locationEntity: controller.state.searchPlace,
                    onTilePressed: () => controller.onLocationPressed(),
                    onDeletePressed: () => controller.onLocationDeletePressed(),
                  ),
                  controller.state.searchPlace != null
                      ? Container(
                          width: Get.width,
                          height: 240,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: context.color.gray200),
                              right: BorderSide(color: context.color.gray200),
                              bottom: BorderSide(color: context.color.gray200),
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                          child: FutureBuilder<BitmapDescriptor>(
                            future: MarkerHelper.loadCustomMarker(IconConstants.makerImage),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              final customIcon = snapshot.data!;
                              return GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    controller.state.searchLatitude,
                                    controller.state.searchLongitude,
                                  ),
                                  zoom: 14.4746,
                                ),
                                markers: {
                                  MarkerHelper.createMarker(
                                    id: controller.state.searchPlace?.displayName ?? "",
                                    position: LatLng(
                                      controller.state.searchLatitude,
                                      controller.state.searchLongitude,
                                    ),
                                    icon: customIcon,
                                  ),
                                },
                                myLocationButtonEnabled: false,
                                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                  Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                                },
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "여행 일정*",
                    style: context.style.caption1.copyWith(
                      color: context.color.gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CommonTextField(
                    controller: _planTitleCon,
                    hintText: "여행 일정을 작성해주세요",
                    backgroundColor: context.color.gray50,
                    onChanged: (text) => controller.onPlanTitleChanged(text),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    trailing: Row(
                      children: [
                        Text(
                          "${controller.state.planTitle.length}",
                          style: controller.state.planTitleEmpty
                              ? context.style.caption2.copyWith(
                                  color: context.color.gray400,
                                )
                              : context.style.caption2,
                        ),
                        Text(
                          "/20",
                          style: context.style.caption2.copyWith(
                            color: context.color.gray400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "간편메모",
                    style: context.style.caption1.copyWith(
                      color: context.color.gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextAreaFormField(
                    controller: _planMemoCon,
                    height: 180,
                    hintText: "자기소개를 작성해 주세요",
                    backgroundColor: context.color.gray50,
                    contentPadding: const EdgeInsets.all(16),
                    maxTextLength: 100,
                    onChanged: (text) => controller.onPlanMemoChanged(text),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                    keyboardType: TextInputType.multiline,
                    scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 44),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomButton(
            text: "저장",
            enabled: controller.state.isValid,
            onTap: () => controller.onPlanSavePressed(),
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
    _planTitleCon.dispose();
    _planMemoCon.dispose();
    super.dispose();
  }
}

class _LocationTile extends StatelessWidget {
  final Color? iconColor;
  final LocationEntity? locationEntity;
  final VoidCallback onTilePressed;
  final VoidCallback onDeletePressed;

  const _LocationTile({
    required this.iconColor,
    required this.locationEntity,
    required this.onTilePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocation = locationEntity != null;

    return BaseTileButton(
      text: hasLocation ? locationEntity?.displayName ?? "" : "여행 장소를 지도에 입력해 보세요",
      textStyle: context.style.body2Normal.copyWith(
        color: hasLocation ? context.color.gray800 : context.color.gray400,
      ),
      onTap: hasLocation ? null : () => onTilePressed(),
      tileColor: context.color.gray50,
      borderColor: context.color.gray200,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      leading: hasLocation
          ? null
          : SizedBox(
              width: 20,
              height: 20,
              child: SvgIcon(
                assetPath: IconConstants.search,
                color: iconColor,
              ),
            ),
      trailing: hasLocation
          ? GestureDetector(
              onTap: () => onDeletePressed(),
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgIcon(
                  assetPath: IconConstants.clear,
                  color: context.color.gray900,
                ),
              ),
            )
          : null,
    );
  }
}
