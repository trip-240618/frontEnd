import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/common/enum/trip_color.dart';
import 'package:tripStory/common/enum/trip_type.dart';
import 'package:tripStory/services/country_cache_manager.dart';
import 'package:tripStory/view/hoom/model/trip_room_create_state.dart';

class TripRoomsCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final TripRepository _tripRepository;
  final ImagePicker _picker = ImagePicker();
  TripRoomCreateState tripRoomCreateState = TripRoomCreateState();

  TripRoomsCreateController(
    this._tripRepository,
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
      tripRoomCreateState = tripRoomCreateState.copyWith(
        roomImage: XFile(pickedFile.path),
      );
      update();
    }
  }

  void onColorPressed(
    TripColor selectedColor,
  ) {
    tripRoomCreateState = tripRoomCreateState.copyWith(
      selectedColor: selectedColor,
    );
    update();
  }

  void onTypePressed(
    TripType tripType,
  ) {
    tripRoomCreateState = tripRoomCreateState.copyWith(type: tripType);
    update();
  }
}
