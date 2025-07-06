import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/common/bottom/trip_search_bottom_sheet.dart';
import 'package:tripStory/common/button/color_select_button.dart';
import 'package:tripStory/common/button/icon_text_button.dart';
import 'package:tripStory/common/button/picture_image_button.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/dialog/code_dialog.dart';
import 'package:tripStory/common/text/common_text_form_field.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/hoom/controller/trip_rooms_create_controller.dart';

class TripRoomCreateView extends StatefulWidget {
  const TripRoomCreateView({super.key});

  @override
  State<TripRoomCreateView> createState() => _TripRoomCreateViewState();
}

class _TripRoomCreateViewState extends State<TripRoomCreateView> {
  final _tripRoomsCreateController = Get.find<TripRoomsCreateController>();
  final TextEditingController _tripNameCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tripRoomsCreateController.precacheFlags(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripRoomsCreateController>(builder: (controller) {
      Future.microtask(() {
        final state = controller.state;
        final shouldShowBottomSheet = state.showTripSearchBottomSheet?.consume() ?? false;
        final shouldShowLoading = state.showLoading?.consume() ?? false;
        final inviteCode = state.showCodeDialog?.consume();
        if (!context.mounted) return;

        if (shouldShowLoading) {
          showLoading(context);
        }

        if (shouldShowBottomSheet) {
          TripDestinationBottomSheetContent.show(context).then((tripDestination) {
            if (tripDestination != null) {
              controller.updateDestination(tripDestination);
            }
          });
        }

        if (inviteCode != null) {
          showCodeDialog(context, inviteCode);
        }
      });
      return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(
          text: "여행방 만들기",
          onTap: () => Get.back(),
        ),
        body: Column(
          children: [
            Container(
              color: gray50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    PictureImageButton(
                      onPressed: () => _tripRoomsCreateController.onImagePressed(
                        ImageSource.gallery,
                        context,
                      ),
                      pickedImage: controller.state.roomImage,
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: _tripNameCon,
                      textStyle: f16gray800w600,
                      hintText: "여행방 제목을 입력해주세요 :)",
                      onChanged: (text) => controller.onTextChanged(text),
                      contentPadding: const EdgeInsets.all(16),
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      trailing: Text(
                        "${_tripNameCon.text.length}/15",
                        style: f11Gray400w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "아이콘 컬러",
                        style: f12gray600w600,
                      ),
                      const SizedBox(height: 12),
                      ColorSelectButton(
                        selectedColor: controller.state.selectedColor,
                        onSelected: (tripColor) => controller.onColorPressed(
                          tripColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "여행방 타입",
                        style: f12gray600w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: RoundedBoxButton(
                              onTap: () => controller.onTypePressed(TripType.j),
                              text: "${TripType.j.name.toUpperCase()}형",
                              height: 52,
                              borderRadius: 4,
                              borderColor: controller.state.type == TripType.j ? gray900 : gray200,
                              textStyle: controller.state.type == TripType.j ? f15gray900w600 : f15gray300w600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RoundedBoxButton(
                              onTap: () => controller.onTypePressed(TripType.p),
                              text: "${TripType.p.name.toUpperCase()}형",
                              height: 52,
                              borderRadius: 4,
                              borderColor: controller.state.type == TripType.p ? gray900 : gray200,
                              textStyle: controller.state.type == TripType.p ? f15gray900w600 : f15gray300w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "여행 날짜",
                        style: f12gray600w600,
                      ),
                      const SizedBox(height: 8),
                      IconTextButton(
                        onTap: () => controller.onCalendarPressed(),
                        text: controller.state.tripDateText,
                        textStyle: controller.state.isTripDateEmpty ? f15gray400w500 : f15gray800w500,
                        icon: SvgPicture.asset(
                          "assets/icon/date.svg",
                          fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(
                            controller.state.getColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "여행지",
                        style: f12gray600w600,
                      ),
                      const SizedBox(height: 8),
                      IconTextButton(
                        onTap: () => controller.onTripDestinationPressed(),
                        text: controller.state.tripDestination.isEmpty
                            ? "여행지를 입력해 주세요"
                            : controller.state.tripDestination,
                        textStyle: controller.state.tripDestination.isEmpty ? f15gray400w500 : f15gray800w500,
                        icon: SvgPicture.asset(
                          "assets/icon/search.svg",
                          fit: BoxFit.none,
                          colorFilter: ColorFilter.mode(
                            controller.state.getColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 42,
          ),
          child: RoundedBoxButton(
            height: 60,
            backgroundColor: gray900,
            textStyle: f16Whitew700,
            borderRadius: 4,
            text: "저장",
            onTap: () => controller.onSavePressed(),
            enabled: controller.state.isValid,
          ),
        ),
        // bottomNavigationBar: Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
        //     child: Obx(() => BottomContainer(
        //         onTap: () async {
        //           if (tripName.text.trim().isEmpty || tripType == '' || ms.tripDate.isEmpty || ms.tripDestination == '') {
        //             showOnlyConfirmTapDialog(context, '여행방 정보를 전부 입력해주세요', () {
        //               Get.back();
        //             });
        //           } else {
        //             showLoading(context);
        //             String thumbnailUrl = '';
        //             if (pickedImage != null) {
        //               Map<String, dynamic> thumbnailData = await ms.tripThumbnailUpload(pickedImage!);
        //               thumbnailUrl = thumbnailData['preSignedUrls'][0].toString().split('?')[0];
        //             }
        //             Map<String, dynamic> createData = await ms.createRoom(
        //                 thumbnailUrl,
        //                 tripName.text,
        //                 '0x${colorList[selectedColor].value.toRadixString(16).toUpperCase()}',
        //                 tripType,
        //                 ms.tripDate,
        //                 ms.tripDestination.value);
        //             if (createData.isNotEmpty) {
        //               await ts.getSelectTrip(createData['tripId']);
        //               Get.back();
        //               CodeDialog(context, createData['tripId'], createData['invitationCode']);
        //             }
        //           }
        //         },
        //         title: '저장',
        //         isBlack: ms.tripDate.isEmpty ||
        //                 tripName.text.trim().isEmpty ||
        //                 tripType == '' ||
        //                 ms.tripDestination.value == ''
        //             ? false
        //             : true))),
      );
    });
  }

  void showCodeDialog(
    BuildContext context,
    String inviteCode,
  ) {
    InviteCodeDialog.show(
      context,
      inviteCode: inviteCode,
      onSendPressed: () {},
      onConfirmPressed: () => _tripRoomsCreateController.onNavigateToRoomPressed(),
    );
  }

  @override
  void dispose() {
    _tripNameCon.dispose();
    super.dispose();
  }
}
