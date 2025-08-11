import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/view/modules/trip_room_service.dart';
import 'package:tripStory/view/trip/models/trip_room_setting_state.dart';

class TripRoomSettingController extends GetxController {
  final TripRoomService _tripRoomService;

  TripRoomSettingController(
    this._tripRoomService,
  );

  final ImagePicker _picker = ImagePicker();

  TripRoomEntity? get tripRoomInfo => _tripRoomService.tripRoomEntity;

  TripRoomSettingState _roomSettingState = TripRoomSettingState();

  TripRoomSettingState get state => _roomSettingState;

  @override
  void onInit() {
    super.onInit();
    _roomSettingState = state.copyWith(
      tripRoomName: tripRoomInfo?.name ?? "",
    );
  }

  Future<void> onRoomImagePressed(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final hasPermission = await requestCameraPermission(context);
    if (!hasPermission) return;

    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _roomSettingState = state.copyWith(
        roomImage: XFile(pickedFile.path),
      );
      update();
    }
  }

  void onTripRoomNameChanged(String text) {
    _roomSettingState = state.copyWith(
      tripRoomName: text,
    );
    update();
  }

  void onColorPressed(
    TripColor selectedColor,
  ) {
    _roomSettingState = state.copyWith(
      selectedColor: selectedColor,
    );
    update();
  }
}
