import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/text_edit_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/color_select_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/button/picture_image_button.dart';
import 'package:tripStory/presentation/common/container/label_container.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/text/edit/edit_text_form_field.dart';
import 'package:tripStory/presentation/trip/controllers/trip_room_setting_controller.dart';

class TripRoomSettingView extends StatefulWidget {
  const TripRoomSettingView({
    super.key,
  });

  @override
  State<TripRoomSettingView> createState() => _TripRoomSettingViewState();
}

class _TripRoomSettingViewState extends State<TripRoomSettingView> {
  final TextEditingController _tripNameController = TextEditingController();
  final _controller = Get.find<TripRoomSettingController>();

  @override
  void initState() {
    super.initState();
    _tripNameController.text = _controller.tripRoomInfo?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppAppbar(
        text: "여행방 설정",
        backgroundColor: context.color.gray50,
        actionWidget: AppIconButton(
          assetPath: IconConstants.delete,
          onTap: () => showDeleteRoomDialog(
            onConfirm: () => _controller.onRoomDeletePressed(),
          ),
        ),
      ),
      body: GetBuilder<TripRoomSettingController>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                color: context.color.gray50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      PictureImageButton(
                        onPressed: () => controller.onRoomImagePressed(
                          ImageSource.gallery,
                          context,
                        ),
                        pickedImage: controller.state.roomImage,
                        url: controller.tripRoomInfo?.thumbnail ?? "",
                      ),
                      const SizedBox(height: 16),
                      EditTextFormField(
                        controller: _tripNameController,
                        hintText: "여행방 제목을 입력해주세요",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        onChanged: (text) => controller.onTripRoomNameChanged(text),
                        editType: TextEditType.edit,
                        countText: "${controller.state.tripRoomLength}/15",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  color: context.color.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15,
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "아이콘 컬러",
                            style: context.style.caption1.copyWith(
                              color: context.color.gray600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ColorSelectButton(
                            selectedColor: controller.state.selectedColor,
                            onSelected: (tripColor) => controller.onColorPressed(tripColor),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "여행 날짜",
                            style: context.style.caption1.copyWith(
                              color: context.color.gray600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          LabelContainer(
                            label:
                                "${controller.tripRoomInfo?.startDate.formatYMDWithDot()} ~ ${controller.tripRoomInfo?.endDate.formatYMDWithDot()}",
                            backgroundColor: context.color.gray50,
                            leadingIcon: IconConstants.calendar,
                            iconColor: controller.state.getColor,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "여행지",
                            style: context.style.caption1.copyWith(
                              color: context.color.gray600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          LabelContainer(
                            label: controller.tripRoomInfo?.country ?? "",
                            backgroundColor: context.color.gray50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<TripRoomSettingController>(
        builder: (controller) {
          return BottomButton(
            text: "수정 완료",
            enabled: _controller.state.isValid,
            onTap: () => controller.onSettingSavePressed(),
          );
        },
      ),
    );
  }

  void showDeleteRoomDialog({
    required VoidCallback onConfirm,
  }) {
    CommonDialog.showConfirmCancel(
      title: "여행방을 삭제하시겠습니까?",
      message: "삭제 후 복구는 어렵습니다",
      confirmText: "확인",
      onConfirm: onConfirm,
    );
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    super.dispose();
  }
}
