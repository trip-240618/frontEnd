enum PermissionState {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  unknown;

  String get label {
    switch (this) {
      case PermissionState.granted:
        return "허용됨";
      case PermissionState.denied:
        return "권한이 거부됨";
      case PermissionState.permanentlyDenied:
        return "영구적으로 거부됨";
      case PermissionState.restricted:
        return "권한이 제한됨";
      case PermissionState.limited:
        return "제한적 접근";
      case PermissionState.unknown:
        return "상태 확인 불가";
    }
  }
}
