import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/data/models/request/file_request.dart';
import 'package:tripStory/data/models/request/user_modify_request.dart';
import 'package:tripStory/domain/entities/user_entity.dart';
import 'package:tripStory/domain/usecases/edit_user_usecase.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/util/helper/file_upload_helper.dart';
import 'package:tripStory/util/image_file_util.dart';
import 'package:tripStory/util/url_utils.dart';
import 'package:tripStory/view/global/login_user_service.dart';
import 'package:tripStory/view/setting/models/edit_profile_state.dart';

class EditProfileController extends GetxController {
  final LoginUserService _userService;
  final EditUserUsecase _editUserUsecase;
  final FetchPresignedUrlUsecase _fetchPresignedUrlUsecase;

  EditProfileController(
    this._userService,
    this._editUserUsecase,
    this._fetchPresignedUrlUsecase,
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
    bool isValid,
  ) {
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
    String thumbnailUrl = "";
    String originUrl = "";
    if (state.profileImage != null) {
      final result = await _fetchPresignedUrlUsecase.call(
        FileRequest(prefix: "profile", photoCnt: 2),
      );

      await result.fold(
        (error) async {},
        (urlData) async {
          final preSignedUrls = urlData.preSignedUrls;

          thumbnailUrl = UrlUtils.getBaseUrl(preSignedUrls[0]);
          originUrl = UrlUtils.getBaseUrl(preSignedUrls[1]);

          final compressedBytes = await ImageFileUtil.compressImage(state.profileImage!);
          final originalBytes = await state.profileImage!.readAsBytes();

          await Future.wait([
            FileUploadHelper.putUploadImage(url: preSignedUrls[0], fileBytes: compressedBytes),
            FileUploadHelper.putUploadImage(
              url: preSignedUrls[1],
              fileBytes: originalBytes,
            ),
          ]);
        },
      );
    }

    final modifyRequest = UserModifyRequest(
      nickname: state.nickName,
      thumbnail: thumbnailUrl,
      profileImg: originUrl,
      memo: state.introduce,
    );

    final result = await _editUserUsecase(modifyRequest);

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
