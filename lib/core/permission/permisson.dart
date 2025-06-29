import 'package:permission_handler/permission_handler.dart';
import 'package:tripStory/core/permission/permission_state.dart';
import 'package:tripStory/core/permission/permission_type.dart';

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
      permission = Permission.camera;
      break;
    case PermissionType.microphone:
      permission = Permission.microphone;
      break;
  }

  final status = await permission.status;

  if (status.isGranted) return PermissionState.granted;
  if (status.isDenied) return PermissionState.denied;
  if (status.isPermanentlyDenied) return PermissionState.permanentlyDenied;
  if (status.isRestricted) return PermissionState.restricted;
  if (status.isLimited) return PermissionState.limited;

  return PermissionState.unknown;
}
