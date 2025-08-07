import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/tile/leading_icon_tile_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/text/input/error_text_form_field.dart';
import 'package:tripStory/common/text/input/leading_icon_text_form_field.dart';
import 'package:tripStory/component/bottomContainer.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/domain/entities/air_line_entity.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/controllers/flight_search_controller.dart';

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
      child: Scaffold(
        appBar: AppAppbar(
          text: "항공사 조회",
        ),
        body: GetBuilder<FlightSearchController>(builder: (controller) {
          final state = controller.state;

          return SingleChildScrollView(
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
                    text: "dadadada",
                    leadingIconPath: IconConstants.calendar,
                    iconColor: Colors.black,
                    onTilePressed: () {},
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
                    showError: true,
                    keyboardType: TextInputType.number,
                    backgroundColor: context.color.gray50,
                    leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgIcon(
                        assetPath: IconConstants.pencil,
                        color: context.color.gray700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
          child: BottomContainer(
              onTap: () async {
                if (_carrierCon.text.trim().isEmpty || _flightNumCon.text.trim().isEmpty) {
                  showOnlyConfirmTapDialog(context, '빈칸을 입력해주세요', () {
                    Get.back();
                  });
                } else {
                  showLoading(context);
                  // await js.searchFlight(int.parse(_flightNumCon.text), selectedAirline!);
                  Get.back();
                  // if (js.flightList.isNotEmpty) {
                  //   _isFlightNotFound = false;
                  //   Get.to(() => AddFlight(
                  //         flightName: '${_carrierCon.text}',
                  //       ))?.then((v) => {_flightNumCon.clear(), _carrierCon.clear(), selectedAirline = null});
                  // } else {
                  //   _isFlightNotFound = true;
                  // }
                  setState(() {});
                }
              },
              title: '조회하기',
              isBlack: _carrierCon.text.trim().isEmpty || _flightNumCon.text.trim().isEmpty ? false : true),
        ),
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
        "${airLine.name} ${airLine.code}",
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
