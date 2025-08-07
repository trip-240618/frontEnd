import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/bottom/select_day_bottom_sheet.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/button/tile/leading_icon_tile_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/text/input/error_text_form_field.dart';
import 'package:tripStory/common/text/input/leading_icon_text_form_field.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/domain/entities/air_line_entity.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/flight_search_controller.dart';
import 'package:tripStory/view/trip/models/flight_search_state.dart';

class FlightSearchView extends StatefulWidget {
  const FlightSearchView({
    super.key,
  });

  @override
  State<FlightSearchView> createState() => _FlightSearchViewState();
}

class _FlightSearchViewState extends State<FlightSearchView> {
  DateFormat dateFormatter = DateFormat('yyyy.MM.dd (EEE)', 'ko_KR');
  bool _isFlightNotFound = false;
  TextEditingController _carrierCon = TextEditingController();
  TextEditingController _flightNumCon = TextEditingController();
  FocusNode _focusNode = FocusNode();

  List<Map<String, String>> filteredAirlines = [];
  String? selectedAirline;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _carrierCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<FlightSearchController>(
        builder: (controller) {
          final state = controller.state;

          return Scaffold(
            appBar: AppAppbar(
              text: "항공사 조회",
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "출발일",
                      style: context.style.caption1.copyWith(
                        color: context.color.gray600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    LeadingIconTileButton(
                      text: controller.state.departureDate?.formatDateWithWeekdayKo ?? "",
                      leadingIconPath: IconConstants.calendar,
                      iconColor: controller.tripRoomInfo?.labelColor.toColor(),
                      onTilePressed: () => _showDateBottomSheet(
                        controller.state.departureDate,
                        controller.tripRoomInfo?.startDate ?? DateTime.now(),
                        controller.tripRoomInfo?.endDate ?? DateTime.now(),
                        (selectedDate) => controller.onDateChanged(selectedDate),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "항공사",
                      style: context.style.caption1.copyWith(
                        color: context.color.gray600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    LeadingIconTextFormField(
                      controller: _carrierCon,
                      hintText: "항공사명 또는 코드를 입력해주세요",
                      leadingIconPath: IconConstants.search,
                      backgroundColor: context.color.gray50,
                      onChanged: (text) => controller.onAirLinesSearch(text),
                      focusNode: _focusNode,
                      isFocusOnTapOutside: false,
                      iconColor: controller.tripRoomInfo?.labelColor.toColor(),
                    ),
                    if (_focusNode.hasFocus) ...[
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          border: Border(
                            left: BorderSide(width: 1, color: context.color.gray200),
                            right: BorderSide(width: 1, color: context.color.gray200),
                            bottom: BorderSide(width: 1, color: context.color.gray200),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Text(
                                "주요 항공사",
                                style: context.style.caption1.copyWith(
                                  color: context.color.gray400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.airLineLength,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final airLine = state.airLines[index];

                                return _AirlineRadioTile(
                                  airLine: airLine,
                                  selectedAirLine: state.selectedAirLine,
                                  onChanged: (airLine) {
                                    if (airLine == null) return;
                                    controller.onAirLinesPressed(airLine);
                                    _carrierCon.text = '${airLine.name} (${airLine.code})';
                                    _focusNode.unfocus();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "편명",
                      style: context.style.caption1.copyWith(
                        color: context.color.gray600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ErrorTextFormField(
                      controller: _flightNumCon,
                      hintText: "항공사명 또는 코드를 입력해주세요",
                      errorText: "조회되지 않는 편명입니다",
                      onChanged: (text) => controller.onFlightNumberChanged(text),
                      showError: state.flightSearchStatus == FlightSearchStatus.empty,
                      keyboardType: TextInputType.number,
                      backgroundColor: context.color.gray50,
                      leading: SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgIcon(
                          assetPath: IconConstants.pencil,
                          color: controller.tripRoomInfo?.labelColor.toColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomButton(
              text: "조회하기",
              enabled: state.isValid,
              onTap: () => {},
            ),
          );
        },
      ),
    );
  }

  void _showDateBottomSheet(
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
}

class _AirlineRadioTile extends StatelessWidget {
  final AirLineEntity airLine;
  final AirLineEntity? selectedAirLine;
  final ValueChanged<AirLineEntity?> onChanged;

  const _AirlineRadioTile({
    required this.airLine,
    required this.selectedAirLine,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<AirLineEntity>(
      title: Text(
        "${airLine.name} (${airLine.code})",
        style: context.style.label1Normal.copyWith(
          color: context.color.gray800,
        ),
      ),
      dense: true,
      value: airLine,
      groupValue: selectedAirLine,
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.only(left: 20),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => !states.contains(WidgetState.selected)
            ? context.color.gray400.withValues(alpha: .32)
            : context.color.gray900,
      ),
      onChanged: (airLine) => onChanged(airLine),
    );
  }
}
