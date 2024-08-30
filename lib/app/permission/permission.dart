import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../component/dialog/dialog.dart';

/// 권한 요청
Future<bool> requestCameraPermission(BuildContext context) async {
  /// 권한 상태 확인
  PermissionStatus status = await Permission.photos.status;
  if (status.isPermanentlyDenied) {
    /// 사용자가 권한을 '영구적으로 거부'한 경우
    showOnlyConfirmTapDialog(context, '권한을 설정해주시기 바랍니다', () {
      openAppSettings();
      Get.back();
    });
  } else if (status.isLimited) {
    /// 사용자가 권한을 '영구적으로 거부'한 경우
    showOnlyConfirmTapDialog(context, '권한을 설정해주시기 바랍니다', () {
      openAppSettings();
      Get.back();
    });
  }
  /// 권한이 부여되지 않은 경우 요청
  if (!status.isGranted) {
    status = await Permission.photos.request();
    return false;
  } else {
    /// 권한이 부여된 경우
    return true;
  }
}


Future<bool> requestPhotoMangerPermission(BuildContext context) async {
  final ps = await PhotoManager.requestPermissionExtend();
  if (ps.isAuth) {
    // 권한이 이미 승인되었다면 true 반환
    return true;
  } else {
    // 권한이 승인되지 않았다면 설정으로 안내
    await showOnlyConfirmTapDialog(
      context,
      '권한을 설정해주시기 바랍니다',
          () {
        PhotoManager.openSetting();
        Get.back();
      },
    );
    return false;
  }
}