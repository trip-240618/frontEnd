import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/base/base_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/common/text/common_text_form_field.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/view/trip/controllers/location_search_controller.dart';

class LocationSearchView extends StatefulWidget {
  const LocationSearchView({
    super.key,
  });

  @override
  State<LocationSearchView> createState() => _LocationSearchViewState();
}

class _LocationSearchViewState extends State<LocationSearchView> {
  final TextEditingController _placeCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationSearchController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppbar(
            text: "여행 장소 검색",
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "여행 장소",
                  style: context.style.caption1.copyWith(
                    color: context.color.gray600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                  controller: _placeCon,
                  hintText: "여행장소를 지도에 입력해보세요",
                  backgroundColor: context.color.gray50,
                  onFieldSubmitted: (text) => controller.onSearchLocation(text),
                  leading: GestureDetector(
                    onTap: () => controller.onSearchLocation(_placeCon.text),
                    child: SvgIcon(
                      assetPath: IconConstants.search,
                      color: controller.tripRoomInfo?.labelColor.toColor(),
                    ),
                  ),
                ),
                Container(
                  height: context.screenHeight * 0.5,
                  decoration: controller.state.isSearchLocationsEmpty
                      ? null
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(color: context.color.gray200),
                            right: BorderSide(color: context.color.gray200),
                            bottom: BorderSide(color: context.color.gray200),
                          ),
                        ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    thickness: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.state.searchLocationLength,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final searchLocation = controller.state.searchLocations[index];
                        return BaseButton(
                          borderRadius: 0,
                          onTap: () => controller.onLocationPressed(
                            searchLocation.placeId,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: context.color.gray200,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(Icons.location_on_outlined),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.state.getPlaceName(index),
                                            style: context.style.caption1,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            searchLocation.address,
                                            style: context.style.caption2.copyWith(
                                              color: context.color.gray500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.north_west_outlined,
                                      size: 20,
                                      color: context.color.gray400,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: context.color.neutral100,
                                thickness: 2,
                                indent: 50,
                                height: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
