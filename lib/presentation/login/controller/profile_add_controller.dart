import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/core/constants/regex_constants.dart';
import 'package:tripStory/core/router/routes.dart';
import 'package:tripStory/core/util/helper/file_upload_helper.dart';
import 'package:tripStory/core/util/image_file_util.dart';
import 'package:tripStory/core/util/url_utils.dart';
import 'package:tripStory/data/models/request/file_request.dart';
import 'package:tripStory/data/models/request/register_request.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/domain/usecases/register_user_usecase.dart';
import 'package:tripStory/presentation/login/models/profile_add_state.dart';

class ProfileAddController extends GetxController with GetSingleTickerProviderStateMixin {
  final RegisterUserUsecase _registerUserUsecase;
  final FetchPresignedUrlUsecase _fetchPresignedUrlUsecase;
  ProfileAddState profileAddState = ProfileAddState();
  final ImagePicker _picker = ImagePicker();

  ProfileAddState get state => profileAddState;

  ProfileAddController(
    this._fetchPresignedUrlUsecase,
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

    final registerRequest = RegisterRequest(
      nickname: state.nickName,
      marketing: isMarketing,
      profileImg: originUrl,
      thumbnail: thumbnailUrl,
    );

    final result = await _registerUserUsecase(registerRequest);

    result.fold(
      (error) {},
      (user) {
        Get.offAllNamed(Routes.registerSuccess);
      },
    );
  }
}
