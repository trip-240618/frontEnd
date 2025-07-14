import 'package:freezed_annotation/freezed_annotation.dart';

part 'apple_login_request.freezed.dart';
part 'apple_login_request.g.dart';

@freezed
abstract class AppleLoginRequest with _$AppleLoginRequest {
  const factory AppleLoginRequest({
    String? email,
    String? familyName,
    String? givenName,
    required String identityToken,
    required String state,
    required String userIdentifier,
    String? fcmToken,
  }) = _AppleLoginRequest;

  factory AppleLoginRequest.fromJson(Map<String, dynamic> json) => _$AppleLoginRequestFromJson(json);
}
