import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/common/bottom/select_day_bottom_sheet.dart';
import 'package:tripStory/common/button/bottom_button.dart';
import 'package:tripStory/common/button/tile/leading_icon_tile_button.dart';
import 'package:tripStory/common/dialog/loading_dialog.dart';
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
  final TextEditingController _carrierCon = TextEditingController();
  final TextEditingController _flightNumCon = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
    _flightNumCon.dispose();
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.flightSearchStatus == FlightSearchStatus.loading) {
              showLoadingDialog();
            }
          });
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
                    LeadingIconTileButton(
                      text: state.selectedAirLine != null
                          ? "${state.selectedAirLine?.name} (${state.selectedAirLine?.code})"
                          : "",
                      placeholderText: "항공사명 또는 코드를 입력해주세요",
                      leadingIconPath: IconConstants.search,
                      iconColor: controller.tripRoomInfo?.labelColor.toColor(),
                      onTilePressed: () => {
                        controller.onShowSearchBottomSheet(),
                        _showFlightBottomSheet(),
                      },
                    ),
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
              onTap: () => controller.onBottomPressed(),
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
    SelectDayBottomSheet.show(
      context,
      title: "날짜 선택",
      edit: true,
      startDate: startDate,
      endDate: endDate,
      selectedDate: selectedDate,
      onChanged: (value) => onChanged(value),
    );
  }

  void _showFlightBottomSheet() {
    BaseBottomSheet.show(
      context,
      heightRatio: 0.7,
      _FlightSearchContent(),
    );
  }

  void showLoadingDialog() {
    LoadingDialog.show();
  }
}

class _FlightSearchContent extends StatefulWidget {
  @override
  State<_FlightSearchContent> createState() => _FlightSearchContentState();
}

class _FlightSearchContentState extends State<_FlightSearchContent> {
  final TextEditingController _carrierCon = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlightSearchController>(
      builder: (controller) {
        final state = controller.state;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            children: [
              LeadingIconTextFormField(
                controller: _carrierCon,
                hintText: "항공사명 또는 코드를 입력해주세요",
                leadingIconPath: IconConstants.search,
                backgroundColor: context.color.gray50,
                onChanged: (text) => controller.onAirLinesSearch(text),
                iconColor: controller.tripRoomInfo?.labelColor.toColor(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  border: Border.all(
                    width: 1,
                    color: context.color.gray200,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "항공사",
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
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _carrierCon.dispose();
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
