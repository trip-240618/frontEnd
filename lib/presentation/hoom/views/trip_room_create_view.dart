import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/font.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/bottom/trip_search_bottom_sheet.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/color_select_button.dart';
import 'package:tripStory/presentation/common/button/outline/outline_button.dart';
import 'package:tripStory/presentation/common/button/picture_image_button.dart';
import 'package:tripStory/presentation/common/button/tile/leading_icon_tile_button.dart';
import 'package:tripStory/presentation/common/dialog/code_dialog.dart';
import 'package:tripStory/presentation/common/dialog/loading_dialog.dart';
import 'package:tripStory/presentation/common/text/common_text_form_field.dart';
import 'package:tripStory/presentation/hoom/controller/trip_rooms_create_controller.dart';

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
      if (mounted) {
        _tripRoomsCreateController.precacheFlags(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripRoomsCreateController>(
      builder: (controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final state = controller.state;
          final shouldShowBottomSheet = state.showTripSearchBottomSheet?.consume() ?? false;
          final shouldShowLoading = state.showLoading?.consume() ?? false;
          final inviteCode = state.showCodeDialog?.consume();
          if (!context.mounted) return;

          if (shouldShowLoading) {
            LoadingDialog();
          } else {
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
          }

          if (shouldShowBottomSheet) {
            TripDestinationBottomSheetContent.show(context).then((tripDestination) {
              if (tripDestination != null) {
                controller.updateDestination(tripDestination);
              }
            });
          }

          if (inviteCode != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCodeDialog(context, inviteCode);
            });
          }
        });
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppAppbar(
            text: "여행방 만들기",
            backgroundColor: context.color.gray50,
            onTap: () => controller.onBackPressed(),
          ),
          body: Column(
            children: [
              Container(
                color: context.color.gray50,
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
                              child: OutlineButton(
                                label: "${TripType.j.name.toUpperCase()}형",
                                selected: controller.state.type == TripType.j,
                                onPressed: () => controller.onTypePressed(TripType.j),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlineButton(
                                label: "${TripType.p.name.toUpperCase()}형",
                                selected: controller.state.type == TripType.p,
                                onPressed: () => controller.onTypePressed(TripType.p),
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
                        LeadingIconTileButton(
                          text: controller.state.tripDate.isEmpty
                              ? null
                              : "${controller.state.tripDate[0].formatYMDWithHyphen()} ~ ${controller.state.tripDate[1].formatYMDWithHyphen()}",
                          placeholderText: "여행 날짜를 입력해 주세요",
                          leadingIconPath: IconConstants.smallCalendar,
                          iconColor: controller.state.getColor,
                          onTilePressed: () => controller.onCalendarPressed(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "여행지",
                          style: f12gray600w600,
                        ),
                        const SizedBox(height: 8),
                        LeadingIconTileButton(
                          text: controller.state.tripDestination,
                          placeholderText: "여행지를 입력해 주세요",
                          leadingIconPath: IconConstants.search,
                          iconColor: controller.state.getColor,
                          onTilePressed: () => controller.onTripDestinationPressed(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomButton(
            text: "저장",
            enabled: controller.state.isValid,
            onTap: () => controller.onSavePressed(),
          ),
        );
      },
    );
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
