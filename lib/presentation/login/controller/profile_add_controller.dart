import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/core/constants/regex_constants.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/image_file_util.dart';
import 'package:tripStory/domain/usecases/register_user_usecase.dart';
import 'package:tripStory/presentation/login/models/profile_add_state.dart';

class ProfileAddController extends GetxController with GetSingleTickerProviderStateMixin {
  final RegisterUserUsecase _registerUserUsecase;

  ProfileAddState profileAddState = ProfileAddState();
  final ImagePicker _picker = ImagePicker();

  ProfileAddState get state => profileAddState;

  ProfileAddController(
    this._registerUserUsecase,
  );

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

  void onTextChanged(
    String text,
  ) {
    final isValid = RegExp(RegexConstants.nickname).hasMatch(text);

    profileAddState = state.copyWith(
      nickName: text,
      isNicknameValid: isValid,
    );
    update();
  }

  Future<void> onNextPressed(
    bool isMarketing,
  ) async {
    List<int>? thumbnailBytes;
    List<int>? profileBytes;

    if (state.profileImage != null) {
      final bytes = await state.profileImage?.readAsBytes();
      final compressByte = await ImageFileUtil.compressBytes(bytes!);
      profileBytes = bytes;
      thumbnailBytes = compressByte;
    }

    final registerUserParams = RegisterUserParams(
      nickname: state.nickName,
      profileBytes: profileBytes,
      thumbnailBytes: thumbnailBytes,
      isMarketing: isMarketing,
    );

    final result = await _registerUserUsecase.call(registerUserParams);

    result.fold(
      (error) {},
      (user) {
        Get.offAllNamed(Routes.registerSuccess);
      },
    );
  }
}
