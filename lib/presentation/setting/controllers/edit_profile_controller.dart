import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/core/constants/regex_constants.dart';
import 'package:tripStory/core/util/image_file_util.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/usecases/edit_user_usecase.dart';
import 'package:tripStory/presentation/global/login_user_service.dart';
import 'package:tripStory/presentation/setting/models/edit_profile_state.dart';

class EditProfileController extends GetxController {
  final LoginUserService _userService;
  final EditUserUsecase _editUserUsecase;

  EditProfileController(
    this._userService,
    this._editUserUsecase,
  );

  final ImagePicker _picker = ImagePicker();

  UserEntity? get user => _userService.user;

  EditProfileState _editProfileState = EditProfileState();

  EditProfileState get state => _editProfileState;

  @override
  void onInit() {
    super.onInit();
    _editProfileState = state.copyWith(
      nickName: user?.nickName ?? "",
      introduce: user?.memo ?? "",
    );
    update();
  }

  Future<void> onProfilePressed(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final hasPermission = await requestCameraPermission(context);
    if (!hasPermission) return;

    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _editProfileState = state.copyWith(
        profileImage: XFile(pickedFile.path),
      );
      update();
    }
  }

  void onNickNameChanged(
    String nickName,
  ) {
    final isValid = RegExp(RegexConstants.nickname).hasMatch(nickName);

    _editProfileState = state.copyWith(
      nickName: nickName,
      isNicknameValid: isValid,
    );
    update();
  }

  void onMemoChanged(
    String memo,
  ) {
    _editProfileState = state.copyWith(introduce: memo);
    update();
  }

  Future<void> onSaveProfilePressed() async {
    List<int>? thumbnailBytes;
    List<int>? profileBytes;

    if (state.profileImage != null) {
      final bytes = await state.profileImage?.readAsBytes();
      final compressByte = await ImageFileUtil.compressBytes(bytes!);
      profileBytes = bytes;
      thumbnailBytes = compressByte;
    }

    final editUserParams = EditUserParams(
      nickname: state.nickName,
      memo: state.introduce,
      thumbnail: user?.thumbnail,
      profile: user?.profileImg,
      thumbnailBytes: thumbnailBytes,
      profileBytes: profileBytes,
    );

    final result = await _editUserUsecase.call(editUserParams);

    result.fold(
      (error) {},
      (user) {
        _userService.setUser(user);
        Get.back(
          result: true,
          closeOverlays: true,
        );
      },
    );
  }
}
