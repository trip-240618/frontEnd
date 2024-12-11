import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../component/dialog/dialog.dart';
Future<bool> requestCameraPermission(BuildContext context) async {
  PermissionStatus status;

  /// Android의 경우
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final int androidVersion = int.parse(androidInfo.version.release);
    if (androidVersion < 13) {
      status = await Permission.storage.status;
    } else {
      status = await Permission.photos.status;
    }
  } else {
    // iOS의 경우 Photos 권한 확인
    status = await Permission.photos.status;
  }
  /// 권한이 영구적으로 거부된 경우
  if (status.isPermanentlyDenied) {
    showOnlyConfirmTapDialog(context, '권한을 설정해주시기 바랍니다', () {
      openAppSettings();
      Get.back();
    });
    return false;
  }
  /// 권한이 부여되지 않은 경우 요청
  if (!status.isGranted && !status.isLimited) {
    status = Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt < 33
        ? await Permission.storage.request()
        : await Permission.photos.request();

    return status.isGranted || status.isLimited;
  }
  /// 권한이 부여된 경우
  return true;
}



Future<bool> requestPhotoMangerPermission(BuildContext context) async {
  final ps = await PhotoManager.requestPermissionExtend();
  if (ps.isAuth || ps == PermissionState.limited) {
    /// 권한이 이미 승인되었다면 true 반환
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

Future<bool> requestLocationPermission(BuildContext context) async{
  PermissionStatus status = await Permission.location.status;
  if (status.isPermanentlyDenied) {
    /// 사용자가 권한을 '영구적으로 거부'한 경우
    showOnlyConfirmTapDialog(context, '위치 권한을 설정해주시기 바랍니다', () {
      openAppSettings();
      Get.back();
    });
    return false;
  } else if (status.isLimited) {
    /// 권한이 제한된 경우
    showOnlyConfirmTapDialog(context, '위치 권한을 설정해주시기 바랍니다', () {
      openAppSettings();
      Get.back();
    });
    return false;
  }
  if (!status.isGranted) {
    status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }

}