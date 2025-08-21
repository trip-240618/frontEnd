import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/enum/trip_type.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/extension/color_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/helper/country_flag_helper.dart';
import 'package:tripStory/core/util/image_file_util.dart';
import 'package:tripStory/core/util/one_time_event.dart';
import 'package:tripStory/domain/usecases/create_trip_room_usecase.dart';
import 'package:tripStory/presentation/hoom/model/trip_room_create_state.dart';
import 'package:tripStory/presentation/trip/bottomNavigator.dart';

class TripRoomsCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final CreateTripRoomUseCase _createTripRoomUseCase;

  final ImagePicker _picker = ImagePicker();
  TripRoomCreateState tripRoomCreateState = TripRoomCreateState();

  TripRoomCreateState get state => tripRoomCreateState;

  TripRoomsCreateController(
    this._createTripRoomUseCase,
  );

  Future<void> precacheFlags(BuildContext context) async {
    await CountryFlagHelper.precacheAllRegions(context);
  }

  /// side Effect
  Future<void> onBackPressed() async {
    if (state.roomImage != null) {
      await ImageFileUtil.deleteFile(state.roomImage!);
    }
    Get.back();
  }

  Future<void> onImagePressed(ImageSource imageSource, BuildContext context) async {
    final hasPermission = await requestCameraPermission(context);
    if (!hasPermission) return;

    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile == null) return;

    final newFile = XFile(pickedFile.path);

    await ImageFileUtil.deletePreviousImage(
      previousImage: state.roomImage,
      newImage: newFile,
    );

    tripRoomCreateState = state.copyWith(
      roomImage: XFile(newFile.path),
    );
    update();
  }

  void onTextChanged(
    String title,
  ) {
    tripRoomCreateState = state.copyWith(
      title: title,
    );
    update();
  }

  void onColorPressed(
    TripColor selectedColor,
  ) {
    tripRoomCreateState = state.copyWith(
      selectedColor: selectedColor,
    );
    update();
  }

  void onTypePressed(
    TripType tripType,
  ) {
    tripRoomCreateState = state.copyWith(type: tripType);
    update();
  }

  void onCalendarPressed() {
    Get.toNamed(
      Routes.createRoomCalendar,
      arguments: state.getColor,
    )?.then((dates) {
      if (dates != null) {
        tripRoomCreateState = state.copyWith(tripDate: dates);
        update();
      }
    });
  }

  void onTripDestinationPressed() {
    tripRoomCreateState = state.copyWith(
      showTripSearchBottomSheet: OneTimeEvent(true),
    );
    update();
  }

  void updateDestination(String tripDestination) {
    tripRoomCreateState = state.copyWith(
      tripDestination: tripDestination,
    );
    update();
  }

  Future<void> onSavePressed() async {
    tripRoomCreateState = state.copyWith(
      showLoading: OneTimeEvent(true),
    );
    update();

    List<int>? thumbBytes;

    if (state.roomImage != null) {
      final bytes = await state.roomImage?.readAsBytes();
      final compressByte = await ImageFileUtil.compressBytes(bytes!);
      thumbBytes = compressByte;
    }

    final createTripRoomParams = CreateTripRoomParams(
      name: state.title,
      tripType: state.type ?? TripType.j,
      startDate: state.tripDate.first.formatYMDWithHyphen(),
      endDate: state.tripDate.last.formatYMDWithHyphen(),
      country: state.tripDestination,
      thumbnailBytes: thumbBytes,
      color: state.getColor.toJson(),
    );

    final createResult = await _createTripRoomUseCase.call(createTripRoomParams);

    createResult.fold((error) {
      Get.back();
    }, (createResult) {
      tripRoomCreateState = state.copyWith(
        showLoading: OneTimeEvent(false),
        showCodeDialog: OneTimeEvent(
          createResult.invitationCode,
        ),
      );
      if (state.roomImage != null) ImageFileUtil.deleteFile(state.roomImage!);
      update();
    });
  }

  void onNavigateToRoomPressed() async {
    Get.back(closeOverlays: true);
    Get.to(() => BottomNavigator());
  }
}
