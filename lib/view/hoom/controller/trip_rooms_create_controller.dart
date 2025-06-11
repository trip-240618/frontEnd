import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/data/repositories/file_repository.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/common/enum/trip_color.dart';
import 'package:tripStory/common/enum/trip_type.dart';
import 'package:tripStory/services/country_cache_manager.dart';
import 'package:tripStory/util/one_time_event.dart';
import 'package:tripStory/view/hoom/bindings/trip_calendar_binding.dart';
import 'package:tripStory/view/hoom/model/trip_room_create_state.dart';
import 'package:tripStory/view/hoom/views/trip_room_calendar_view.dart';

class TripRoomsCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final TripRepository _tripRepository;
  final FileRepository _fileRepository;
  final ImagePicker _picker = ImagePicker();

  TripRoomCreateState tripRoomCreateState = TripRoomCreateState();

  TripRoomCreateState get state => tripRoomCreateState;

  TripRoomsCreateController(
    this._tripRepository,
    this._fileRepository,
  );

  Future<void> precacheFlags(BuildContext context) async {
    await CountryFlagCacheManager.precacheAll(context);
  }

  /// side Effect
  Future<void> onImagePressed(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final hasPermission = await requestCameraPermission(context);
    if (!hasPermission) return;

    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      tripRoomCreateState = state.copyWith(
        roomImage: XFile(pickedFile.path),
      );
      update();
    }
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
    Get.to(() => TripRoomCalendarView(selectedColor: state.getColor), binding: TripCalendarBinding())?.then((dates) {
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

    // String thumbnailUrl = "";
    if (state.roomImage != null) {
      final thumbnailData = await tripThumbnailUpload(pickedImage!);
      thumbnailUrl = thumbnailData['preSignedUrls'][0].toString().split('?')[0];
    }

    // final createData = await createRoom(
    //   thumbnailUrl,
    //   tripName.text,
    //   '0x${colorList[selectedColor].value.toRadixString(16).toUpperCase()}',
    //   tripType,
    //   tripDate,
    //   tripDestination,
    // );
    //
    // // 로딩 다이얼로그 닫기
    // if (Get.isDialogOpen ?? false) Get.back();
    //
    // if (createData.isNotEmpty) {
    //   await ts.getSelectTrip(createData['tripId']);
    //   CodeDialog(Get.context!, createData['tripId'], createData['invitationCode']);
    // }
  }
}
