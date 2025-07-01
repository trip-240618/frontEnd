class RegexConstants {
  /// 영문 + 숫자만 (초대코드)
  static final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]{8}$');

  // 닉네임 regex
  static const String nickname = r'^[a-zA-Z가-힣]{1,8}$';
}
