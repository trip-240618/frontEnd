import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/view/login/models/profile_add_state.dart';

class ProfileAddController extends GetxController with GetSingleTickerProviderStateMixin {
  ProfileAddState profileAddState = ProfileAddState();
  final ImagePicker _picker = ImagePicker();

  ProfileAddState get state => profileAddState;

  ProfileAddController();

  Future<void> onProfilePressed(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final hasPermission = await requestCameraPermission(context);
    if (!hasPermission) return;

    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      profileAddState = state.copyWith(
        profileImage: XFile(pickedFile.path),
      );
      update();
    }
  }
}
