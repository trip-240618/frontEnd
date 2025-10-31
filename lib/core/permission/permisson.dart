import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart' as photo;
import 'package:tripStory/core/permission/permission_state.dart';
import 'package:tripStory/core/permission/permission_type.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';

Future<PermissionState> getPermissionStatus(
  PermissionType type,
) async {
  late final Permission permission;

  switch (type) {
    case PermissionType.location:
      permission = Permission.location;
      break;
    case PermissionType.notification:
      permission = Permission.notification;
      break;
    case PermissionType.camera:
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final int androidVersion = int.parse(androidInfo.version.release);

        if (androidVersion < 13) {
          permission = Permission.storage;
        } else {
          permission = Permission.camera;
        }
      } else {
        permission = Permission.camera;
      }
      break;
    case PermissionType.photo:
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final int androidVersion = int.parse(androidInfo.version.release);

        if (androidVersion < 13) {
          permission = Permission.storage;
        } else {
          permission = Permission.photos;
        }
      } else {
        permission = Permission.photos;
      }
      break;
    case PermissionType.microphone:
      permission = Permission.microphone;
      break;
    case PermissionType.photoManager:
      final result = await photo.PhotoManager.requestPermissionExtend();
      if (result.isAuth) return PermissionState.granted;

      return PermissionState.denied;
  }

  var status = await permission.status;

  if (status.isPermanentlyDenied) {
    CommonDialog.showConfirm(
      title: "권한을 설정해주시기 바랍니다",
      onConfirm: () => openAppSettings(),
    );
  }

  if (status.isDenied) {
    status = await permission.request();
  }

  if (status.isGranted) return PermissionState.granted;

  if (status.isDenied) return PermissionState.denied;
  if (status.isPermanentlyDenied) return PermissionState.permanentlyDenied;
  if (status.isRestricted) return PermissionState.restricted;
  if (status.isLimited) return PermissionState.limited;

  return PermissionState.unknown;
}
