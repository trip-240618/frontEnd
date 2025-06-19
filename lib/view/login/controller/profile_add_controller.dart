import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/data/models/file_request.dart';
import 'package:tripStory/domain/usecases/fetch_presigned_url_usecase.dart';
import 'package:tripStory/util/compress_image.dart';
import 'package:tripStory/util/helper/file_upload_helper.dart';
import 'package:tripStory/util/url_utils.dart';
import 'package:tripStory/view/login/models/profile_add_state.dart';

class ProfileAddController extends GetxController with GetSingleTickerProviderStateMixin {
  final FetchPresignedUrlUsecase _fetchPresignedUrlUsecase;

  ProfileAddState profileAddState = ProfileAddState();
  final ImagePicker _picker = ImagePicker();

  ProfileAddState get state => profileAddState;

  ProfileAddController(
    this._fetchPresignedUrlUsecase,
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
    bool isValid,
  ) {
    profileAddState = state.copyWith(
      nickName: text,
      isNicknameValid: isValid,
    );
    update();
  }

  Future<void> onNextPressed() async {
    String thumbnailUrl = "";
    if (state.profileImage != null) {
      final result = await _fetchPresignedUrlUsecase.call(
        FileRequest(prefix: "profile", photoCnt: 1),
      );

      await result.fold(
        (error) async {},
        (urlData) async {
          final preSignedUrl = urlData.preSignedUrls.first;
          thumbnailUrl = UrlUtils.getBaseUrl(preSignedUrl);

          final compressedBytes = await compressImage(state.profileImage!);
          await FileUploadHelper.putUploadImage(
            url: preSignedUrl,
            fileBytes: compressedBytes,
          );
        },
      );
    }
  }
}
