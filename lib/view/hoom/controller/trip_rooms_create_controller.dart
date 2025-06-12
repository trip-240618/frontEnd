import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/data/models/trip_room_create_request.dart';
import 'package:tripStory/app/data/repositories/file_repository.dart';
import 'package:tripStory/app/data/repositories/trip_repository.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/common/enum/trip_color.dart';
import 'package:tripStory/common/enum/trip_type.dart';
import 'package:tripStory/router/routes.dart';
import 'package:tripStory/services/country_cache_manager.dart';
import 'package:tripStory/util/compress_image.dart';
import 'package:tripStory/util/extension/color_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/one_time_event.dart';
import 'package:tripStory/util/url_utils.dart';
import 'package:tripStory/view/hoom/model/trip_room_create_state.dart';
import 'package:tripStory/view/trip/bottomNavigator.dart';

class TripRoomsCreateController extends GetxController with GetSingleTickerProviderStateMixin {
  final TripRepository _tripRepository;
  final FileRepository _fileRepository;
  final ImagePicker _picker = ImagePicker();
  int? tripRoomId;
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

    String thumbnailUrl = "";
    if (state.roomImage != null) {
      final result = await _fileRepository.getFileUrls(
        prefix: "profile",
        photoCnt: 1,
      );

      thumbnailUrl = UrlUtils.getBaseUrl(result.preSignedUrls.first);
      final compressedBytes = await compressImage(state.roomImage!);
      _fileRepository.putUploadImage(url: thumbnailUrl, fileBytes: compressedBytes);
    }

    final tripRoomCreateRequest = TripRoomCreateRequest(
      name: state.title,
      type: state.type?.name ?? "j",
      startDate: state.tripDate.first.formatYMDWithHyphen(),
      endDate: state.tripDate.last.formatYMDWithHyphen(),
      country: state.tripDestination,
      thumbnail: thumbnailUrl,
      labelColor: state.getColor.toJson(),
    );
    final createResult = await _tripRepository.postCreateTrip(tripRoomCreateRequest);
    Get.back();
    tripRoomId = createResult.tripId;
    tripRoomCreateState = state.copyWith(
      showLoading: OneTimeEvent(false),
      showCodeDialog: OneTimeEvent(
        createResult.invitationCode,
      ),
    );
    update();
  }

  void onNavigateToRoomPressed() async {
    Get.back(closeOverlays: true);
    Get.to(() => BottomNavigator());
  }
}
